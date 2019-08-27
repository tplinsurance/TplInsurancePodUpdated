//
//  TISummaryViewController.swift
//  TPLInsurance
//
//  Created by Tahir Raza on 27/12/2018.
//  Copyright © 2018 TPLHolding. All rights reserved.
//

import UIKit

class TISummaryViewController: UIViewController {
    
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
    //Fourth Controller
    var yourArray = [familyData]()
    var api = travelInsuranceDataHandler()
    
    @IBOutlet weak var TISCheckboxLabel: UIButton!
    @IBOutlet weak var TISummaryTable: UITableView!
    @IBAction func TIScheckboxClicked(_ sender: Any) {
        if TISCheckboxLabel.isSelected{
            TISCheckboxLabel.isSelected = false
        }else{
            TISCheckboxLabel.isSelected = true
        }
    }
    @IBOutlet weak var nonFilerLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        TISummaryTable.delegate = self
        TISummaryTable.dataSource = self
//        TISummaryTable.reloadData()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        print("first controller from page TISummaryTable:")
        print("coverage: \(self.coverage) -- travelTypeSelected: \(self.travelTypeSelected) -- travelStartDate: \(self.travelStartDate) -- travelEndDate: \(self.travelEndDate) -- destination: \(self.destination) -- selectedDestination: \(self.selectedDestination) -- studentTution: \(self.studentTution)")
        
        print("Second controller from page TISummaryTable:")
        print("nameOfInsured: \(self.nameOfInsured) -- dob: \(self.dob) -- passport: \(self.passport) -- cnic: \(self.cnic) -- city: \(self.city) -- address: \(self.address)")
        
        print("third controller from page TISummaryTable:")
        print("bName: \(self.bName) -- bAddress: \(self.bAddress) -- bCnic: \(self.bCnic) -- bContact: \(self.bContact) -- bRelation: \(self.bRelation)")
        
        print("family detail controller from page TISummaryTable:")
        print("yourArray: \(self.yourArray)")
        
        self.TISummaryTable.reloadData()
    }

}

extension TISummaryViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "NewSummaryyTableViewCell") as? NewSummaryyTableViewCell else{
            return UITableViewCell()
        }
        nonFilerLabel.text = "In case you are a non-filer, amount of Rs.\(self.api.TIQuote![0].netPremium_NonFiler ?? "0") will be charged"
        if self.api.TIQuote! != nil{
            if(indexPath.row == 0){
                cell.labelHeading.text = "Package"
                cell.labelExtra.isHidden = false
//                cell.labelExtra.text = self.api.selectedTravelPackageDetail?.packageType
                cell.labelExtra.text = self.api.TIQuote![0].package ?? "0"
                cell.labelValue.text = "RS. \(self.api.TIQuote![0].originalPremium ?? "0")"
                
            }else if(indexPath.row == 1){
                cell.labelHeading.text = "Discount"
                cell.labelExtra.isHidden = true
                cell.labelValue.text = "RS. \(self.api.TIQuote![0].discount ?? "0")"
                
                
            }else if(indexPath.row == 2){
                cell.labelHeading.text = "Total"
                cell.labelExtra.isHidden = true
                cell.labelValue.text = "RS. \(self.api.TIQuote![0].netPremium_Filer ?? "0")"
                
            } else {
                cell.labelExtra.text = ""
                cell.labelExtra.isHidden = true
            }
        }
        
        return cell
    }
    
}

extension TISummaryViewController: PagerViewDelegate {
    func willMoveTo(next controller: UIViewController, completionHandler: @escaping (Bool) -> Void) {
        if TISCheckboxLabel.isSelected{
            
            self.showActivityIndicatory()
//            api.TIProposalApi()
//            api.TIProposalApi(completionHandler: { (success,result) in
            var mobileNum = UserDefaults.standard.object(forKey: TIConstant.userMobileNoKey) as? String
            print("Mobile number from shared prefrences is: \(mobileNum)")
            let bList = "\(bName ?? "");\(bAddress ?? "");\(bCnic ?? "");\(bContact ?? "");\(bRelation ?? "");"

            api.TIProposalApi(MobileNo: mobileNum ?? "03000000000", PassportNo: self.passport ?? "", BeneficiaryList: bList ?? "ZAK;centerpoint;42101-1001111-1;03001234567;Brother", FamilyList: "", Quote_Id: String(describing: self.api.TIQuote?[0].quote_Id) ?? "", completionHandler: { (success,result) in
                
                DispatchQueue.main.async {
                    self.stopIndicator()
                    if success {
                        
                        let defaultAction = UIAlertAction(title: "Continue payment", style: UIAlertAction.Style.default, handler: { [weak self](action) in
                            
                            //                        self?.navigationController?.popViewController(animated: true)
                            var quoteId = String(describing: self?.api.TIQuote![0].quote_Id)
                            let controller = self?.storyboard?.instantiateViewController(withIdentifier: "PaymentOptionsViewController") as! PaymentOptionsViewController
//                            controller.myurl = "http://customer.tplinsurance.com/onlinesales_uat/PaymentMethod.aspx?Product_Id=\(quoteId ?? "")&Type=Travel&SalesFormNo=\(result ?? "")"
//                            controller.apiTravel = self?.api
                            
                            //open it
//                            controller.myurl = "https://customer.tplinsurance.com:444/PaymentModel/CustomerDetail.aspx?Type=Travel&SalesFormNo=\(result ?? "")"

                            
//                            print("url passed is: \(controller.myurl)")
                            self?.navigationController?.pushViewController(controller, animated: true)
                            
                        })
                        
                        TIHelper.showAlert(ViewController: self, AlertTitle: "Request Submitted", AlertMessage: "Thank you for choosing TPL Insurance. Proposal number is : \(result[0].OrderID ?? ""). After successful payment your policy will be emailed to you within 24 hours.", AlertStyle: .alert , Actions: [defaultAction])
                        
                    } else {
                        self.showToast(message: "Request Failed.")
                    }
                }
            })
        }else{
            self.showToast(message: "Please accept this plan to proceed")
        }
        
    }
}
