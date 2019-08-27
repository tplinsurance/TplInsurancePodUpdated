//
//  UrlHelper.swift
//  TPLInsurance
//
//  Created by Tahir Raza on 29/01/2019.
//  Copyright © 2019 TPLHolding. All rights reserved.
//

import Foundation
import Alamofire

struct UrlConstants {
    
    
//    https://customer.tplinsurance.com:9081/api/Home/       link send by touseeq on slack for live apis
    
    static let LiveBaseURL = "https://customer.tplinsurance.com:9082/" // Live base url
    static let UATBaseURL = "https://customer.tplinsurance.com:9083/" // Local base url
    static let apiString = "api"
    
//    var serverTrustPolicies = [
//        "customer.tplinsurance.com": .pinCertificates(
//            certificates: ServerTrustPolicy.certificates(),
//            validateCertificateChain: true,validateHost: true),
//        ]

    
    struct Helper {
//        static let serverTrustPolicies: [String: ServerTrustPolicy] = [
////            "customer.tpltrakker.com": .pinPublicKeys(
//            "customer.tplinsurance.com": .pinPublicKeys(
//                publicKeys: ServerTrustPolicy.publicKeys(),
//                validateCertificateChain: true,
//                validateHost: true
//            )
//        ]
        
        static let getCities = "\(UATBaseURL)\(apiString)/Home/GetCity"
        static let getAreas = "\(UATBaseURL)\(apiString)/Home/GetArea/{CityId}"
        static let getWorkshops = "\(UATBaseURL)\(apiString)/Home/GetWorkshopList/{CityId}/{AreaId}"
    }
    
    struct Notification {
        static let getNotificationSettings = "\(UATBaseURL)\(apiString)/Home/GetNotificationSettings"
        static let addNotificationSettings = "\(UATBaseURL)\(apiString)/Home/AddNotificationSettings"
        static let addNotificationAcceptance = "\(UATBaseURL)\(apiString)/Home/AddNotificationAcceptance"
    }
    
    struct User {
        static let registerUser = "\(UATBaseURL)\(apiString)/Home/RegisterUser/"
        static let loginUser = "\(UATBaseURL)\(apiString)/Home/LoginUser"
        static let getUserProfile = "\(UATBaseURL)\(apiString)/Home/GetCustomerProfile/"
        static let updateUserProfile = "\(UATBaseURL)\(apiString)/Home/AddCustomerRequest"
        static let reRegisterUser = "\(UATBaseURL)\(apiString)/Home/ReRegisterUser"
        
        // MARK: - Customers api
        static let loginCustomer = "\(UATBaseURL)\(apiString)/Home/LoginCustomer"
        static let registerCustomer = "\(UATBaseURL)\(apiString)/Home/RegisterCustomer"
        static let changePassword = "\(UATBaseURL)\(apiString)/Home/ChangePassword"
        static let forgotPassword = "\(UATBaseURL)\(apiString)/Home/ForgotPassword/{MobileNo}"
        static let addClaim = "\(UATBaseURL)\(apiString)/Home/AddClaimIntimation"

    }

    struct VehicleServices {
        static let getMaintenanceVehicle = "\(UATBaseURL)\(apiString)/Home/GetMaintenanceVehicle/"
        static let getMaintenanceSchedule = "\(UATBaseURL)\(apiString)/Home/GetMaintenanceSchedule/"
        static let addMaintenanceSchedule = "\(UATBaseURL)\(apiString)/Home/AddMaintenanceSchedule"
        static let addMaintenanceVehicle = "\(UATBaseURL)\(apiString)/Home/AddMaintenanceVehicle"
    }
    
    struct AutoInusrance {
        static let getAutoPackages = "\(UATBaseURL)\(apiString)/Home/GetAutoPackages/{InsuranceType}/{MakeId}/{ModelId}/{Variant}/{ModelYear}"
        static let IsClaimExist = "\(UATBaseURL)\(apiString)/Home/IsClaimExists/{VehicleId}"
        static let getVehicleMake = "\(UATBaseURL)\(apiString)/Home/GetMakeModelVariant/0/0/0"
        static let getProvince = "\(UATBaseURL)\(apiString)/Home/GetProvince"
        static let getVehicleModel = "\(UATBaseURL)\(apiString)/Home/GetMakeModelVariant/{MakeId}/M/{PackageId}"
        static let getVehicleModelVariant = "\(UATBaseURL)\(apiString)/Home/GetMakeModelVariant/{ModelId}/V/{PackageId}"
        static let getValueAddedFeature = "\(UATBaseURL)\(apiString)/Home/GetValueAddedFeatures/{ModelId}/{ModelYear}/{PackageId}"
        static let getAutoQoute = "\(UATBaseURL)\(apiString)/Home/GetAutoQuote/{MobileNo}/{PackageId}/{ModelId}/{Variant}/{ModelYear}/{SumInsured}/{Province}/{VAFlist}"
        static let insertAutoPurposal = "\(UATBaseURL)\(apiString)/Home/InsertAutoProposal"

        // MARK: - New Api's For UAT
        static let getAutoPackagesDetails = "\(UATBaseURL)\(apiString)/Home/GetAutoPackageDetail"
        static let getVAF = "\(UATBaseURL)\(apiString)/Home/GetAutoPackageVAFs"
        static let newGetAutoQoute = "\(UATBaseURL)\(apiString)/Home/GetAutoQuoteNew/{MobileNo}/{PackageId}/{ModelId}/{Variant}/{ModelYear}/{SumInsured}/{Province}/{VAFlist}"
        static let newInsertAutoPurposal = "\(UATBaseURL)\(apiString)/Home/InsertAutoProposalNew"
        static let newGetNotification = "\(UATBaseURL)\(apiString)/Home/GetNotificationList"
        static let getSurveyorAppointment = "\(UATBaseURL)\(apiString)/Home/AddSurveyorAppointment"
        static let getCnicCode = "\(UATBaseURL)\(apiString)/Home/RegisterCustomer"
        static let verifyCnicCode = "\(UATBaseURL)\(apiString)/Home/VerifyCode"
        
        static let vehicleProfile = "\(UATBaseURL)\(apiString)/Home/VehicleProfile"
        static let getVehicleProfile = "\(UATBaseURL)\(apiString)/Home/VehicleProfile"
        static let getDamageParts = "\(UATBaseURL)\(apiString)/Home/GetDamageParts/"
        static let getImageList = "\(UATBaseURL)\(apiString)/Home/GetImageList/{Type}"
    }
    
    
    struct HomeInusrance {
        static let GetHomePackageDetail = "\(UATBaseURL)\(apiString)/Home/GetHomePackageDetail"
        static let getHomePackages = "\(UATBaseURL)\(apiString)/Home/GetHomePackages"
        static let GetHomeQuote = "\(UATBaseURL)\(apiString)/Home/GetHomeQuote"
        static let InsertHomePurposal = "\(UATBaseURL)\(apiString)/Home/SubmitHomePolicy"
        static let getPolicyHolderValue = "\(UATBaseURL)\(apiString)/Home/IsPolicyHolder/{MobileNo}"
        static let checkAppVersionUpdate = "\(UATBaseURL)\(apiString)/Home/GetAppVersion"

        
        // Home Claim End points
        static let HIGetHomePolicies = "\(UATBaseURL)\(apiString)/Home/MyHomePolicies/{MobileNo}"
        static let HIGetCitybyCountry = "\(UATBaseURL)\(apiString)/Home/GetCityByCountry/{CountryID}"
        static let HIGetClaimType = "\(UATBaseURL)\(apiString)/Home/GetHomeClaimTypes"
        static let HIAddHomeClaim   = "\(UATBaseURL)\(apiString)/Home/AddHomeClaim"
    }
    
    struct finja {
        static let Authentication = "https://customer.tplinsurance.com:449/api/finja/Authentication/{MobileNo}"
        static let GenerateToken = "http://172.16.2.183/digitalsalesAPI/Service2.svc/GenerateToken"
        static let GetAmountOfPolicy = "http://172.16.2.183/digitalsalesAPI/Service1.svc/GetAmountOfPolicy"
        static let Payment = "https://customer.tplinsurance.com:449/api/finja/payment"
    }
    
    struct jazzCash {
        static let Payment = "https://customer.tplinsurance.com:4045/api/JazzCash/MobilePayment"
    }
    
    struct TravelInusrance {
        static let GetTravelPackages = "\(UATBaseURL)\(apiString)/Home/GetTravelPackageDetail"
        static let GetRelationship = "\(UATBaseURL)\(apiString)/Home/GetRelationship"
        static let GetTravelRelationship = "\(UATBaseURL)\(apiString)/Home/GetTravelRelationship/1"
        static let GetTravelType = "\(UATBaseURL)\(apiString)/Home/GetTravelPackages"
        static let GetTravelDestination = "\(UATBaseURL)\(apiString)/Home/GetDestination"
        static let GetTravelAgeSlab = "\(UATBaseURL)\(apiString)/Home/GetAgeBand"
        static let GetTravelQuote = "\(UATBaseURL)\(apiString)/Home/GetTravelQuote"
        static let InsertTravelPurposal = "\(UATBaseURL)\(apiString)/Home/InsertTravelProposal"
        
        // Travel Claim End points
        static let TICMyTravelPolicies = "\(UATBaseURL)\(apiString)/Home/MyTravelPolicies/{MobileNo}"
        static let TICGetDestination = "\(UATBaseURL)\(apiString)/Home/GetDestination"
        static let TICGetCityByCountry = "\(UATBaseURL)\(apiString)/Home/GetCityByCountry/{CountryID}"
        static let TICGetTravelClaimTypes   = "\(UATBaseURL)\(apiString)/Home/GetTravelClaimTypes"
        static let TICAddTravelClaim = "\(UATBaseURL)\(apiString)/Home/AddTravelClaim"
    }
    
    struct DriverScorecard {
        static let GetDriverStats = "http://103.9.23.42/GuideMe/API/GMApi/GetDriverStats"
        static let GetUBIProduct = "\(UATBaseURL)\(apiString)/Home/GetUBIProduct"
        static let GetDriverRewardPoints = "\(UATBaseURL)\(apiString)/Home/GetDriverRewardPoints"
//        static let InsertMobilePurposal = "\(UATBaseURL)\(apiString)/Home/InsertMobileProposal"
    }
    
    struct MobileInusrance {
        static let GetMobileQuote = "\(UATBaseURL)\(apiString)/Home/GetMobileQuote"
        static let getMobilePackages = "\(UATBaseURL)\(apiString)/Home/GetMobilePackages"
        static let InsertMobilePurposal = "\(UATBaseURL)\(apiString)/Home/InsertMobileProposal"
        static let postFeedback = "\(UATBaseURL)\(apiString)/Home/ClaimFeedback"
        static let getHelpTypes = "\(UATBaseURL)\(apiString)/Home/GetHelpType"
        static let contactUs = "\(UATBaseURL)\(apiString)/Home/ContactUs"
        
        static let myPolicies = "\(UATBaseURL)\(apiString)/Home/MyPolicies"
        static let GetMobilePolicyDetail = "\(UATBaseURL)\(apiString)/Home/GetMobilePolicyDetail"
        static let updatePolicy = "\(UATBaseURL)\(apiString)/Home/UpdatePolicy"
    }

}
