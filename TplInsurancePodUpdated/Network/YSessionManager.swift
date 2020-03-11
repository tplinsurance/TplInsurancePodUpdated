//
//  YSessionManager.swift
//  TPLInsurance
//
//  Created by Tahir Raza on 18/04/2019.
//  Copyright © 2019 TPLHolding. All rights reserved.
//

import Foundation
import Alamofire
import TrustKit

class YSessionManager: SessionDelegate {
    
    static let sharedInstance = YSessionManager()
    
    private var manager : Session?
    
    func apiManager() -> Session? {
        
        if let instance = self.manager {
            
            return instance
            
        } else {
            // Configuring Alamofire SessionManager.
            let configuration = URLSessionConfiguration.default
            
            self.manager = Session(configuration: configuration)
            /*
            let delegate: Alamofire.SessionDelegate = (self.manager?.delegate)!
            
            delegate.urlSession(<#T##session: URLSession##URLSession#>, task: <#T##URLSessionTask#>, didReceive: <#T##URLAuthenticationChallenge#>, completionHandler: <#T##(URLSession.AuthChallengeDisposition, URLCredential?) -> Void#>)
            
            delegate.taskDidReceiveChallengeWithCompletion = { session, task, challenge,  completionHander in
                print("session is \(session), task is \(task) challenge is \(challenge.protectionSpace.authenticationMethod) and handler is \(completionHander)")
                
                // Call into TrustKit here to do pinning validation
                if TrustKit.sharedInstance().pinningValidator.handle(challenge, completionHandler: completionHander) == false {
                    // TrustKit did not handle this challenge: perhaps it was not for server trust
                    // or the domain was not pinned. Fall back to the default behavior
                    completionHander(.performDefaultHandling, nil)
                }
            }
            
            // Checking the session manager instance.
            if self.manager != nil {
                
                return self.manager
                
            } else {
                
                return nil
                
            }
 */
            return self.manager
        }
    }
    
    func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        // Call into TrustKit here to do pinning validation
        if TrustKit.sharedInstance().pinningValidator.handle(challenge, completionHandler: completionHandler) == false {
            // TrustKit did not handle this challenge: perhaps it was not for server trust
            // or the domain was not pinned. Fall back to the default behavior
            completionHandler(.performDefaultHandling, nil)
        }
    }
}
