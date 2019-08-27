//
//  NewTIPackagesViewController.swift
//  TPLInsurance
//
//  Created by Tahir Raza on 03/12/2018.
//  Copyright © 2018 TPLHolding. All rights reserved.
//

import UIKit

class NewTIPackagesViewController: UIViewController {
    
    //FirstController
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
    var city: String?
    var address: String?
    //Third Controller
    var bName: String?
    var bAddress: String?
    var bCnic: String?
    var bContact: String?
    var bRelation: String?
    var selectedDate: Date?
    var travelPackageDetail: [TravelPackageModel]?
    var selectedCellIndex: Int = -1
    //Fourth Controller
    var yourArray = [familyData]()
    var api = travelInsuranceDataHandler()
    
    var webviewDialoge: WebViewDialoge? = nil
    var bgBlurView = UIView()

    @IBOutlet weak var newPackagesTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
//        getPackagesController()

        newPackagesTable.delegate = self
        newPackagesTable.dataSource = self

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getPackagesController()
        // FIXME: sddsa
        self.api.selectedTravelPackageDetail = nil
        self.selectedCellIndex = -1
        newPackagesTable.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func actionDoneWebview(_ sender: UIButton){
        self.bgBlurView.removeFromSuperview()
        self.webviewDialoge?.removeFromSuperview()
    }

    @objc func knowMorePackages(_ sender: UIButton) {
//        print("This click is done from \(sender.tag)")

        if ((travelPackageDetail?.count) != nil) {

            print("This click is done from \(sender.tag)")
            let html = travelPackageDetail![sender.tag].longDescription
            
            self.webviewDialoge = WebViewDialoge.instanceFromNib()
            self.webviewDialoge?.frame = CGRect(x: 32, y: 50, width: self.view.frame.size.width - 64, height: self.view.frame.size.height - 90)
            self.webviewDialoge?.btnDone.addTarget(self, action: #selector(self.actionDoneWebview(_:)), for: .touchUpInside)
            let webview = UIWebView(frame: CGRect(x: 0, y: 50, width: (self.webviewDialoge?.frame.size.width)!, height: (self.webviewDialoge?.frame.size.height)! - 90))
            webviewDialoge?.addSubview(webview)
            webview.loadHTMLString("<html><head></head><body><table> \(html ?? "") </table></body></html>", baseURL: nil)
            self.bgBlurView.frame = self.view.frame
            self.bgBlurView.backgroundColor = UIColor.black
            self.bgBlurView.alpha = 0.5
            self.view.addSubview(self.bgBlurView)
            self.view.addSubview(self.webviewDialoge!)
        }
    }
    

}

extension NewTIPackagesViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return travelPackageDetail?.count ?? 0
//        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TIPackageTableViewCell") as? TIPackageTableViewCell  else {
            return UITableViewCell()
        }
        if self.selectedCellIndex == indexPath.row {
            cell.headingLabel.backgroundColor = UIColor(red:1.00, green:0.40, blue:0.20, alpha:1.0)
        } else {
            cell.headingLabel.backgroundColor = UIColor(red:0.05, green:0.18, blue:0.18, alpha:1.0)
        }
        cell.headingLabel.text = travelPackageDetail![indexPath.row].packageType ?? "-"
        cell.subHeadingLabel.text = travelPackageDetail![indexPath.row].package ?? "-"
        cell.priceLabel.text = "RS. \(travelPackageDetail![indexPath.row].premium ?? "-")"
        cell.btnKnowMore.tag = indexPath.row
        cell.btnKnowMore.addTarget(self, action: #selector(self.knowMorePackages(_:)), for: .touchUpInside)
        return cell
    }
//        if indexPath.row == 1{
//            cell.headingLabel.text = "Silver"
//            cell.subHeadingLabel.text = "Basic Home Package"
//            cell.priceLabel.text = "RS. 600"
//
//        }else if indexPath.row == 2{
//            cell.headingLabel.text = "Gold"
//            cell.subHeadingLabel.text = "International"
//            cell.priceLabel.text = "RS. 2500"
//        }
//        cell.btnKnowMore.tag = indexPath.row
//        cell.btnKnowMore.addTarget(self, action: #selector(self.knowMorePackages(_:)), for: .touchUpInside)
//        return cell
//    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let cell = tableView.cellForRow(at: indexPath) as? TIPackageTableViewCell {
            cell.headingLabel.backgroundColor = UIColor(red:0.95, green:0.44, blue:0.13, alpha:1.0)
            self.selectedCellIndex = indexPath.row
            self.api.selectedTravelPackageDetail = self.travelPackageDetail![indexPath.row]
            print("selected package is: \(self.api.selectedTravelPackageDetail)")
            tableView.reloadData()
        }
    }
}

extension NewTIPackagesViewController: PagerViewDelegate {
    func willMoveTo(next controller: UIViewController, completionHandler: @escaping (Bool) -> Void) {
        
        print("first controller from page 4:")
        print("coverage: \(self.coverage) -- travelTypeSelected: \(self.travelTypeSelected) -- travelStartDate: \(self.travelStartDate) -- travelEndDate: \(self.travelEndDate) -- destination: \(self.destination) -- selectedDestination: \(self.selectedDestination) -- studentTution: \(self.studentTution)")
        
        print("Second controller from page 4:")
        print("nameOfInsured: \(self.nameOfInsured) -- dob: \(self.dob) -- passport: \(self.passport) -- cnic: \(self.cnic) -- city: \(self.city) -- address: \(self.address)")
        
        print("third controller from page 4:")
        print("bName: \(self.bName) -- bAddress: \(self.bAddress) -- bCnic: \(self.bCnic) -- bContact: \(self.bContact) -- bRelation: \(self.bRelation)")
        
        print("family detail controller from page 4:")
        print("yourArray: \(self.yourArray)")
        
        if self.api.selectedTravelPackageDetail != nil{
            self.getQuote(with: controller, completionHandler: completionHandler)
        }else{
            self.showToast(message: "Please select any package first")
        }
    }
}

// MARL: - API CALLING

extension NewTIPackagesViewController{
    func getQuote(with controller: UIViewController, completionHandler: @escaping(Bool) -> Void) {
        var mobileNum = UserDefaults.standard.object(forKey: TIConstant.userMobileNoKey) as? String
        print("Mobile number from shared prefrences is: \(mobileNum)")
        
        
        api.fetchTravelQoute(MobileNo: mobileNum ?? "03000000000", Coverage: self.coverage ?? "", TravelType: self.travelTypeSelected ?? "International", Package_Id: String(describing: self.api.selectedTravelPackageDetail?.id ?? 000), StartDate: self.travelStartDate ?? "", EndDate: self.travelEndDate ?? "", City: self.city ?? "Karachi", Destination_Id: self.selectedDestination?.id ?? "", DOB: self.dob ?? "1980-08-22", Address: self.address ?? "abc road", CNIC: self.cnic ?? "42101-1661120-5", Name: self.nameOfInsured ?? "S.M.Aamir", Email: self.email ?? "a@a.com", completionHandler: { (success, message) in
            self.stopIndicator()
            self.view.isUserInteractionEnabled = true
            if success{
                if let controller = controller as? TISummaryViewController{
                    self.api.TIQuote = message
                    //New work for singleton object
                    //first controller variable
                    self.api.coverage = self.coverage
                    self.api.travelTypeSelected = self.travelTypeSelected
                    self.api.travelStartDate = self.travelStartDate
                    self.api.travelEndDate = self.travelEndDate
                    self.api.destination = self.destination
                    self.api.selectedDestination = self.selectedDestination
                    self.api.studentTution = self.studentTution
                    
                    //first controller variable
                    self.api.nameOfInsured = self.nameOfInsured
                    self.api.email = self.email
                    self.api.dob = self.dob
                    self.api.passport = self.passport
                    self.api.cnic = self.cnic
                    self.api.cityData = self.city
                    self.api.address = self.address
                    
                    //this controller variable
                    self.api.bName = self.bName
                    self.api.bAddress = self.bAddress
                    self.api.bCnic = self.bCnic
                    self.api.bContact = self.bContact
                    self.api.bRelation = self.bRelation
                    self.api.travelPackageDetail = self.travelPackageDetail
                    
                    //Family Detail View Controller
                    self.api.yourArray = self.yourArray
                    controller.api = self.api
                    
                    //Previous work
                    
                    //first controller variable
                    controller.coverage = self.coverage
                    controller.travelTypeSelected = self.travelTypeSelected
                    controller.travelStartDate = self.travelStartDate
                    controller.travelEndDate = self.travelEndDate
                    controller.destination = self.destination
                    controller.selectedDestination = self.selectedDestination
                    controller.studentTution = self.studentTution
//                    controller.api = self.api
                    
                    //first controller variable
                    controller.nameOfInsured = self.nameOfInsured
                    controller.email = self.email
                    controller.dob = self.dob
                    controller.passport = self.passport
                    controller.cnic = self.cnic
                    controller.city = self.city
                    controller.address = self.address
                    
                    //this controller variable
                    controller.bName = self.bName
                    controller.bAddress = self.bAddress
                    controller.bCnic = self.bCnic
                    controller.bContact = self.bContact
                    controller.bRelation = self.bRelation
                    controller.travelPackageDetail = self.travelPackageDetail
                    
                    //Family Detail View Controller
                    controller.yourArray = self.yourArray
                    completionHandler(true)
                }else{
                    completionHandler(false)
                }
                
            }else{
                self.showToast(message: "Not in success true")
            }
        })

        
    }
    
}

//extension NewTIPackagesViewController{
//    func getQuote(with controller: UIViewController, completionHandler: @escaping(Bool) -> Void) {
//        var mobileNum = UserDefaults.standard.object(forKey: TIConstant.userMobileNoKey) as? String
//        print("Mobile number from shared prefrences is: \(mobileNum)")
//
//        api.fetchTravelQoute(MobileNo: mobileNum ?? "03000000000", Coverage: "Individual", TravelType: "International", Package_Id: "113", StartDate: "2018-12-01", EndDate: "2018-12-31", City: "Karachi", Destination_Id: "1", DOB: "1980-08-22", Address: "abc road", CNIC: "42101-1661120-5", Name: "S.M.Aamir", Email: "a@a.com", completionHandler: { (success, message) in
//            self.view.hideToastActivity()
//                        self.view.isUserInteractionEnabled = true
//                        if success{
////                            if let controllerNew = controller as? HISummaryViewController{
////                                self.api?.HIQuote = message
////                                controllerNew.api = self.api
////                                completionHandler(true)
//                            self.view.makeToast(" in success true")
//
//                            }else{
//                                completionHandler(false)
//                            }
//
//                        }else{
//                            self.view.makeToast("Not in success true")
//                        }
//                    })
//        }
//        api.fetchTravelQoute(MobileNo: mobileNum ?? "03000000000", Coverage: coverage ?? "", TravelType: travelTypeSelected ?? "" , PackageId: (self.api?.residentialArea)!, StartDate: (self.api?.cityResidence)!, EndDate: (self.api?.cnic)!, City: (self.api?.tenantsName)!, Destination_Id: (self.api?.tenantsCnic)!, DOB: "", Address: "", CNIC: (self.api?.homeInsured)!, Name: (self.api?.homeValue)!, Email: (self.api?.selectedHomePackageDetail?.packageType)!, completionHandler: { (success, message) in
//            self.view.hideToastActivity()
//            self.view.isUserInteractionEnabled = true
//            if success{
//                if let controllerNew = controller as? HISummaryViewController{
//                    self.api?.HIQuote = message
//                    controllerNew.api = self.api
//                    completionHandler(true)
//                }else{
//                    completionHandler(false)
//                }
//
//            }else{
//                self.view.makeToast("Not in success true")
//            }
//        })
        
//    }
//}

// MARK: - Api calling
extension NewTIPackagesViewController{
    func getPackagesController() {
        api.TravelInsurancePackages(Coverage: self.coverage ?? "-", TravelType: self.travelTypeSelected ?? "International", WithTution: studentTution ?? "N", StartDate: travelStartDate ?? "2001-01-01", EndDate: travelEndDate ?? "2001-01-01", DOB: self.dob ?? "1980-08-22") { (success, message) in
            self.stopIndicator()
            self.view.isUserInteractionEnabled = true
            if success{
                self.travelPackageDetail = message
                self.stopIndicator()
                self.view.isUserInteractionEnabled = true
                self.newPackagesTable.reloadData()
            } else {
                self.showToast(message: "not success")
            }
        }
        
    }
    
}
//// MARK: - API CALLING
//extension NewVAFViewController {
//    func getQuote(with controller: UIViewController, completionHandler: @escaping (Bool) -> Void) {
//        self.view.makeToastActivity(.center)
//        self.view.isUserInteractionEnabled = false
//        requestQouteDataHandler?.fetchCarQoute { (success,message) in
//            self.view.hideToastActivity()
//            if success{
//                if let controllerSummary = controller as? NewSummaryyViewController {
//                    controllerSummary.requestQouteDataHandler = self.requestQouteDataHandler
//                    completionHandler(true)
//                } else {
//                    completionHandler(false)
//                }
//                self.view.hideToastActivity()
//                self.view.isUserInteractionEnabled = true
//            } else {
//                self.view.makeToast(message)
//            }
//            self.view.hideToastActivity()
//            self.view.isUserInteractionEnabled = true
//        }
//    }
//}


//// MARK: - API CALLING
//extension NewVAFViewController {
//
//    func getQuoteTravelNew(with controller: UIViewController, completionHandler: @escaping (Bool) -> Void) {
//        self.view.makeToastActivity(.center)
//        self.view.isUserInteractionEnabled = false
//        requestQouteDataHandler?.fetchCarQoute { (success,message) in
//            self.view.hideToastActivity()
//            if success{
//                if let controllerSummary = controller as? NewSummaryyViewController {
//                    controllerSummary.requestQouteDataHandler = self.requestQouteDataHandler
//                    completionHandler(true)
//                } else {
//                    completionHandler(false)
//                }
//                self.view.hideToastActivity()
//                self.view.isUserInteractionEnabled = true
//            } else {
//                self.view.makeToast(message)
//            }
//            self.view.hideToastActivity()
//            self.view.isUserInteractionEnabled = true
//        }
//    }
//}

