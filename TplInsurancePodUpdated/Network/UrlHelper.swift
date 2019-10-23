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

    
    struct Helper {
//        static let serverTrustPolicies: [String: ServerTrustPolicy] = [
////            "customer.tpltrakker.com": .pinPublicKeys(
//            "customer.tplinsurance.com": .pinPublicKeys(
//                publicKeys: ServerTrustPolicy.publicKeys(),
//                validateCertificateChain: true,
//                validateHost: true
//            )
//        ]
        
        static let getCities = "\(LiveBaseURL)\(apiString)/Home/GetCity"
        static let getAreas = "\(LiveBaseURL)\(apiString)/Home/GetArea/{CityId}"
        static let getWorkshops = "\(LiveBaseURL)\(apiString)/Home/GetWorkshopList/{CityId}/{AreaId}"
    }
    
    struct Notification {
        static let getNotificationSettings = "\(LiveBaseURL)\(apiString)/Home/GetNotificationSettings"
        static let addNotificationSettings = "\(LiveBaseURL)\(apiString)/Home/AddNotificationSettings"
        static let addNotificationAcceptance = "\(LiveBaseURL)\(apiString)/Home/AddNotificationAcceptance"
    }
    
    struct User {
        static let registerUser = "\(LiveBaseURL)\(apiString)/Home/RegisterUser/"
        static let loginUser = "\(LiveBaseURL)\(apiString)/Home/LoginUser"
        static let getUserProfile = "\(LiveBaseURL)\(apiString)/Home/GetCustomerProfile/"
        static let updateUserProfile = "\(LiveBaseURL)\(apiString)/Home/AddCustomerRequest"
        static let reRegisterUser = "\(LiveBaseURL)\(apiString)/Home/ReRegisterUser"
        
        // MARK: - Customers api
        static let loginCustomer = "\(LiveBaseURL)\(apiString)/Home/LoginCustomer"
        static let registerCustomer = "\(LiveBaseURL)\(apiString)/Home/RegisterCustomer"
        static let changePassword = "\(LiveBaseURL)\(apiString)/Home/ChangePassword"
        static let forgotPassword = "\(LiveBaseURL)\(apiString)/Home/ForgotPassword/{MobileNo}"
        static let addClaim = "\(LiveBaseURL)\(apiString)/Home/AddClaimIntimation"

    }

    struct VehicleServices {
        static let getMaintenanceVehicle = "\(LiveBaseURL)\(apiString)/Home/GetMaintenanceVehicle/"
        static let getMaintenanceSchedule = "\(LiveBaseURL)\(apiString)/Home/GetMaintenanceSchedule/"
        static let addMaintenanceSchedule = "\(LiveBaseURL)\(apiString)/Home/AddMaintenanceSchedule"
        static let addMaintenanceVehicle = "\(LiveBaseURL)\(apiString)/Home/AddMaintenanceVehicle"
    }
    
    struct AutoInusrance {
        static let getAutoPackages = "\(LiveBaseURL)\(apiString)/Home/GetAutoPackages/{InsuranceType}/{MakeId}/{ModelId}/{Variant}/{ModelYear}"
        static let IsClaimExist = "\(LiveBaseURL)\(apiString)/Home/IsClaimExists/{VehicleId}"
        static let getVehicleMake = "\(LiveBaseURL)\(apiString)/Home/GetMakeModelVariant/0/0/0"
        static let getProvince = "\(LiveBaseURL)\(apiString)/Home/GetProvince"
        static let getVehicleModel = "\(LiveBaseURL)\(apiString)/Home/GetMakeModelVariant/{MakeId}/M/{PackageId}"
        static let getVehicleModelVariant = "\(LiveBaseURL)\(apiString)/Home/GetMakeModelVariant/{ModelId}/V/{PackageId}"
        static let getValueAddedFeature = "\(LiveBaseURL)\(apiString)/Home/GetValueAddedFeatures/{ModelId}/{ModelYear}/{PackageId}"
        static let getAutoQoute = "\(LiveBaseURL)\(apiString)/Home/GetAutoQuote/{MobileNo}/{PackageId}/{ModelId}/{Variant}/{ModelYear}/{SumInsured}/{Province}/{VAFlist}"
        static let insertAutoPurposal = "\(LiveBaseURL)\(apiString)/Home/InsertAutoProposal"

        // MARK: - New Api's For UAT
        static let getAutoPackagesDetails = "\(LiveBaseURL)\(apiString)/Home/GetAutoPackageDetail"
        static let getVAF = "\(LiveBaseURL)\(apiString)/Home/GetAutoPackageVAFs"
        static let newGetAutoQoute = "\(LiveBaseURL)\(apiString)/Home/GetAutoQuoteNew/{MobileNo}/{PackageId}/{ModelId}/{Variant}/{ModelYear}/{SumInsured}/{Province}/{VAFlist}"
        static let newInsertAutoPurposal = "\(LiveBaseURL)\(apiString)/Home/InsertAutoProposalNew"
        static let newGetNotification = "\(LiveBaseURL)\(apiString)/Home/GetNotificationList"
        static let getSurveyorAppointment = "\(LiveBaseURL)\(apiString)/Home/AddSurveyorAppointment"
        static let getCnicCode = "\(LiveBaseURL)\(apiString)/Home/RegisterCustomer"
        static let verifyCnicCode = "\(LiveBaseURL)\(apiString)/Home/VerifyCode"
        
        static let vehicleProfile = "\(LiveBaseURL)\(apiString)/Home/VehicleProfile"
        static let getVehicleProfile = "\(LiveBaseURL)\(apiString)/Home/VehicleProfile"
        static let getDamageParts = "\(LiveBaseURL)\(apiString)/Home/GetDamageParts/"
        static let getImageList = "\(LiveBaseURL)\(apiString)/Home/GetImageList/{Type}"
    }
    
    
    struct HomeInusrance {
        static let GetHomePackageDetail = "\(LiveBaseURL)\(apiString)/Home/GetHomePackageDetail"
        static let getHomePackages = "\(LiveBaseURL)\(apiString)/Home/GetHomePackages"
        static let GetHomeQuote = "\(LiveBaseURL)\(apiString)/Home/GetHomeQuote"
        static let InsertHomePurposal = "\(LiveBaseURL)\(apiString)/Home/SubmitHomePolicy"
        static let getPolicyHolderValue = "\(LiveBaseURL)\(apiString)/Home/IsPolicyHolder/{MobileNo}"
        static let checkAppVersionUpdate = "\(LiveBaseURL)\(apiString)/Home/GetAppVersion"

        
        // Home Claim End points
        static let HIGetHomePolicies = "\(LiveBaseURL)\(apiString)/Home/MyHomePolicies/{MobileNo}"
        static let HIGetCitybyCountry = "\(LiveBaseURL)\(apiString)/Home/GetCityByCountry/{CountryID}"
        static let HIGetClaimType = "\(LiveBaseURL)\(apiString)/Home/GetHomeClaimTypes"
        static let HIAddHomeClaim   = "\(LiveBaseURL)\(apiString)/Home/AddHomeClaim"
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
        static let GetTravelPackages = "\(LiveBaseURL)\(apiString)/Home/GetTravelPackageDetail"
        static let GetRelationship = "\(LiveBaseURL)\(apiString)/Home/GetRelationship"
        static let GetTravelRelationship = "\(LiveBaseURL)\(apiString)/Home/GetTravelRelationship/1"
        static let GetTravelType = "\(LiveBaseURL)\(apiString)/Home/GetTravelPackages"
        static let GetTravelDestination = "\(LiveBaseURL)\(apiString)/Home/GetDestination"
        static let GetTravelAgeSlab = "\(LiveBaseURL)\(apiString)/Home/GetAgeBand"
        static let GetTravelQuote = "\(LiveBaseURL)\(apiString)/Home/GetTravelQuote"
        static let InsertTravelPurposal = "\(LiveBaseURL)\(apiString)/Home/InsertTravelProposal"
        
        // Travel Claim End points
        static let TICMyTravelPolicies = "\(LiveBaseURL)\(apiString)/Home/MyTravelPolicies/{MobileNo}"
        static let TICGetDestination = "\(LiveBaseURL)\(apiString)/Home/GetDestination"
        static let TICGetCityByCountry = "\(LiveBaseURL)\(apiString)/Home/GetCityByCountry/{CountryID}"
        static let TICGetTravelClaimTypes   = "\(LiveBaseURL)\(apiString)/Home/GetTravelClaimTypes"
        static let TICAddTravelClaim = "\(LiveBaseURL)\(apiString)/Home/AddTravelClaim"
    }
    
    struct DriverScorecard {
        static let GetDriverStats = "http://103.9.23.42/GuideMe/API/GMApi/GetDriverStats"
        static let GetUBIProduct = "\(LiveBaseURL)\(apiString)/Home/GetUBIProduct"
        static let GetDriverRewardPoints = "\(LiveBaseURL)\(apiString)/Home/GetDriverRewardPoints"
//        static let InsertMobilePurposal = "\(LiveBaseURL)\(apiString)/Home/InsertMobileProposal"
    }
    
    struct MobileInusrance {
        static let GetMobileQuote = "\(LiveBaseURL)\(apiString)/Home/GetMobileQuote"
        static let getMobilePackages = "\(LiveBaseURL)\(apiString)/Home/GetMobilePackages"
        static let InsertMobilePurposal = "\(LiveBaseURL)\(apiString)/Home/InsertMobileProposal"
        static let postFeedback = "\(LiveBaseURL)\(apiString)/Home/ClaimFeedback"
        static let getHelpTypes = "\(LiveBaseURL)\(apiString)/Home/GetHelpType"
        static let contactUs = "\(LiveBaseURL)\(apiString)/Home/ContactUs"
        
        static let myPolicies = "\(LiveBaseURL)\(apiString)/Home/MyPolicies"
        static let GetMobilePolicyDetail = "\(LiveBaseURL)\(apiString)/Home/GetMobilePolicyDetail"
        static let updatePolicy = "\(LiveBaseURL)\(apiString)/Home/UpdatePolicy"
    }

}
