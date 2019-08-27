//
//  TIHelper.swift
//  TPLInsurance
//
//  Created by Sajad on 3/2/18.
//  Copyright © 2018 TPLHolding. All rights reserved.
//

import Foundation
import UIKit
class TIHelper {
    static func accessoryViewForTextField(target: Any?, selector: Selector?) -> UIToolbar {
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor.black
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.plain, target: target, action: selector)
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        //let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.Plain, target: self, action: "donePicker")
        
        toolBar.setItems([spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        return toolBar
    }
    
    static func userMobileNumberSavedInDefaults() -> String? {
        return UserDefaults.standard.object(forKey: TIConstant.userMobileNoKey) as? String
    }
    
    static func setUserMobileNumber(_ number : String){
        UserDefaults.standard.set(number, forKey: TIConstant.userMobileNoKey)
        UserDefaults.standard.synchronize()
    }
    
    static func getDeviceToken() -> String? {
        return UserDefaults.standard.object(forKey: TIConstant.deviceTokenKey) as? String
    }
    
    static func setDeviceToken(_ token : String){
        UserDefaults.standard.set(token, forKey: TIConstant.deviceTokenKey)
        UserDefaults.standard.synchronize()
    }
    
    static func getUserName() -> String? {
        return UserDefaults.standard.object(forKey: TIConstant.userNameKey) as? String
    }
    
    static func setUserName(_ token : String){
        UserDefaults.standard.set(token, forKey: TIConstant.userNameKey)
        UserDefaults.standard.synchronize()
    }
    
    static func getUserEmail() -> String? {
        return UserDefaults.standard.object(forKey: TIConstant.userEmailKey) as? String
    }
    
    static func setUserEmail(_ token : String){
        UserDefaults.standard.set(token, forKey: TIConstant.userEmailKey)
        UserDefaults.standard.synchronize()
    }
    
    static func isUserReregistered() -> Bool? {
        return UserDefaults.standard.object(forKey: TIConstant.reRegisteredKey) as? Bool
    }
    
    static func isATICustomer() -> Bool {
        if let isTICostomer = TIHelper.isUserReregistered() {
            return isTICostomer
        }
        return false
    }
    
    static func showAleart(ViewController vc : UIViewController , AleartTitle title : String?, message msg : String?, buttonTitle btnTitle : String?){
        
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: btnTitle, style: UIAlertAction.Style.default, handler: nil))
        vc.present(alert, animated: true, completion: nil)
    }
    

    
    static func showAlert(ViewController vc:UIViewController, AlertTitle title : String?, AlertMessage message: String?, AlertStyle style : UIAlertController.Style? , Actions actions : [UIAlertAction]){
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: style ?? .alert)
    
        for action : UIAlertAction in actions {
            alert.addAction(action)
        }
        vc.present(alert, animated: true, completion: nil)
    }
    
    static func formatedDate(date:String, From inputFormat : String , To outputFormat : String) -> String? {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = inputFormat
        if let nsdate = dateFormatter.date(from: date) {
            dateFormatter.dateFormat = outputFormat
            let outputDate = dateFormatter.string(from: nsdate)
            return outputDate
        }
        else{
            return nil
        }
    }
}

//MARK: - Extension For String

extension String {
    func date(format: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.timeZone = TimeZone.current
        let date = dateFormatter.date(from: self)
        return date
    }
    
//    func getYesterday() -> String{
//        let yesterday = Calendar.current.date(
//            byAdding: .day ,
//            value: -1,
//            to: Date())
//
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = DateFormat.dateOnly
//
//        let yesterdayString = dateFormatter.string(from: yesterday!)
//        print(yesterdayString)
//        return yesterdayString
//
//    }
    
    func isValidEmail(email:String) -> Bool {
        print("validate emilId: \(email)")
        let emailRegEx = "[A-Z0-9a-z.-_]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,3}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        let result = emailTest.evaluate(with: email)
        return result
    }
}

