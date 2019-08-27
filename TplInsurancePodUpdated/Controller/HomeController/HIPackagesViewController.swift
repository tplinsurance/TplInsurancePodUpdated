//
//  HIPackagesViewController.swift
//  TPLInsurance
//
//  Created by Tahir Raza on 30/11/2018.
//  Copyright © 2018 TPLHolding. All rights reserved.
//

import UIKit

class HIPackagesViewController: UIViewController {

    @IBOutlet weak var packageTable: UITableView!
    var api: HomeInsuranceDataHandler?
    var homePackageDetail: [HomeInsurancePackageDetailModel]?
    var webviewDialoge: WebViewDialoge? = nil
    var bgBlurView = UIView()
    
    var selectedCellIndex: Int = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        packageTable.delegate = self
        packageTable.dataSource = self
        
        // Do any additional setup after loading the view.
        self.navigationItem.setHidesBackButton(true, animated:true);
        let newBackButton = UIBarButtonItem(title: "Back", style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.backCustom(sender:)))
        self.navigationItem.leftBarButtonItem = newBackButton
        
    }
    
    @objc func backCustom(sender: UIBarButtonItem) {
        
        let cancelAlert = UIAlertController(title: "Quit", message: "Are you sure you want to quit from this process?", preferredStyle: UIAlertController.Style.alert)
        
        cancelAlert.addAction(UIAlertAction(title: "Confirm", style: .default, handler: { (action: UIAlertAction!) in
            //            self.navigationController?.popViewController(animated: false)
            if let viewControllers = self.navigationController?.viewControllers, viewControllers.count > 0 {
                for each in viewControllers {
                    if each.isKind(of: ViewController.self) {
                        self.navigationController?.popToViewController(each, animated: true)
                    }
                }
            }
            
        }))
        
        cancelAlert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { (action: UIAlertAction!) in
            
            cancelAlert .dismiss(animated: true, completion: nil)
            
        }))
        
        present(cancelAlert, animated: true, completion: nil)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        packageTable.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
        
    }
    
    @objc func knowMorePackages(_ sender: UIButton) {
                print("This click is done from \(sender.tag)")
        if let clickedFrom = homePackageDetail![sender.tag].packageType {
            print("This click is done from \(clickedFrom)")
            let html = homePackageDetail![sender.tag].longDescription
            
            self.webviewDialoge = WebViewDialoge.instanceFromNib()
            self.webviewDialoge?.frame = CGRect(x: 32, y: 50, width: self.view.frame.size.width - 64, height: self.view.frame.size.height - 90)
            self.webviewDialoge?.btnDone.addTarget(self, action: #selector(self.actionDoneWebview(_:)), for: .touchUpInside)
            let webview = UIWebView(frame: CGRect(x: 0, y: 50, width: (self.webviewDialoge?.frame.size.width)!, height: (self.webviewDialoge?.frame.size.height)! - 90))
            webviewDialoge?.addSubview(webview)
            webview.loadHTMLString("<html><body><table> \(html ?? "") </table></body></html>", baseURL: nil)
            self.bgBlurView.frame = self.view.frame
            self.bgBlurView.backgroundColor = UIColor.black
            self.bgBlurView.alpha = 0.5
            self.view.addSubview(self.bgBlurView)
            self.view.addSubview(self.webviewDialoge!)
            
        }
                
        }
    
    @objc func actionDoneWebview(_ sender: UIButton){
        self.bgBlurView.removeFromSuperview()
        self.webviewDialoge?.removeFromSuperview()
    }
    

}

extension HIPackagesViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return homePackageDetail?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "HIPackageTableViewCell") as? HIPackageTableViewCell  else {
            return UITableViewCell()
        }
        if self.selectedCellIndex == indexPath.row {
            cell.headingLabel.backgroundColor = UIColor(red:1.00, green:0.40, blue:0.20, alpha:1.0)
        } else {
            cell.headingLabel.backgroundColor = UIColor(red:0.05, green:0.18, blue:0.18, alpha:1.0)
        }
        cell.headingLabel.text = homePackageDetail![indexPath.row].packageType ?? "-"
        cell.subHeadingLabel.text = "RS. \(homePackageDetail![indexPath.row].premium ?? "-")"
        cell.priceLabel.text = homePackageDetail![indexPath.row].shortDescription ?? "-"
        cell.btnOutlet.tag = indexPath.row
        cell.btnOutlet.addTarget(self, action: #selector(self.knowMorePackages(_:)), for: .touchUpInside)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let cell = tableView.cellForRow(at: indexPath) as? HIPackageTableViewCell {
            cell.headingLabel.backgroundColor = UIColor(red:0.95, green:0.44, blue:0.13, alpha:1.0)
            self.selectedCellIndex = indexPath.row
            self.api?.selectedHomePackageDetail = self.api?.homePackagesDetail![indexPath.row]
            tableView.reloadData()
        }
    }
    
}

extension HIPackagesViewController: PagerViewDelegate {
    func willMoveTo(next controller: UIViewController, completionHandler: @escaping (Bool) -> Void) {
        if api?.selectedHomePackageDetail != nil{
            self.getQuote(with: controller, completionHandler: completionHandler)
        }else{
            self.showToast(message:"Please select any package first")
        }
    }
}

extension HIPackagesViewController{
    func getQuote(with controller: UIViewController, completionHandler: @escaping(Bool) -> Void) {
        var mobileNum = UserDefaults.standard.object(forKey: TIConstant.userMobileNoKey) as? String
        
        print("Mobile number from shared prefrences is: \(self.api?.name) ---- \(mobileNum) ----  \(self.api?.type) ----  \(self.api?.address) ----  \(self.api?.residentialArea) ----  \(self.api?.cityResidence) ----  \(self.api?.cnic) ----  \(self.api?.tenantsName) ----  \(self.api?.tenantsCnic) ----  \(self.api?.homeInsured) ----  \(self.api?.homeValue) ----  \(self.api?.selectedHomePackageDetail?.packageType) ----  \(mobileNum) ----  \(mobileNum) ----")

//        api?.fetchHomeQoute(MobileNo: mobileNum ?? "03000000000", Package: (self.api?.type)!, Address: (self.api?.address)! , LocationArea: (self.api?.residentialArea)!, City: (self.api?.cityResidence)!, CNIC: (self.api?.cnic)!, TenantName: (self.api?.tenantsName)!, TenantCNIC: (self.api?.tenantsCnic)!, LandLordName: "", LandLordCNIC: "", InsureHomeStructure: (self.api?.homeInsured)!, StructureValue: (self.api?.homeValue)!, PackageType: (self.api?.selectedHomePackageDetail?.packageType)!, completionHandler: { (success, message) in
        
        
        api?.fetchHomeQoute(Name: self.api?.name ?? "nil from api", MobileNo: mobileNum ?? "03000000000", Package: (self.api?.type)!, Address: (self.api?.address)! , LocationArea: (self.api?.residentialArea)!, City: (self.api?.cityResidence)!, CNIC: (self.api?.cnic)!, TenantName: (self.api?.tenantsName)!, TenantCNIC: (self.api?.tenantsCnic)!, LandLordName: (self.api?.landlordsName)!, LandLordCNIC: (self.api?.landlordsCnic)!, InsureHomeStructure: (self.api?.homeInsured)!, StructureValue: self.api?.homeValue == "" ? "0" : (self.api?.homeValue)!, PackageType: (self.api?.selectedHomePackageDetail?.packageType)!,DOB: (self.api?.DOB)!, Email: (self.api?.email)! , completionHandler: { (success, message) in
//            self.view.hideToastActivity()
            self.stopIndicator()
            self.view.isUserInteractionEnabled = true
            if success{
                if let controllerNew = controller as? HISummaryViewController{
                    self.api?.HIQuote = message
                    controllerNew.api = self.api
                    completionHandler(true)
                }else{
                    completionHandler(false)
                }
                
            }else{
//                self.view.makeToast("Not in success true")
                self.showToast(message: "Not in success true")
            }
        })
        
//        api?.HomeInsurancePackages(Name: "Owner", SumInsured: "0") { (success, message) in
//            self.view.hideToastActivity()
//            self.view.isUserInteractionEnabled = true
//            if success{
//                if let controllerSummary = controller as? HIPackagesViewController {
//                    self.homePackageDetail = message
//                    controllerSummary.api = self.api
//                    controllerSummary.homePackageDetail = self.homePackageDetail
//
//                    completionHandler(true)
//                } else {
//                    completionHandler(false)
//                }
//                self.view.hideToastActivity()
//                self.view.isUserInteractionEnabled = true
//            } else {
//                self.view.makeToast("not success")
//            }
//        }
        
    }

//    func getQuoteNew(with controller: UIViewController, completionHandler: @escaping(Bool) -> Void) {
//        var mobileNum = UserDefaults.standard.object(forKey: TIConstant.userMobileNoKey) as? String
//        print("Mobile number from shared prefrences is: \(mobileNum)")
//
//        api?.fetchHomeQouteNew(completionHandler: { (success, message) in
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
//
//    }
    
}

class HIPackageTableViewCell: UITableViewCell {
    
    @IBOutlet weak var headingLabel: UILabel!
    @IBOutlet weak var subHeadingLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var btnOutlet: UIButton!
    
    
}


