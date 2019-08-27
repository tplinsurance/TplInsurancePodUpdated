//
//  HISummaryViewController.swift
//  TPLInsurance
//
//  Created by Tahir Raza on 30/11/2018.
//  Copyright © 2018 TPLHolding. All rights reserved.
//

import UIKit

class HISummaryViewController: UIViewController {
    var api: HomeInsuranceDataHandler?
    
    @IBOutlet weak var labelNonFiler: UILabel!
    @IBOutlet weak var summaryTable: UITableView!
    @IBOutlet weak var checkbox: UIButton!
    @IBAction func actionCheckbox(_ sender: Any) {
        if checkbox.isSelected{
            checkbox.isSelected = false
        }else{
            checkbox.isSelected = true
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        summaryTable.delegate = self
        summaryTable.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        summaryTable.reloadData()
    }
    
}

extension HISummaryViewController: UITableViewDelegate,UITableViewDataSource {
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
        labelNonFiler.text = "In case you are a non-filer, amount of Rs.\(self.api?.HIQuote![0].netPremium_NonFiler ?? "0") will be charged"
        if self.api?.HIQuote! != nil{
            if(indexPath.row == 0){
                cell.labelHeading.text = "Package"
                cell.labelExtra.isHidden = false
                cell.labelExtra.text = self.api?.HIQuote![0].package ?? "0"
                //                cell.labelExtra.text = self.api?.selectedHomePackageDetail?.shortDescription ?? "-"
                cell.labelValue.text = "RS. \(self.api?.HIQuote![0].originalPremium ?? "0")"
                
            }else if(indexPath.row == 1){
                cell.labelHeading.text = "Discount"
                cell.labelExtra.isHidden = true
                cell.labelValue.text = "RS. \(self.api?.HIQuote![0].discount ?? "0")"
                
                
            }else if(indexPath.row == 2){
                cell.labelHeading.text = "Total"
                cell.labelExtra.isHidden = true
                cell.labelValue.text = "RS. \(self.api?.HIQuote![0].netPremium_Filer ?? "0")"
                
            } else {
                cell.labelExtra.text = ""
                cell.labelExtra.isHidden = true
            }
        }
        
        
        
        return cell
    }
    
    
    
}

// MARK: - New work which opens new payment mode page
extension HISummaryViewController: PagerViewDelegate {
    
    //MARK: - CallBack To receive result
//    @IBAction func someCallback(sender: UIStoryboardSegue){
//        let sourceViewController = sender.source as? MealViewController
//        let data = sourceViewController.someValue
//    }
    
    func willMoveTo(next controller: UIViewController, completionHandler: @escaping (Bool) -> Void) {
        if checkbox.isSelected{
            self.showActivityIndicatory()
            //MARK: - For Blocking user interaction
            UIApplication.shared.beginIgnoringInteractionEvents()
            //Open this
            api?.HIProposalApi(completionHandler: { (success,result) in
                
                DispatchQueue.main.async {
//                    self.view.hideToastActivity()
                    self.stopIndicator()
                    //MARK: - For Un-Blocking user interaction
                    UIApplication.shared.endIgnoringInteractionEvents()
                    //Open this
                    if success {
                        
                        let defaultAction = UIAlertAction(title: "Continue payment", style: UIAlertAction.Style.default, handler: { [weak self](action) in
                            
                            var quoteId = String(describing: self?.api?.HIQuote![0].quoteId)
                            let controller = self?.storyboard?.instantiateViewController(withIdentifier: "PaymentOptionsViewController") as! PaymentOptionsViewController
                            var url = "https://customer.tplinsurance.com:444/PaymentModel/CustomerDetail.aspx?Type=Home&SalesFormNo=\("result" ?? "")"
//                            controller.myurl = "https://customer.tplinsurance.com:444/PaymentModel/CustomerDetail.aspx?Type=Home&SalesFormNo=\("result" ?? "")"
//                            controller.apiHome = self!.api
                            print("url passed is: \(url)")
//                            self?.navigationController?.pushViewController(controller, animated: true)
                            
                        })
                        
                        TIHelper.showAlert(ViewController: self, AlertTitle: "Request Submitted", AlertMessage: "Thank you for choosing TPL Insurance. Proposal number is : \(result). After successful payment your policy will be emailed to you within 24 hours. ", AlertStyle: .alert , Actions: [defaultAction])
                        //Open this
                    } else {
                        self.showToast(message: "Request Failed.")
                    }
                }
                //Open this
            })
        }else{
            self.showToast(message:"Please accept this plan to proceed")
        }
        
    }
}

// MARK: - Previous work which direct opens webview
//extension HISummaryViewController: PagerViewDelegate {
//    func willMoveTo(next controller: UIViewController, completionHandler: @escaping (Bool) -> Void) {
//        if checkbox.isSelected{
//            self.view.makeToastActivity(.center)
//            api?.HIProposalApi(completionHandler: { (success,result) in
//
//                DispatchQueue.main.async {
//                    self.view.hideToastActivity()
//                    if success {
//
//                        let defaultAction = UIAlertAction(title: "Continue payment", style: UIAlertActionStyle.default, handler: { [weak self](action) in
//
//                            //                        self?.navigationController?.popViewController(animated: true)
//                            var quoteId = String(describing: self?.api?.HIQuote![0].quoteId)
//                            let controller = self?.storyboard?.instantiateViewController(withIdentifier: "HIWebKitViewController") as! HIWebKitViewController
////                            controller.myurl = "http://customer.tplinsurance.com/onlinesales_uat/PaymentMethod.aspx?Product_Id=\(quoteId ?? "")&Type=Home&SalesFormNo=\(result ?? "")"
//
////                            controller.myurl = "http://customer.tplinsurance.com/OnlineSales_UAT/PaymentModel/CustomerDetail.aspx?Type=Home&SalesFormNo=\(result ?? "")"
//                            controller.myurl = "https://customer.tplinsurance.com:444/PaymentModel/CustomerDetail.aspx?Type=Home&SalesFormNo=\(result ?? "")"
//                            print("url passed is: \(controller.myurl)")
//                            self?.navigationController?.pushViewController(controller, animated: true)
//
//                        })
//
//                        TIHelper.showAlert(ViewController: self, AlertTitle: "Request Submitted", AlertMessage: "Thank you for choosing TPL Insurance. Proposal number is : \(result). After successful payment your policy will be emailed to you within 24 hours. ", AlertStyle: .alert , Actions: [defaultAction])
//
//                    } else {
//                        self.view.makeToast("Request Failed.")
//                    }
//                }
//            })
//        }else{
//            self.view.makeToast("Please accept this plan to proceed")
//        }
//
//    }
//}
