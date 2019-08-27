//
//  travelInsuranceDataHandler.swift
//  TPLInsurance
//
//  Created by Tahir Raza on 08/12/2018.
//  Copyright © 2018 TPLHolding. All rights reserved.
//

import Foundation
import Alamofire

class travelInsuranceDataHandler{
    
    //varaibale from travel insurance
    var coverage: String?
    var travelTypeSelected: String?
    var travelStartDate: String?
    var travelEndDate: String?
    var destination: String?
    var selectedDestination: TIDestinationModel?
    var studentTution: String?
    //SecondController
    var nameOfInsured: String?
    var email: String?
    var dob: String?
    var passport: String?
    var cnic: String?
    var cityData: String?
    var address: String?
    //Third Controller
    var bName: String?
    var bAddress: String?
    var bCnic: String?
    var bContact: String?
    var bRelation: String?
    var selectedDate: Date?
    var travelPackageDetail: [TravelPackageModel]?
    var yourArray = [familyData]()
    
    //Last orderID from summary page
    var result: [InsuranceProposalModel]?
    
    var Relationships: [TIGetRelationshipModel]?
    var TravelRelationships: [TIGetRelationshipModel]?
    var relation: TIGetRelationshipModel?
    var travelType: [TITravelTypeModel]?
    var destinationArray: [TIDestinationModel]?
    var ageSlabArray: [TIAgeSlabModel]?
//    var HIQuote: [HIQuoteModel]?
    var cities: [City]?
    var TIQuote: [TIQuoteModel]?
//    var sessionManager = SessionManager(serverTrustPolicyManager: ServerTrustPolicyManager(policies: UrlConstants.Helper.serverTrustPolicies))

    var city: City? {
        didSet{
            if city?.Id != oldValue?.Id {
                print("value changed from \(oldValue?.Name) to \(city?.Name)")
            }
        }
    }
    var selectedTravelPackageDetail: TravelPackageModel?
    {
        didSet {
            print("selectedHomePackageDetail: \(selectedTravelPackageDetail?.packageType)")
        }
    }
    func selectedBeneRelationships(at index: Int) {
        relation = Relationships?[index]
    }
    
    func selectedFamilyRelationships(at index: Int) {
        relation = Relationships?[index]
    }
    
    func selectCity(at index: Int) {
        city = cities?[index]
    }
    
    func fetchAndUpdateCities(completionHandler: @escaping (Bool) -> Void) {
        let url = URL(string: UrlConstants.Helper.getCities)!
        YSessionManager.sharedInstance.apiManager()?.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: HeaderClass.shared.getAuthorizedHeader()).responseJSON(completionHandler: { (response) in
            if let data = response.data,
                let cities = City.decodeJsonData(data: data) {
                self.cities = cities
                completionHandler(true)
            } else {
                completionHandler(false)
            }
        })
    }
    
    func TIGetRelationship(completionHandler: @escaping (Bool) -> Void) {
        let url = URL(string: UrlConstants.TravelInusrance.GetRelationship)!
        YSessionManager.sharedInstance.apiManager()?.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: HeaderClass.shared.getAuthorizedHeader()).responseJSON(completionHandler: { (response) in
            if let data = response.data,
                let relationship = TIGetRelationshipModel.decodeJsonData(data: data) {
                self.Relationships = relationship
                print("relationships available are: \(relationship)")
                completionHandler(true)
            } else {
                completionHandler(false)
            }
        })
    }
    
    func TIGetTravelRelationship(completionHandler: @escaping (Bool) -> Void) {
        let url = URL(string: UrlConstants.TravelInusrance.GetTravelRelationship)!
        YSessionManager.sharedInstance.apiManager()?.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: HeaderClass.shared.getAuthorizedHeader()).responseJSON(completionHandler: { (response) in
            if let data = response.data,
                let relationship = TIGetRelationshipModel.decodeJsonData(data: data) {
                self.TravelRelationships = relationship
                print("relationships available are: \(relationship)")
                completionHandler(true)
            } else {
                completionHandler(false)
            }
        })
    }
    
    func TITravelType(completionHandler: @escaping (Bool) -> Void) {
        let url = URL(string: UrlConstants.TravelInusrance.GetTravelType)!
        print(HeaderClass.shared.getAuthorizedHeader())
        YSessionManager.sharedInstance.apiManager()?.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: HeaderClass.shared.getAuthorizedHeader()).responseJSON(completionHandler: { (response) in
            if let data = response.data,
                let travelType = TITravelTypeModel.decodeJsonData(data: data) {
                self.travelType = travelType
                print("travel Types available are: \(travelType)")
                completionHandler(true)
            } else {
                completionHandler(false)
            }
        })
    }
    
    func TIDestination(completionHandler: @escaping (Bool) -> Void) {
        let url = URL(string: UrlConstants.TravelInusrance.GetTravelDestination)!
        YSessionManager.sharedInstance.apiManager()?.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: HeaderClass.shared.getAuthorizedHeader()).responseJSON(completionHandler: { (response) in
            if let data = response.data,
                let destination = TIDestinationModel.decodeJsonData(data: data) {
                self.destinationArray = destination
                print("travel Types available are: \(destination)")
                completionHandler(true)
            } else {
                completionHandler(false)
            }
        })
    }
    
    // MARK: - Api for age slabs Travel insurance
    func TIAgeSlab(TravelType: String, completionHandler: @escaping (Bool) -> Void) {
        let url = URL(string: UrlConstants.TravelInusrance.GetTravelAgeSlab)!
        let param: [String:Any] = ["TravelType": TravelType]
        
        YSessionManager.sharedInstance.apiManager()?.request(url, method: .post, parameters: param, encoding: JSONEncoding.default, headers: HeaderClass.shared.getAuthorizedHeader()).responseJSON(completionHandler: { (response) in
            if let data = response.data,
                let ageSlab = TIAgeSlabModel.decodeJsonData(data: data) {
                self.ageSlabArray = ageSlab
                print("Age Slabs are: \(ageSlab)")
                completionHandler(true)
            } else {
                completionHandler(false)
            }
        })
    }
    
    
    func fetchTravelQoute(MobileNo: String, Coverage: String, TravelType: String, Package_Id: String, StartDate:String, EndDate: String, City: String, Destination_Id: String, DOB: String, Address: String, CNIC:String, Name: String, Email: String, completionHandler: @escaping (Bool,[TIQuoteModel]) -> Void){
        
        let url = URL(string: UrlConstants.TravelInusrance.GetTravelQuote)!
        
        let param: [String:Any] = ["MobileNo": MobileNo,
                                   "Coverage": Coverage,
                                   "TravelType": TravelType,
                                   "PackageId": Package_Id ?? "000",
                                   "StartDate": StartDate,
                                   "EndDate": EndDate,
                                   "City": City,
                                   "Destination_Id": Destination_Id,
                                   "DOB": DOB,
                                   "Address": Address,
                                   "CNIC": CNIC,
                                   "Name": Name,
                                   "Email": Email]
        
        print("Get Travel Quote Params:  \(param)")
        YSessionManager.sharedInstance.apiManager()?.request(url, method: .post, parameters: param, encoding: JSONEncoding.default, headers: HeaderClass.shared.getAuthorizedHeader()).responseJSON { (response) in
            if let data = response.data{
                if let quoteData = TIQuoteModel.decodeJsonData(data: data){
                    print("response is \(quoteData)")
                    completionHandler(true, quoteData)
                }
                else{
                    print("could not get the response")
                    return
                }
                
            }else{
                
            }
            
        }
        
    }
    
    
    
    
    
    func TravelInsurancePackages(Coverage: String, TravelType: String, WithTution: String, StartDate: String, EndDate: String, DOB: String, completionHandler: @escaping (Bool,[TravelPackageModel]) -> Void){

        let url = URL(string: UrlConstants.TravelInusrance.GetTravelPackages)!

        let param: [String:Any] = ["Coverage": Coverage,
                                   "TravelType": TravelType,
                                   "WithTution": WithTution,
                                   "StartDate": StartDate,
                                   "EndDate": EndDate,
                                   "DOB": DOB]

        print(param)

        YSessionManager.sharedInstance.apiManager()?.request(url, method: .post, parameters: param, encoding: JSONEncoding.default, headers: HeaderClass.shared.getAuthorizedHeader()).responseJSON { (response) in
            if let data = response.data{
                let TIPackage = TravelPackageModel.decodeJsonData(data: data)
                print("response is \(TIPackage)")
                completionHandler(true, TIPackage!)

            }else{
                //                completionHandler(false, "failed data is not equal response data")
            }
        }

    }
    
    
    
    
    func TIProposalApi(MobileNo: String, PassportNo: String, BeneficiaryList: String, FamilyList: String, Quote_Id: String, completionHandler: @escaping (Bool,[InsuranceProposalModel]) -> Void){
        
        if let quoteId = TIQuote![0].quote_Id{
            let url = URL(string: UrlConstants.TravelInusrance.InsertTravelPurposal)!
            let params: [String:Any] = [
                "MobileNo" : MobileNo ?? "03453014989",
                "PassportNo" : PassportNo ?? "ABC-1234",
                "BeneficiaryList" : BeneficiaryList ?? "ZAK;centerpoint;42101-1001111-1;03001234567;Male;Brother",
                "FamilyList" : FamilyList ?? "",
                "Quote_Id" : String(describing: quoteId) ]
            
            print(params)
            YSessionManager.sharedInstance.apiManager()?.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: HeaderClass.shared.getAuthorizedHeader()).responseJSON(completionHandler: { (response) in
                
                if let data = response.data{
                    let result = InsuranceProposalModel.decodeJsonData(data: data)
                    self.result = result
                    print("response is \(result![0].OrderID ?? "nil")")
                    completionHandler(true, result!)
                    
                }else{
                }
                //Old Work
//                if let data = response.data,
//                    let jsonParsed = try? JSONSerialization.jsonObject(with: data) as? [[String:Any]],
//                    let jsonObj = jsonParsed {
//                    let dic = jsonObj[0]
//                    if let value = dic["OrderID"] {
//                        self.result = value as! String
//                        print("Result Value  : "+(value as! String))
//                        completionHandler(true, self.result ?? "")
//
//                    }
//                    else{
//                        completionHandler(false, self.result ?? "")
//                    }
//                }
//                else {
//                    completionHandler(false, "JSon not parsed")
//                }
            })
        }
        
    }
    
    
//    func fetchQuoteForTravelNew(completionHandler: @escaping (Bool,String) -> Void){
//        if let selectedPackage = selectedTravelPackageDetail {
//
//            let url = URL(string: TIURL.GetTravelQuote)!
//
//            let param: [String: Any] = ["MobileNo": MobileNo,
//                                        "Coverage": Coverage,
//                                        "TravelType": TravelType,
//                                        "PackageId": Package_Id,
//                                        "StartDate": StartDate,
//                                        "EndDate": EndDate,
//                                        "City": City,
//                                        "Destination_Id": Destination_Id,
//                                        "DOB": DOB,
//                                        "Address": Address,
//                                        "CNIC": CNIC,
//                                        "Name": Name,
//                                        "Email": Email]
//
//            print(param)
//
//            YSessionManager.sharedInstance.apiManager()?.request(url, method: .post, parameters: param, encoding: JSONEncoding.default).responseJSON(completionHandler: { (response) in
//                if let data = response.data {
//                    self.autoVAF = AutoPackageDetail.decodeJsonData(data: data)
//                    print(self.autoVAF)
//                    completionHandler(true, "Successfully data is decoded")
//                }else{
//                    completionHandler(false, "failed with else")
//                }
//
//            })
//
//        }else{
//            print("param passed isnt set")
//        }
//    }
    
//    func fetchHomeQoute(MobileNo: String, Package: String, Address: String, LocationArea: String, City:String, CNIC: String, TenantName: String, TenantCNIC: String, LandLordName: String, LandLordCNIC: String, InsureHomeStructure:String, StructureValue: String, PackageType: String, completionHandler: @escaping (Bool,[HIQuoteModel]) -> Void){
//
//        let url = URL(string: TIURL.GetHomeQuote)!
//
//        let param: [String:Any] = ["MobileNo": MobileNo,
//                                   "Package": Package,
//                                   "Address": Address,
//                                   "LocationArea": LocationArea,
//                                   "City": City,
//                                   "CNIC": CNIC,
//                                   "TenantName": TenantName,
//                                   "TenantCNIC": TenantCNIC,
//                                   "LandLordName": LandLordName,
//                                   "LandLordCNIC": LandLordCNIC,
//                                   "InsureHomeStructure": InsureHomeStructure,
//                                   "StructureValue": StructureValue,
//                                   "PackageType": PackageType]
//
//        print(param)
//
//        YSessionManager.sharedInstance.apiManager()?.request(url, method: .post, parameters: param, encoding: JSONEncoding.default).responseJSON { (response) in
//            if let data = response.data{
//                var quoteData = HIQuoteModel.decodeJsonData(data: data)
//                print("response is \(quoteData)")
//                completionHandler(true, quoteData!)
//
//            }else{
//                //                completionHandler(false, "failed data is not equal response data")
//            }
//        }
//
//
//
//    }
//
//
//    func HIProposalApi(completionHandler: @escaping (Bool,String) -> Void){
//        if let quoteId = HIQuote![0].quoteId{
//            let url = URL(string: TIURL.InsertHomePurposal)!
//            let params: [String:Any] = ["QuoteID" : String(describing: quoteId)]
//
//            print(params)
//            YSessionManager.sharedInstance.apiManager()?.request(url, method: .post, parameters: params, encoding: JSONEncoding.default).responseJSON(completionHandler: { (response) in
//                if let data = response.data,
//                    let jsonParsed = try? JSONSerialization.jsonObject(with: data) as? [[String:Any]],
//                    let jsonObj = jsonParsed {
//                    let dic = jsonObj[0]
//                    var res: String?
//
//                    if let value = dic["OrderID"] {
//                        res = value as! String
//                        print("Result Value  : "+(value as! String))
//                        completionHandler(true, res ?? "")
//                    }
//                    else{
//                        completionHandler(false, res ?? "")
//                    }
//
//                }
//                else {
//                    completionHandler(false, "JSon not parsed")
//                }
//            })
//
//        }
//    }
    
    
}

