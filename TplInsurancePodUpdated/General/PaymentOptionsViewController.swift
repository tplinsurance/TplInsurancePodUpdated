////
////  PaymentOptionsViewController.swift
////  tpllifev1
////
////  Created by IMac on 04/03/2019.
////  Copyright © 2019 TPL Insurance. All rights reserved.
////
//



import UIKit
//import Alamofire

class PaymentOptionsViewController: SecondaryViewController{
    
}







//import UIKit
//import Alamofire
//
//class PaymentOptionsViewController: SecondaryViewController , UITableViewDelegate , UITableViewDataSource {
//
//    var apiHandlerHome = paymentApiHelper()
//    var numberTextfieldFromSimSim: UITextField?
//    var simsimOtpTextfield: UITextField?
//    var numberTextfieldFromJazzCash: UITextField?
//    let mobileNumber = UserDefaults.standard.object(forKey: TIConstant.userMobileNoKey) as? String
//    let mobileNumberPass = UserDefaults.standard.object(forKey: TIConstant.userMobileNoPasscode) as? String
//    var otpText: String?
//
//    func intializeVariableForTravel(){
//        //        var apiTravel: travelInsuranceDataHandler?
//    }
//
//
//    @IBAction func submitAction(_ sender: UIButton) {
//
//        if isTravelPager!{
//
//            if isPaymentMethod == false && isPayThroughSimSim == false && isPayThroughJazzcash == false{
//                self.view.makeToast("Please select one mode.")
//            }else if isPaymentMethod && isPayThroughSimSim && isPayThroughJazzcash{
//                self.view.makeToast("Please select anyone mode.")
//            }else if isPaymentMethod{
//                if isHomePager ?? false{
//                    let controller = self.storyboard?.instantiateViewController(withIdentifier: "HIWebKitViewController") as! HIWebKitViewController
//
//                    controller.myurl = "https://customer.tplinsurance.com:444/PaymentModel/CustomerDetail.aspx?Type=Home&SalesFormNo=\("result" ?? "")"
//                    print("url passed is: \(controller.myurl)")
//                    self.navigationController?.pushViewController(controller, animated: true)
//
//                }else if isTravelPager ?? false{
//                    let controller = self.storyboard?.instantiateViewController(withIdentifier: "HIWebKitViewController") as! HIWebKitViewController
//
//                    controller.myurl = "https://customer.tplinsurance.com:444/PaymentModel/CustomerDetail.aspx?Type=Travel&SalesFormNo=\(self.apiTravel?.result![0].OrderID ?? "")"
//                    print("url passed is: \(controller.myurl)")
//                    self.navigationController?.pushViewController(controller, animated: true)
//
//                }else{
//                    self.view.makeToast("Please select which domain")
//                }
//
//            }else if isPayThroughSimSim{
//                if numberTextfieldFromSimSim?.text != nil || numberTextfieldFromSimSim?.text != ""{
//                    finjaAuthTravel()
//
//                }else{
//                    self.view.makeToast("Please write your number")
//                }
//
//            }else if isPayThroughJazzcash{
//                if numberTextfieldFromJazzCash?.text != nil || numberTextfieldFromJazzCash?.text != ""{
//                    JazzCashPayment(PolicyNumber: self.apiTravel!.result![0].OrderID ?? "", Amount: self.apiTravel!.result![0].Premium ?? "", Key: "test121", PayMobileNo: numberTextfieldFromJazzCash?.text ?? "-", Description: "ios description app")
//
//                }else{
//                    self.view.makeToast("Please write your number")
//                }
//
//            }
//        }else if isHomePager!{
//            if isPaymentMethod == false && isPayThroughSimSim == false && isPayThroughJazzcash == false{
//                self.view.makeToast("Please select one mode.")
//            }else if isPaymentMethod && isPayThroughSimSim && isPayThroughJazzcash{
//                self.view.makeToast("Please select anyone mode.")
//            }else if isPaymentMethod{
//
//                let controller = self.storyboard?.instantiateViewController(withIdentifier: "HIWebKitViewController") as! HIWebKitViewController
//
//                controller.myurl = "https://customer.tplinsurance.com:444/PaymentModel/CustomerDetail.aspx?Type=Home&SalesFormNo=\("result" ?? "")"
//                print("url passed is: \(controller.myurl)")
//                self.navigationController?.pushViewController(controller, animated: true)
//
//            }else if isPayThroughSimSim{
//                if numberTextfieldFromSimSim?.text != nil || numberTextfieldFromSimSim?.text != ""{
//                    finjaAuthHome()
//
//                }else{
//                    self.view.makeToast("Please write your number")
//                }
//
//            }else if isPayThroughJazzcash{
//                if numberTextfieldFromJazzCash?.text != nil || numberTextfieldFromJazzCash?.text != ""{
//                    JazzCashPayment(PolicyNumber: self.apiHome?.HIresult![0].OrderID ?? "", Amount: self.apiHome?.HIresult![0].Premium ?? "", Key: "test121", PayMobileNo: numberTextfieldFromJazzCash?.text ?? "-", Description: "ios description app")
//
//                }else{
//                    self.view.makeToast("Please write your number")
//                }
//
//            }
//        }
//
//
//    }
//    @IBOutlet weak var tableView: UITableView!
//    var api: Any?
//    //    var paymentApiHelper = paymentApiHelper()
//    var apiHome: HomeInsuranceDataHandler?
//    var apiTravel: travelInsuranceDataHandler?
//    var myurl : String?
//    var isTravelPager: Bool?
//    var isHomePager: Bool?
//
//    private var isPaymentMethod: Bool = false
//    private var isPayThroughSimSim: Bool = false
//    private var isPayThroughEasyPay: Bool = false
//    private var isPayThroughJazzcash: Bool = false
//
//    let toolBar = TIHelper.accessoryViewForTextField(target: self, selector: #selector(donePicker))
//
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        // For removing the extra empty spaces of TableView below
//        self.navigationItem.title = "Payment Mode"
//        self.tableView.delegate = self
//        self.tableView.dataSource = self
//        tableView.tableFooterView = UIView()
//
//
//        self.hideKeyboardWhenTappedAround()
//
//
//        self.navigationItem.hidesBackButton = true
//        let newBackButton = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.plain, target: self, action: #selector(self.back(sender:)))
//        self.navigationItem.leftBarButtonItem = newBackButton
//        //        let allPreviousViewC = currentViewController.navigationController?.viewControllers // will give array of all pushed VC
//        //        // Can use if condition to check array count and then put below code inside that condition
//        //        for viewC in allPreviousViewC! {
//        //            print("ViewC is \(viewC)")
//        //        }
//        //        let previousController = self.navigationController!.getPreviousViewController()
//        //        if previousController is homePagerViewController {
//        //            self.view.makeToast("Hello this is hisummary")
//        //        }else if previousController is TravelPagerViewController{
//        //            self.view.makeToast("Hello this is travel summary")
//        //        }
//    }
//
//    @objc func donePicker() {
//        self.view.endEditing(true)
//    }
//
//    override func viewWillAppear(_ animated: Bool) {
//        navigationController?.navigationBar.barTintColor = UIColor(red: 227.0/255.0, green: 118.0/255.0, blue: 57.0/255.0, alpha: 1.0)
//        navigationController?.navigationBar.isTranslucent = false
//        navigationController?.navigationBar.tintColor = UIColor(red: 117.0/255.0, green: 117.0/255.0, blue: 117.0/255.0, alpha: 1.0)
//
//        let previousController = self.navigationController!.getPreviousViewController()
//        if previousController is homePagerViewController {
//            //            self.view.makeToast("Hello this is hisummary")
//            self.isHomePager = true
//            self.isTravelPager = false
//            self.api = apiHome
//            //            self.apiHome = api as! HomeInsuranceDataHandler
//
//        }else if previousController is TravelPagerViewController{
//            //            self.view.makeToast("Hello this is travel summary")
//            self.isTravelPager = true
//            self.isHomePager = false
//            self.api = apiTravel
//            intializeVariableForTravel()
//        }
//    }
//
//    @objc func back(sender: UIBarButtonItem) {
//
//        var cancelAlert = UIAlertController(title: "Quit", message: "Are you sure you want to go back to home?", preferredStyle: UIAlertControllerStyle.alert)
//
//        cancelAlert.addAction(UIAlertAction(title: "Confirm", style: .default, handler: { (action: UIAlertAction!) in
//            self.navigationController!.popToRootViewController(animated: true)
//        }))
//
//        cancelAlert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { (action: UIAlertAction!) in
//
//            cancelAlert .dismiss(animated: true, completion: nil)
//
//        }))
//
//        present(cancelAlert, animated: true, completion: nil)
//
//    }
//
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 3
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = UITableViewCell()
//        switch indexPath.row {
//        case 0:
//            let cell = tableView.dequeueReusableCell(withIdentifier: "PaymentOptionCell", for: indexPath) as! PaymentOptionCell
//            cell.selectionStyle = .none
//            return cell
//
//        case 1:
//            let cell = tableView.dequeueReusableCell(withIdentifier: "SimSimPaymentCell", for: indexPath) as! SimSimPaymentCell
//            cell.selectionStyle = .none
//            cell.numberOutlet.delegate = self
//            cell.numberOutlet.inputAccessoryView = toolBar
//            self.numberTextfieldFromSimSim = cell.numberOutlet
//            return cell
//
//        case 2:
//            let cell = tableView.dequeueReusableCell(withIdentifier: "JazzCashPaymentCell", for: indexPath) as! JazzCashPaymentCell
//            cell.selectionStyle = .none
//            cell.jazzCashNumberField.delegate = self
//            cell.jazzCashNumberField.inputAccessoryView = toolBar
//            self.numberTextfieldFromJazzCash = cell.jazzCashNumberField
//            return cell
//
//        default:
//            print("invalid selection")
//        }
//        return cell
//    }
//
//
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: true)
//        if indexPath.row == 0 {
//            //check if second row is on
//            if isPayThroughSimSim{
//                isPayThroughSimSim = false
//            }
//            if isPayThroughJazzcash{
//                isPayThroughJazzcash = false
//            }
//            if isPaymentMethod {
//                isPaymentMethod = false
//            } else {
//                isPaymentMethod = true
//            }
//            tableView.beginUpdates()
//            tableView.endUpdates()
//        }
//        if indexPath.row == 1 {
//            //check if first row is on
//            if isPaymentMethod{
//                isPaymentMethod = false
//            }
//            if isPayThroughJazzcash{
//                isPayThroughJazzcash = false
//            }
//            if isPayThroughSimSim {
//                isPayThroughSimSim = false
//            } else {
//                isPayThroughSimSim = true
//            }
//            tableView.beginUpdates()
//            tableView.endUpdates()
//        }
//        if indexPath.row == 2 {
//
//            if isPaymentMethod{
//                isPaymentMethod = false
//            }
//            if isPayThroughSimSim{
//                isPayThroughSimSim = false
//            }
//            if isPayThroughJazzcash {
//                isPayThroughJazzcash = false
//            } else {
//                isPayThroughJazzcash = true
//            }
//            tableView.beginUpdates()
//            tableView.endUpdates()
//        }
//
//    }
//
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        if indexPath.row == 0 {
//            if isPaymentMethod {
//                return 120
//            } else {
//                return 55
//            }
//        }
//        if indexPath.row == 1 {
//            if isPayThroughSimSim {
//                return 120
//            } else {
//                return 55
//            }
//        }
//        if indexPath.row == 2 {
//            if isPayThroughJazzcash {
//                return 140
//
//            } else {
//                return 55
//            }
//        }
//
//        return 55
//    }
//}
//
////MARK :- Api for This Page
//extension PaymentOptionsViewController{
//
//    func finjaAuthHome() {
//
//        if !(numberTextfieldFromSimSim?.text?.isEmpty)! || numberTextfieldFromSimSim?.text != ""{
//            self.view.makeToastActivity(.center)
//
//            apiHandlerHome.finajAuthentication(MobileNo: numberTextfieldFromSimSim?.text ?? "-", completionHandler: { (success) in
//                self.view.hideToastActivity()
//                if success {
//                    if let codeApi = self.apiHandlerHome.authenticationData?.code{
//                        if codeApi == "200"{
//                            self.view.makeToast("OTP send successfully!")
//
//                            var cancelAlert = UIAlertController(title: "OTP Verification", message: "We have send you a code on your mobile number, please enter the code below: ", preferredStyle: UIAlertControllerStyle.alert)
//
//                            cancelAlert.addTextField { (textField : UITextField!) in
//                                self.simsimOtpTextfield = textField
//                                textField.placeholder = "Verification code"
//                                textField.keyboardType = .numberPad
//                                textField.inputAccessoryView = self.toolBar
//                                textField.delegate = self
//                            }
//
//                            cancelAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak cancelAlert] (_) in
//                                let textField = cancelAlert!.textFields![0] // Force unwrapping because we know it exists.
//                                print("Text field: \(textField.text)")
//                                self.otpText = textField.text ?? "0"
//                                if let dataObj = self.apiHandlerHome.authenticationData?.data!{
//                                    print(dataObj)
//                                    let TransactionAmount = self.apiHome?.HIresult![0].Premium ?? ""
//                                    let PolicyNumber = self.apiHome?.HIresult![0].OrderID ?? ""
//                                    self.finjaPaymentHome(data:(self.apiHandlerHome.authenticationData)! ,TransactionAmount: TransactionAmount, PolicyNumber: PolicyNumber, OTP: self.otpText!)
//                                }
//
//
//                            }))
//
//                            cancelAlert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { (action: UIAlertAction!) in
//
//                                cancelAlert .dismiss(animated: true, completion: nil)
//
//                            }))
//
//                            self.present(cancelAlert, animated: true, completion: nil)
//
//
//
//                            //                fillDataSource(fromPolices: self.dataHandler!.areas!)
//                        }else{
//                            //make new popup with msg and ok click
//                            var failedAlert = UIAlertController(title: "OTP Failed", message: self.apiHandlerHome.authenticationData?.msg ?? "", preferredStyle: UIAlertControllerStyle.alert)
//                            failedAlert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { (action: UIAlertAction!) in
//
//                                failedAlert .dismiss(animated: true, completion: nil)
//
//                            }))
//
//                            self.present(failedAlert, animated: true, completion: nil)
//                        }
//                    }
//
//                } else {
//                    self.view.makeToast("Failed to send OTP")
//                    //                self.fieldForPicker?.resignFirstResponder()
//                }
//            })
//        }else{
//            self.view.makeToast("please enter the proper number")
//        }
//
//    }
//
//    func finjaAuthTravel() {
//
//        if !(numberTextfieldFromSimSim?.text?.isEmpty)! || numberTextfieldFromSimSim?.text != ""{
//            self.view.makeToastActivity(.center)
//
//            paymentApiHelper.sharedInstance.finajAuthentication(MobileNo: numberTextfieldFromSimSim?.text ?? "-", completionHandler: { (success) in
//                self.view.hideToastActivity()
//                if success {
//                    if let codeApi = paymentApiHelper.sharedInstance.authenticationData?.code{
//                        if codeApi == "200"{
//                            self.view.makeToast("OTP send successfully!")
//                            print(paymentApiHelper.sharedInstance.authenticationData)
//
//                            //                    TIHelper.showAlert(ViewController: self, AlertTitle: "OTP Verification", AlertMessage: "We have send you a code on your mobile number, please enter the code below:", AlertStyle: .alert , Actions: [defaultAction])
//
//                            var cancelAlert = UIAlertController(title: "OTP Verification", message: "We have send you a code on your mobile number, please enter the code below: ", preferredStyle: UIAlertControllerStyle.alert)
//
//                            cancelAlert.addTextField { (textField) in
//                                self.simsimOtpTextfield = textField
//                                textField.placeholder = "Verification code"
//                                textField.keyboardType = .numberPad
//                                textField.inputAccessoryView = self.toolBar
//                                textField.delegate = self
//                            }
//
//
//                            cancelAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak cancelAlert] (_) in
//                                let textField = cancelAlert!.textFields![0] // Force unwrapping because we know it exists.
//                                print("Text field: \(textField.text)")
//                                self.otpText = textField.text ?? "0"
//                                self.finjaPaymentHome(data:(paymentApiHelper.sharedInstance.authenticationData)! ,TransactionAmount: self.apiTravel!.result![0].Premium ?? "", PolicyNumber: self.apiTravel!.result![0].OrderID ?? "000", OTP: self.otpText!)
//                            }))
//
//                            cancelAlert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { (action: UIAlertAction!) in
//
//                                cancelAlert .dismiss(animated: true, completion: nil)
//
//                            }))
//
//                            self.present(cancelAlert, animated: true, completion: nil)
//                        }
//                        else{
//                            //make new popup with msg and ok click
//                            var failedAlert = UIAlertController(title: "OTP Failed", message: paymentApiHelper.sharedInstance.authenticationData?.msg ?? "", preferredStyle: UIAlertControllerStyle.alert)
//                            failedAlert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { (action: UIAlertAction!) in
//
//                                failedAlert .dismiss(animated: true, completion: nil)
//
//                            }))
//
//                            self.present(failedAlert, animated: true, completion: nil)
//                        }
//
//                    }
//
//                } else {
//                    self.view.makeToast("Failed to send OTP")
//                }
//            })
//        }else{
//            self.view.makeToast("please enter the proper number")
//        }
//
//    }
//
//    //    finajGetToken
//    func finajGetToken() {
//
//        if !(numberTextfieldFromSimSim?.text?.isEmpty)! || numberTextfieldFromSimSim?.text != "" || paymentApiHelper.sharedInstance.authenticationData != nil {
//            self.view.makeToastActivity(.center)
//
//            paymentApiHelper.sharedInstance.finajGetToken(UserId: self.mobileNumber ?? "0", Password: self.mobileNumberPass ?? "0", completionHandler: { (Bool, GenerateToken) in
//                self.view.hideToastActivity()
//                if Bool {
//                    self.view.makeToast("Token have been stored")
//                    print(paymentApiHelper.sharedInstance.authenticationToken ?? "No token value")
//                } else {
//                    self.view.makeToast("Failed to get Token")
//                }
//            })
//        }else{
//            self.view.makeToast("please enter the proper number")
//        }
//
//    }
//
//    func finajGetPolicyAmount() {
//
//        if !(numberTextfieldFromSimSim?.text?.isEmpty)! || numberTextfieldFromSimSim?.text != "" || paymentApiHelper.sharedInstance.authenticationData != nil {
//            self.view.makeToastActivity(.center)
//
//            paymentApiHelper.sharedInstance.GetAmountOfPolicy(SalesFoamNo: "00", Type: "00", completionHandler: { (Bool, GetAmountOfPolicyModel) in
//                self.view.hideToastActivity()
//                if Bool {
//                    self.view.makeToast("Amount have been stored")
//                    print(GetAmountOfPolicyModel.Result)
//                } else {
//                    self.view.makeToast("Failed to get Token")
//                }
//            })
//        }else{
//            self.showToast(message: "please enter the proper number")
//        }
//
//    }
//    //finjaPayment
//    func finjaPaymentHome(data: FinjaAuthenticationModel, TransactionAmount: String, PolicyNumber:String, OTP:String) {
//
//        if !(numberTextfieldFromSimSim?.text?.isEmpty)! || numberTextfieldFromSimSim?.text != "" || apiHandlerHome.authenticationData != nil {
//            self.view.makeToastActivity(.center)
//            apiHandlerHome.finjaPayment1(data: data ,TransactionAmount: TransactionAmount, PolicyNumber: PolicyNumber, OTP: OTP) { (Bool, response) in
//                self.view.hideToastActivity()
//                if Bool {
//                    if response.code == "200" {
//                        //MARK: - Previous popup
//                        //                        var successPopup = UIAlertController(title: "Sim Sim Transaction", message: "\(response.msg ?? "no response")", preferredStyle: UIAlertControllerStyle.alert)
//                        var successPopup = UIAlertController(title: "SimSim Transaction", message: "Thank you , your payment has been received successfully , your policy will be emailed to you shortly", preferredStyle: UIAlertControllerStyle.alert)
//
//
//                        successPopup.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak successPopup] (_) in
//                            successPopup!.dismiss(animated: true, completion: nil)
//                            self.navigationController!.popToRootViewController(animated: true)
//                        }))
//                        self.present(successPopup, animated: true, completion: nil)
//                    }else{
//                        self.view.makeToast("\(response.msg ?? "no response")")
//                        print(response.msg ?? "no response")
//                    }
//                } else {
//                    self.view.makeToast("Failed to get Token")
//                }
//            }
//
//        }else{
//            self.view.makeToast("please enter the proper number")
//        }
//
//    }
//
//    //JazzCashPayment
//    func JazzCashPayment(PolicyNumber: String, Amount:String, Key: String, PayMobileNo:String, Description: String) {
//
//        if !(numberTextfieldFromJazzCash?.text?.isEmpty)! || numberTextfieldFromJazzCash?.text != "" {
//            self.view.makeToastActivity(.center)
//            apiHandlerHome.JazzCash(PolicyNumber: PolicyNumber, Amount: Amount, Key: Key, PayMobileNo: PayMobileNo, Description: Description) { (Bool, JazzCashPaymentModel) in
//
//                self.view.hideToastActivity()
//                if Bool {
//                    if JazzCashPaymentModel.TxCode == "200" || JazzCashPaymentModel.TxCode == "000" || JazzCashPaymentModel.TxCode == "121"{
//                        var successPopup = UIAlertController(title: "JazzCash Transaction", message: "Thank you , your payment has been received successfully , your policy will be emailed to you shortly", preferredStyle: UIAlertControllerStyle.alert)
//
//                        successPopup.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak successPopup] (_) in
//                            successPopup!.dismiss(animated: true, completion: nil)
//                            self.navigationController!.popToRootViewController(animated: true)
//                        }))
//
//                        self.present(successPopup, animated: true, completion: nil)
//                    }else{
//                        self.view.makeToast("\(JazzCashPaymentModel.TxMessage ?? "no response")")
//                        //                    self.view.makeToast("Amount have been stored")
//                        print(JazzCashPaymentModel.TxMessage ?? "no response")
//                    }
//
//                } else {
//                    self.view.makeToast("Failed to get Token")
//                }
//            }
//
//        }else{
//            self.view.makeToast("please enter the proper number")
//        }
//
//    }
//}
//
//extension PaymentOptionsViewController: UITextFieldDelegate{
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        if textField == simsimOtpTextfield as UITextField!{ // 7 characters are allowed on homeValueTextField
//            guard let text = textField.text else { return true }
//            let newLength = text.count + string.count - range.length
//            return newLength <= 6 // Bool
//        }
//        return true
//    }
//}
