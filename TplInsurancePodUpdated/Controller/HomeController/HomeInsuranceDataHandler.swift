
//  HomeInsuranceDataHandler.swift

//  TPLInsurance

//

//  Created by Tahir Raza on 06/12/2018.

//  Copyright © 2018 TPLHolding. All rights reserved.

//


import Foundation
import Alamofire

class HomeInsuranceDataHandler{
    
    var homePackages: [homeInsuranceModel]?
    
    var HIQuote: [HIQuoteModel]?
    var HomeQuoteObj: [NewHomeQuoteModel]?
    var name: String?
    var email: String?
    var DOB: String?
    var homePackagesDetail: [HomeInsurancePackageDetailModel]?
    var type: String?
    var cnic: String?
    var address: String?
    var cityResidence: String?
    var residentialArea: String?
    var tenantsName: String?
    var tenantsCnic: String?
    var landlordsName: String?
    var landlordsCnic: String?
    var homeInsured: String?
    var homeValue: String?
    var homePackageDetail: [HomeInsurancePackageDetailModel]?
//    var authenticationData: FinjaAuthenticationModel?
    var authenticationToken: GenerateToken?
    var PolicyAmount: GetAmountOfPolicyModel?
    var orderID: String?
//    var finjaPaymentData: [FinjaAuthenticationModel]?
    var HIresult: [InsuranceProposalModel]?
    
    var sessionManager = SessionManager()
    let customSessionDelegate = CustomSessionDelegate()
    
    var selectedHomePackageDetail: HomeInsurancePackageDetailModel?
    {
        didSet {
            print("selectedHomePackageDetail: \(selectedHomePackageDetail?.shortDescription)")
        }
    }
    
    var cities: [City]?
    var areas: [Area]?
    
    var city: City? {
        
        didSet{
            
            if city?.Id != oldValue?.Id {
                areas = nil
                area = nil
                
                //                NotificationCenter.default.post(name: Notification.Name(notificationIdentifierUIUpdate), object: nil, userInfo: [changedFieldNameKey:"City"])
            }
        }
    }
    
    var area: Area?{
        didSet{
            if city?.Id != oldValue?.Id {
            }
        }
    }
    
    func fetchAndUpdateHomePackage(completionHandler: @escaping (Bool) -> Void) {
        
        let url = URL(string: UrlConstants.HomeInusrance.getHomePackages)!
        
//        let serverTrustPolicies: [String: ServerTrustPolicy] = [
//            "infinum.co": .pinPublicKeys(
//                publicKeys: ServerTrustPolicy.publicKeys(),
//                validateCertificateChain: true,
//                validateHost: true
//            )
//        ]
//
//        sessionManager = SessionManager(
//            serverTrustPolicyManager: CustomServerTrustPolicyManager(
//                policies: serverTrustPolicies
//            )
//        )
        
//        var sessionManager = SessionManager(serverTrustPolicyManager: ServerTrustPolicyManager(policies: UrlConstants.Helper.serverTrustPolicies))

//
//        sessionManager.request("https://infinum.co").response { response in
//            self.showResult(success: response.response != nil)
//        }

        
        YSessionManager.sharedInstance.apiManager()?.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: HeaderClass.shared.getAuthorizedHeader()).responseJSON(completionHandler: { (response) in
            if let data = response.data,
                let packages = homeInsuranceModel.decodeJsonData(data: data) {
                self.homePackages = packages
                print("Packages available are: \(packages)")
                completionHandler(true)
                
            } else {
                completionHandler(false)
            }
        })
    }
    
    
    func HomeInsurancePackages(Name: String, SumInsured: String, completionHandler: @escaping (Bool,[HomeInsurancePackageDetailModel]) -> Void){
        
        let url = URL(string: UrlConstants.HomeInusrance.GetHomePackageDetail)!
        
        let param: [String:Any] = ["Name": Name,"SumInsured": SumInsured]
        
        print(param)
        YSessionManager.sharedInstance.apiManager()?.request(url, method: .post, parameters: param, encoding: JSONEncoding.default, headers: HeaderClass.shared.getAuthorizedHeader()).responseJSON { (response) in
            if let data = response.data{
                let HIDetails = HomeInsurancePackageDetailModel.decodeJsonData(data: data)
                self.homePackagesDetail = HIDetails
                print("response is \(HIDetails)")
                completionHandler(true, HIDetails!)
                
            }else{
            }
        }
    }
    
    func HIPackagesViewController(Name: String, SumInsured: String, completionHandler: @escaping (Bool,[HomeInsurancePackageDetailModel]) -> Void){
        
        let url = URL(string: UrlConstants.HomeInusrance.GetHomePackageDetail)!
        
        let param: [String:Any] = ["Name": Name,
                                   "SumInsured": SumInsured]
        
        print(param)
        
        YSessionManager.sharedInstance.apiManager()?.request(url, method: .post, parameters: param, encoding: JSONEncoding.default, headers: HeaderClass.shared.getAuthorizedHeader()).responseJSON { (response) in
            if let data = response.data{
                let HIDetails = HomeInsurancePackageDetailModel.decodeJsonData(data: data)
                
                print("response is \(HIDetails)")
                completionHandler(true, HIDetails!)
                
            }else{
                //                completionHandler(false, "failed data is not equal response data")
            }
        }
        
    }
    
    func fetchPackagesForHI(completionHandler: @escaping (Bool) -> Void) {
        
        let url = URL(string: UrlConstants.MobileInusrance.getMobilePackages)!
        
        let param: [String:Any] = ["Name": "Name","SumInsured": "0"]
        YSessionManager.sharedInstance.apiManager()?.request(url, method: .post, parameters: param, encoding: JSONEncoding.default, headers: HeaderClass.shared.getAuthorizedHeader()).responseJSON(completionHandler: { (response) in
            
            if let data = response.data,
                let packages = HomeInsurancePackageDetailModel.decodeJsonData(data: data) {
                print("Packages available are: \(packages)")
                completionHandler(true)
                
            } else {
                
                completionHandler(false)
                
            }
            
        })
        
    }
    
    func fetchHomeQoute(Name: String, MobileNo: String, Package: String, Address: String, LocationArea: String, City:String, CNIC: String, TenantName: String, TenantCNIC: String, LandLordName: String, LandLordCNIC: String, InsureHomeStructure:String, StructureValue: String, PackageType: String, DOB: String, Email: String, completionHandler: @escaping (Bool,[HIQuoteModel]) -> Void){
        
        let url = URL(string: UrlConstants.HomeInusrance.GetHomeQuote)!
        
        let param: [String:Any] = ["Name": Name,
                                   "MobileNo": MobileNo,
                                   "Package": Package,
                                   "Address": Address,
                                   "LocationArea": LocationArea,
                                   "City": City,
                                   "CNIC": CNIC,
                                   "TenantName": TenantName,
                                   "TenantCNIC": TenantCNIC,
                                   "LandLordName": LandLordName,
                                   "LandLordCNIC": LandLordCNIC,
                                   "InsureHomeStructure": InsureHomeStructure,
                                   "StructureValue": StructureValue,
                                   "PackageType": PackageType,
                                   "DOB" : DOB,
                                   "Email" : Email]
        
        print(param)
        print(url)
        //        YSessionManager.sharedInstance.apiManager()?.request(url, method: .post, parameters: param, encoding: JSONEncoding.default).responseJSON(completionHandler: { (response) in
        YSessionManager.sharedInstance.apiManager()?.request(url, method: .post, parameters: param, encoding: JSONEncoding.default, headers: HeaderClass.shared.getAuthorizedHeader()).responseJSON { (response) in
            if let data = response.data{
                if let quoteData = HIQuoteModel.decodeJsonData(data: data){
                    print("response is \(quoteData)")
                    completionHandler(true, quoteData)
                }
                else{
                    print("could not get the response")
                    return
                    //                    completionHandler(false,nil)
                }
                
            }else{
                
                //                completionHandler(false, "failed data is not equal response data")
                
            }
            
        }
        
    }
    
    
    func HIProposalApi(completionHandler: @escaping (Bool,String) -> Void){
        
        if let quoteId = HIQuote![0].quoteId{
            let url = URL(string: UrlConstants.HomeInusrance.InsertHomePurposal)!
            let params: [String:Any] = ["QuoteID" : String(describing: quoteId)]
            
            print(params)
            YSessionManager.sharedInstance.apiManager()?.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: HeaderClass.shared.getAuthorizedHeader()).responseJSON(completionHandler: { (response) in
                
                if let data = response.data{
                    let result = InsuranceProposalModel.decodeJsonData(data: data)
                    self.HIresult = result
                    print("response is \(result![0].OrderID ?? "")")
                    completionHandler(true, self.HIresult![0].OrderID ?? "")
                    
                }
                //previous work
//                if let data = response.data,
//                    let jsonParsed = try? JSONSerialization.jsonObject(with: data) as? [[String:Any]],
//                    let jsonObj = jsonParsed {
//                    let dic = jsonObj[0]
//                    var res: String?
//                    if let value = dic["OrderID"] {
//                        res = value as! String
//                        print("Result Value  : "+(value as! String))
//                        self.orderID = res ?? ""
//                        completionHandler(true, res ?? "")
//                    }
//                    else{
//                        //for the time being completed it for true case
//                        completionHandler(false, res ?? "")
//                    }
//                }
                else {
                    completionHandler(false, "JSon not parsed")
                }
            })
        }
        
    }
    
    func selectCity(at index: Int) {
        
        city = cities?[index]
        
    }
    
    
    
    func selectArea(at index: Int) {
        area = areas?[index]
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
    
    
    func fetchArea(completionHandler: @escaping (Bool) -> Void) {
        if let city = city , city.Name != TIPlaceHolders.citySelection {
            let urlString = UrlConstants.Helper.getAreas.replacingOccurrences(of: "{CityId}", with: String(city.Id))
            let url = URL(string: urlString)!
            YSessionManager.sharedInstance.apiManager()?.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: HeaderClass.shared.getAuthorizedHeader()).responseJSON(completionHandler: { (response) in
                if let data = response.data,
                    let areas = Area.decodeJsonData(data: data) {
                    self.areas = areas
                    completionHandler(true)
                } else {
                    completionHandler(false)
                }
            })
        } else {
            completionHandler(false)
        }
    }
    
    //Payment Apis Finja
    
    func finajAuthentication(MobileNo: String, completionHandler: @escaping (Bool) -> Void) {
        if let city = city , city.Name != TIPlaceHolders.citySelection {
            let urlString = UrlConstants.finja.Authentication.replacingOccurrences(of: "{MobileNo}", with: "923452391595")
            let url = URL(string: urlString)!
            let manager = Alamofire.SessionManager.default
            manager.session.configuration.timeoutIntervalForRequest = 120
            
            manager.request(url, method: .get, parameters: nil).responseJSON(completionHandler: { (response) in
                print(response)
//                if let data = response.data,
//                    let dataAuth = FinjaAuthenticationModel.decodeJsonData(data: data) {
//                    self.authenticationData = dataAuth
//                    completionHandler(true)
//                } else {
//                    completionHandler(false)
//                }
            })
        } else {
            completionHandler(false)
        }
    }
    
    
    func finajGetToken(UserId: String, Password: String, completionHandler: @escaping (Bool,GenerateToken?) -> Void){
        
        let url = URL(string: UrlConstants.finja.GenerateToken)!
        
        let param: [String:Any] = ["UserId": UserId,
                                   "Password": Password]
        
        print(param)
        print(url)
        
        Alamofire.request(url, method: .post, parameters: param, encoding: JSONEncoding.default).responseJSON { (response) in
            if let data = response.data{
                if let token = GenerateToken.decodeJsonData(data: data){
                    print("response is \(token)")
                    self.authenticationToken = token
                    completionHandler(true, token)
                }
                else{
                    print("could not get the response")
                    completionHandler(false, nil)
                    return
                    //                    completionHandler(false,nil)
                }
                
            }else{
                
                //                completionHandler(false, "failed data is not equal response data")
                
            }
            
        }
        
    }
    
    
    func GetAmountOfPolicy(completionHandler: @escaping (Bool,GetAmountOfPolicyModel) -> Void){
        
        let token = self.authenticationToken?.Token
        let url = URL(string: UrlConstants.finja.GetAmountOfPolicy)!
        
        let headers = [
            "Securelogin": token
        ]
        
        let param: [String:Any] = ["SalesFoamNo": self.orderID ?? "-",
                                   "Type": "Home"]
        
        print("token :\(token)")
        print("headers :\(headers)")
        print("param :\(param)")
        
        Alamofire.request(url, parameters: param, headers: ["Securelogin": "\(String(describing: token))"]).responseJSON() { response in
            
            if let data = response.data{
                if let PolicyAmount = GetAmountOfPolicyModel.decodeJsonData(data: data){
                    print("response is \(PolicyAmount)")
                    self.PolicyAmount = PolicyAmount
                    completionHandler(true, PolicyAmount)
                }
                else{
                    print("could not get the response")
                    return
                    //                    completionHandler(false,nil)
                }
                
            }
            
        }
    }
    
    
    func finjaPayment(code: String, msg: String, data: String, FNToken: String, TransactionAmount: String, PolicyNumber:String, IMS_Key: String, OTP: String, FinjaRegisteredMobileNo: String, completionHandler: @escaping (Bool,[HIQuoteModel]) -> Void){
        
        let url = URL(string: UrlConstants.finja.Payment)!
        
        let param: [String:Any] = ["code": code,
                                   "msg": msg,
                                   "data": data,
                                   "FNToken": FNToken,
                                   "TransactionAmount": TransactionAmount,
                                   "PolicyNumber": PolicyNumber,
                                   "IMS_Key": IMS_Key,
                                   "OTP": OTP,
                                   "FinjaRegisteredMobileNo": FinjaRegisteredMobileNo]
        
        print(param)
        print(url)
        Alamofire.request(url, method: .post, parameters: param, encoding: JSONEncoding.default).responseJSON { (response) in
            if let data = response.data{
                if let quoteData = HIQuoteModel.decodeJsonData(data: data){
                    print("response is \(quoteData)")
                    completionHandler(true, quoteData)
                }
                else{
                    print("could not get the response")
                    return
                    //                    completionHandler(false,nil)
                }
                
            }else{
                
                //                completionHandler(false, "failed data is not equal response data")
                
            }
            
        }
        
    }
}




