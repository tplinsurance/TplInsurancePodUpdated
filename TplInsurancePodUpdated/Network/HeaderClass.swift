//
//  HeaderClass.swift
//  TPLInsurance
//
//  Created by Tahir Raza on 20/03/2019.
//  Copyright © 2019 TPLHolding. All rights reserved.
//

import Foundation
import CommonCrypto

class HeaderClass {
    static let shared = HeaderClass()
    
    let mobileNum = "03328211595"//UserDefaults.standard.object(forKey: TIConstant.userMobileNoKey) as? String
    let mobileNumberPass = "923315"//UserDefaults.standard.object(forKey: TIConstant.userMobileNoPasscode) as? String

    
    private func testCrypt(data:Data, keyData:Data, ivData:Data, operation:Int) -> Data {
        let cryptLength  = size_t(data.count + kCCBlockSizeAES128)
        var cryptData = Data(count:cryptLength)
        
        let keyLength = size_t(kCCKeySizeAES128)
        let options = CCOptions(kCCOptionPKCS7Padding)
        
        
        var numBytesEncrypted :size_t = 0
        
        let cryptStatus = cryptData.withUnsafeMutableBytes {cryptBytes in
            data.withUnsafeBytes {dataBytes in
                ivData.withUnsafeBytes {ivBytes in
                    keyData.withUnsafeBytes {keyBytes in
                        CCCrypt(CCOperation(operation),
                                CCAlgorithm(kCCAlgorithmAES),
                                options,
                                keyBytes, keyLength,
                                ivBytes,
                                dataBytes, data.count,
                                cryptBytes, cryptLength,
                                &numBytesEncrypted)
                    }
                }
            }
        }
        
        if UInt32(cryptStatus) == UInt32(kCCSuccess) {
            cryptData.removeSubrange(numBytesEncrypted..<cryptData.count)
            
        } else {
            print("Error: \(cryptStatus)")
        }
        
        print("This is the cryptData key")
        print(String(data: cryptData, encoding: .utf8))
        return cryptData;
    }
    
    private func getDataForHash(_ mobileNumber: String, passcode: String) -> String {
        
        let mid = mobileNumber.replacingOccurrences(of: "-", with: "")
        let date = Date()
        let calendar = Calendar.autoupdatingCurrent
        let components: DateComponents = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date) //components(, from: date)
        
        let year = components.year
        let month = components.month
        let day = components.day
        let hour = components.hour
        let minute = components.minute
        let second = components.second
        
        //    let str = String(format: "%zd@%zd@%zd@%zd@%zd@%zd", year! * 6, month! * 5, day! * 4, hour! * 3, minute! * 2, second! * 1)
        print("mobile pass is : \(mobileNumberPass)")
        let str = String(format: "%@|%@|%zd@%zd@%zd@%zd@%zd@%zd",mid, mobileNumberPass ?? "", year! * 6, month! * 5, day! * 4, hour! * 3, minute! * 2, second! * 1)
        print("This is the key structure")
        print(str)
        return str
    }
    
    func getAuthorizedHeader() -> [String:String] {
        let message     = getDataForHash(mobileNum ?? "", passcode: mobileNumberPass ?? "")//"03018582396|pass|12108@50@48@30@76@3"
        let messageData = message.data(using:String.Encoding.utf8)!
        let keyData     = "tpl786110*".data(using:String.Encoding.utf8)!
        let ivData      = "tpl786110*".data(using:String.Encoding.utf8)!
        
        let encryptedData = testCrypt(data:messageData,   keyData:keyData, ivData:ivData, operation:kCCEncrypt)
        let encryptedID = encryptedData.base64EncodedString(options: .lineLength64Characters)
        return ["Securelogin" : encryptedID]
//       // print(encryptedID)
//        let decryptedData = testCrypt(data:encryptedData, keyData:keyData, ivData:ivData, operation:kCCDecrypt)
//        var decrypted     = String(bytes:decryptedData, encoding:String.Encoding.utf8)!
        
    }
    
    
    
    // MARK: - For Register user only :P
    func getAuthorizedHeaderForReg(_ mobNumberForReg: String) -> [String:String] {
        let message     = getDataForHashForReg(mobNumberForReg)//"03018582396|pass|12108@50@48@30@76@3"
        let messageData = message.data(using:String.Encoding.utf8)!
        let keyData     = "tpl786110*".data(using:String.Encoding.utf8)!
        let ivData      = "tpl786110*".data(using:String.Encoding.utf8)!
        
        let encryptedData = testCrypt(data:messageData,   keyData:keyData, ivData:ivData, operation:kCCEncrypt)
        let encryptedID = encryptedData.base64EncodedString(options: .lineLength64Characters)
        return ["Securelogin" : encryptedID]
        //       // print(encryptedID)
        //        let decryptedData = testCrypt(data:encryptedData, keyData:keyData, ivData:ivData, operation:kCCDecrypt)
        //        var decrypted     = String(bytes:decryptedData, encoding:String.Encoding.utf8)!
        
    }
    
    private func getDataForHashForReg(_ mobileNumber: String) -> String {
        
        let mid = mobileNumber.replacingOccurrences(of: "-", with: "")
        let date = Date()
        let calendar = Calendar.autoupdatingCurrent
        let components: DateComponents = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date) //components(, from: date)
        
        let year = components.year
        let month = components.month
        let day = components.day
        let hour = components.hour
        let minute = components.minute
        let second = components.second
        
        //    let str = String(format: "%zd@%zd@%zd@%zd@%zd@%zd", year! * 6, month! * 5, day! * 4, hour! * 3, minute! * 2, second! * 1)
        print("mobile pass is : \(mobileNumber)")
        let str = String(format: "%@|%zd@%zd@%zd@%zd@%zd@%zd",mid, year! * 6, month! * 5, day! * 4, hour! * 3, minute! * 2, second! * 1)
        print("This is the key structure")
        print(str)
        return str
    }
    
    // MARK: - For Login verification of user only :P
    func getAuthorizedHeaderForVerification(_ mobNumberForVerification: String, mobNumbePasscoderForVerification: String) -> [String:String] {
        let message     = getDataForHashForVerification(mobNumberForVerification, passcode: mobNumbePasscoderForVerification)//"03018582396|pass|12108@50@48@30@76@3"
        let messageData = message.data(using:String.Encoding.utf8)!
        let keyData     = "tpl786110*".data(using:String.Encoding.utf8)!
        let ivData      = "tpl786110*".data(using:String.Encoding.utf8)!
        
        let encryptedData = testCrypt(data:messageData,   keyData:keyData, ivData:ivData, operation:kCCEncrypt)
        let encryptedID = encryptedData.base64EncodedString(options: .lineLength64Characters)
        print("Securelogin : \(encryptedID)")
        return ["Securelogin" : encryptedID]
        //       // print(encryptedID)
        //        let decryptedData = testCrypt(data:encryptedData, keyData:keyData, ivData:ivData, operation:kCCDecrypt)
        //        var decrypted     = String(bytes:decryptedData, encoding:String.Encoding.utf8)!
        
    }
    
    private func getDataForHashForVerification(_ mobileNumber: String, passcode: String) -> String {
        
        let mid = mobileNumber.replacingOccurrences(of: "-", with: "")
        let date = Date()
        let calendar = Calendar.autoupdatingCurrent
        let components: DateComponents = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date) //components(, from: date)
        
        let year = components.year
        let month = components.month
        let day = components.day
        let hour = components.hour
        let minute = components.minute
        let second = components.second
        
        //    let str = String(format: "%zd@%zd@%zd@%zd@%zd@%zd", year! * 6, month! * 5, day! * 4, hour! * 3, minute! * 2, second! * 1)
        print("mobile pass is : \(passcode)")
        let str = String(format: "%@|%@|%zd@%zd@%zd@%zd@%zd@%zd",mid, passcode, year! * 6, month! * 5, day! * 4, hour! * 3, minute! * 2, second! * 1)

        print("This is the key structure")
        print(str)
        return str
    }
    
    
    
}
