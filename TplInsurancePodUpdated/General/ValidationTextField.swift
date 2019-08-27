//
//  ValidationTextField.swift
//  TPLInsurance
//
//  Created by Sajad on 3/9/18.
//  Copyright © 2018 TPLHolding. All rights reserved.
//

import UIKit

enum Validation {
    case email
    case phoneNumber
    case charachterLimit(Int)
    case isEmpty
    case format(Format, Int)
    
    func validate(string: String) -> Bool {
        var isValid = false
        switch self {
        case .charachterLimit(let limit):
            isValid = string.count > limit ? false : true
            break
        case .email:
            isValid = isValidEmail(email: string)
            break
        case .isEmpty:
            isValid = !string.isEmpty
            break
        case .phoneNumber:
            let isLengthValid = string.count == 11 ? true : false
            let isFormatValid = isValidMobileNumber(mobileNo: string)
            if isLengthValid && isFormatValid {
                isValid = true
            }
            else{
                isValid = false
            }
            break
        case .format(let format, let limit):
            switch format {
            case .number:
                let text = string.removingCommaFormat()
                isValid = text.count > limit ? false : true
                break
            case .cnic:
                isValid = string.count == limit ? true : false
                break
            case .cost:
                let text = string.removingCommaFormat()
                isValid = text.count > limit ? false : true
                break
            case .mileage:
                let text = string.removingCommaFormat()
                isValid = text.count > limit ? false : true
                break
            }
        }
        return isValid
    }
    
    private func isValidEmail(email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: email)
    }
    //^https?://
    private func isValidMobileNumber(mobileNo : String) -> Bool {
        let mobileNumRegEx = "03"
        let mobileTest = NSPredicate(format:"SELF BEGINSWITH %@", mobileNumRegEx)
        return mobileTest.evaluate(with: mobileNo)
    }
}

enum Format {
    case number
    case cnic
    case cost
    case mileage
}


class ValidationTextField: UITextField {
    var validations = [Validation]()
    
    var isValidatingLimit: Bool {
        get {
            var isValidating = false
            for validation in validations {
                switch validation {
                case .charachterLimit(_):
                    isValidating = true
                    break
                case .format(_, _):
                    isValidating = true
                    break
                case .email, .isEmpty, .phoneNumber:
                    break
                }
            }
            return isValidating
        }
    }
    
    
    
    func validate() -> Bool {
        if validations.count == 0 {
            NSException(name: NSExceptionName.init("Invalid Validation"), reason: "Field can not be validated without any validations applied", userInfo: nil).raise()
        }
        for validation in validations {
            if !(validation.validate(string: self.text!)) {
                return false
            }
        }
        return true
    }
    
    func validate(with validation: Validation) -> Bool {
        return validation.validate(string: self.text!)
    }
    
    func validateForLength(changingIn range: NSRange, change string:String) -> Bool {
        guard let text = self.text else { return true }
        var lenghValidation: Validation?
        var limit = 0
        if validations.count == 0 {
            NSException(name: NSExceptionName.init("Invalid Validation"), reason: "Field can not be validated without any validations applied", userInfo: nil).raise()
        }
        for validation in validations {
            switch validation {
            case .charachterLimit(let count):
                limit = count
                lenghValidation = validation
                break
            case .format(_, let count):
                limit = count
                lenghValidation = validation
                break
                
            case .email, .isEmpty, .phoneNumber:
                break
                
            }
        }
        
        if (lenghValidation != nil) {
            let newLength = text.count + string.count - range.length
            return newLength <= limit
        } else {
            NSException(name: NSExceptionName.init("Invalid Validation"), reason: "Field does not support length validation", userInfo: nil).raise()
        }
        
        return false
    }
    
    func formatTextOnChange(changingIn range: NSRange, change string: String, format: Format) {
        if let text = self.text {
            switch format {
            case .cnic:
                if !text.isEmpty {
                    
                    var cleanString = text.removeCnicFormat()
                    if cleanString.count >= 13 {
                        let firstIndex = cleanString.index(cleanString.startIndex, offsetBy: 5)
                        cleanString.insert("-", at: firstIndex)
                        let secondIndex = cleanString.index(cleanString.startIndex, offsetBy: 13)
                        cleanString.insert("-", at: secondIndex)
                        self.text = cleanString
                    }
                    else if cleanString.count > 5 {
                        let firstIndex = cleanString.index(cleanString.startIndex, offsetBy: 5)
                        cleanString.insert("-", at: firstIndex)
                        self.text = cleanString
                    }
                    else{
                        self.text = cleanString
                    }
//                    if range.location == 5 || range.location == 13 {
//                        self.text = text + "-"
//                    }
                }
                break
            default:
                break
            }
        }
    }
    
    func formateText(withFormat format: Format) {
        switch format {
        case .number:
            if let intValue = Int(self.text!) {
                self.text = intValue.commaRepresentation
            }
        case .cnic:
            break
        case .cost:
            if let intValue = Int(self.text!) {
                self.text = intValue.commaRepresentation
            }
        case .mileage:
            if let intValue = Int(self.text!) {
                self.text = intValue.commaRepresentation
            }
        }
        
    }
    
    func undoFormatting(format: Format) {
        if let text = self.text {
            switch format {
            case .number:
                self.text = text.removingCommaFormat()
                break
            case .cnic:
                self.text = text.removeCnicFormat()
                break
            case .cost:
                self.text = text.removingCommaFormat()
                break
            case .mileage:
                self.text = text.removingCommaFormat()
                break
            }
        }
    }
}

extension String {
    func removingCommaFormat() -> String {
        return self.replacingOccurrences(of: ",", with: "")
    }
    func removeCnicFormat() -> String {
        return self.replacingOccurrences(of: "-", with: "")
    }
}

extension Int {
    
    private static var commaFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()
    
    internal var commaRepresentation: String {
        return Int.commaFormatter.string(from: NSNumber(value: self)) ?? ""
    }

}
