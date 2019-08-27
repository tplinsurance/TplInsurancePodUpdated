//
//  TIConstant.swift
//  TPLInsurance
//
//  Created by Sajad on 2/19/18.
//  Copyright © 2018 TPLHolding. All rights reserved.
//

import Foundation
struct TIConstant {
    static let userLoginKey = "userLoginKey"
    static let userMobileNoKey = "userMobileNoKey"
    static let userMobileNoPasscode = "userMobileNoPasscode"
    static let userProfileKey = "userProfileKey"
    static let reRegisteredKey = "reregisterKey"
    static let policyHolderKey = "isPolicyHolder"
    static let tIRegistrationNotification = "tIRegistrationNotification"
    static let deviceTokenKey = "deviceTokenKey"
    static let userNameKey = "userNameKey"
    static let userEmailKey = "userEmailKey"
}

struct TIDateFormats {
    static let visualFormat = "dd MMMM,yyyy"
    static let surveyFormat = "yyyy/MM/dd"
    static let claimCardFormat = "MMM d, yyyy"
    static let webOutgoingFormat = "MM/dd/yyyy"
    static let webIncommingFormat = "yyyy-MM-dd'T'HH:mm:ss"
    static let webOutgoingClaimsFormat = "yyyy/MM/dd"
}

struct LayoutConstants {
    static let menuItemHeight = 60.0
}

struct StringsLengths {
    static let phoneNumber: Int = 11
    static let name: Int = 45
    static let sum: Int = 7
    static let regNumber: Int = 10
    static let address: Int = 150
    static let cnic: Int = 15
    static let email: Int = 45
    static let partNo: Int = 50
    static let vehicleMake: Int = 25
    static let serviceType: Int = 50
    static let serviceCost: Int = 5
    static let serviceNotes: Int = 100
    static let serviceMileage: Int = 8
    static let feedback: Int = 200
    
}

struct TIPlaceHolders {
    static let policySelection = "Select Policy Number"
    static let vehicleSelection = "Select Vehicle"
    static let citySelection = "Select City"
    
}
