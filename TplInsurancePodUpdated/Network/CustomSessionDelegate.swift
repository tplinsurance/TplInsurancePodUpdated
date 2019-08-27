//
//  CustomSessionDelegate.swift
//  TPLInsurance
//
//  Created by Tahir Raza on 08/04/2019.
//  Copyright © 2019 TPLHolding. All rights reserved.
//

import Foundation
import Alamofire
import TrustKit

class CustomSessionDelegate: SessionDelegate {
    
    // Note that this is the almost the same implementation as in the ViewController.swift
    override init() {
        super.init()
        
        // Alamofire uses a block var here
        sessionDidReceiveChallengeWithCompletion = { session, challenge, completion in
            guard let trust = challenge.protectionSpace.serverTrust, SecTrustGetCertificateCount(trust) > 0 else {
                // This case will probably get handled by ATS, but still...
                completion(.cancelAuthenticationChallenge, nil)
                return
            }
            if TrustKit.sharedInstance().pinningValidator.handle(challenge, completionHandler: completion) {
                
                if let serverCertificate = SecTrustGetCertificateAtIndex(trust, 0), let serverCertificateKey = CustomSessionDelegate.publicKey(for: serverCertificate) {
                    if CustomSessionDelegate.pinnedKeys().contains(serverCertificateKey) {
                        completion(.useCredential, URLCredential(trust: trust))
                        return
                    }
                }
            }
            
//            // Call into TrustKit here to do pinning validation
//            if TrustKit.sharedInstance().pinningValidator.handle(challenge, completionHandler: completionHandler) == false {
//                // TrustKit did not handle this challenge: perhaps it was not for server trust
//                // or the domain was not pinned. Fall back to the default behavior
//                completionHandler(.performDefaultHandling, nil)
//            }
            
            // Compare the server certificate with our own stored
//            if let serverCertificate = SecTrustGetCertificateAtIndex(trust, 0) {
//                let serverCertificateData = SecCertificateCopyData(serverCertificate) as Data
//
//                if CustomSessionDelegate.pinnedCertificates().contains(serverCertificateData) {
//                    completion(.useCredential, URLCredential(trust: trust))
//                    return
//                }
//            }
            // Or, compare the public keys

            
            completion(.cancelAuthenticationChallenge, nil)
        }
 
    }
    
    private static func pinnedCertificates() -> [Data] {
        var certificates: [Data] = []
        
        if let pinnedCertificateURL = Bundle.main.url(forResource: "infinumco", withExtension: "crt") {
            do {
                let pinnedCertificateData = try Data(contentsOf: pinnedCertificateURL)
                certificates.append(pinnedCertificateData)
            } catch (_) {
                // Handle error
            }
        }
        
        return certificates
    }
    
    private static func pinnedKeys() -> [SecKey] {
        var publicKeys: [SecKey] = []
        
        if let pinnedCertificateURL = Bundle.main.url(forResource: "infinumco", withExtension: "crt") {
            do {
                let pinnedCertificateData = try Data(contentsOf: pinnedCertificateURL) as CFData
                if let pinnedCertificate = SecCertificateCreateWithData(nil, pinnedCertificateData), let key = publicKey(for: pinnedCertificate) {
                    publicKeys.append(key)
                }
            } catch (_) {
                // Handle error
            }
        }
        
        return publicKeys
    }
    
    // Implementation from Alamofire
    private static func publicKey(for certificate: SecCertificate) -> SecKey? {
        var publicKey: SecKey?
        
        let policy = SecPolicyCreateBasicX509()
        var trust: SecTrust?
        let trustCreationStatus = SecTrustCreateWithCertificates(certificate, policy, &trust)
        
        if let trust = trust, trustCreationStatus == errSecSuccess {
            publicKey = SecTrustCopyPublicKey(trust)
        }
        
        return publicKey
    }

    override func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        // Call into TrustKit here to do pinning validation
        if TrustKit.sharedInstance().pinningValidator.handle(challenge, completionHandler: completionHandler) == false {
            // TrustKit did not handle this challenge: perhaps it was not for server trust
            // or the domain was not pinned. Fall back to the default behavior
            completionHandler(.performDefaultHandling, nil)
        }
    }
}
