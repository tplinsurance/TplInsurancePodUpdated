//
//  HIDetailsViewController.swift
//  TPLInsurance
//
//  Created by Tahir Raza on 30/11/2018.
//  Copyright © 2018 TPLHolding. All rights reserved.
//

import UIKit

class HIDetailsViewController: UIViewController {
    
    @IBOutlet weak var nameTextfield: UnderLineTextField!
    @IBOutlet weak var dobTextField: UnderLineTextField!
    @IBOutlet weak var emailTextField: UnderLineTextField!
    @IBOutlet weak var typeTextfield: UnderLineTextField!
    @IBOutlet weak var cnicTextfield: UnderLineTextField!
    @IBOutlet weak var addressTextfield: UnderLineTextField!
    @IBOutlet weak var cityResidenceTextfield: UnderLineTextField!
    @IBOutlet weak var residentialAreaTextfield: UnderLineTextField!
    @IBOutlet weak var tenantsNameTextfield: UnderLineTextField!
    @IBOutlet weak var landlordNameTextfield: UnderLineTextField!
    @IBOutlet weak var tenantsCnicTextfield: UnderLineTextField!
    @IBOutlet weak var landlordCnicTextfield: UnderLineTextField!
    @IBOutlet weak var homeInsuranceSwitch: UISwitch!
    @IBOutlet weak var switchLabel: UILabel!
    //    @IBOutlet weak var homeInsuranceTextField: UnderLineTextField!
    @IBOutlet weak var homeValueTextField: UnderLineTextField!
    @IBAction func switchAction(_ sender: Any) {
        if homeInsuranceSwitch.isOn{
            homeValueTextField.isHidden = false
        }else{
            homeValueTextField.isHidden = true
            homeValueTextField.text = "0"
        }
    }
    
    var pickerViewDataSource = [String]() {
        didSet {
            pickerView.reloadAllComponents()
            pickerView.isUserInteractionEnabled = true
            
            if pickerViewDataSource.count > 0 {
                if let field = fieldForPicker {
                    
                    switch(field){
                    case cityResidenceTextfield:
                        if let selectedValue = api.city{
                            let text  = selectedValue.Name
                            fieldForPicker?.text = text
                            let nIndex  = api.cities?.index(where: { (object) -> Bool in
                                object.Id == selectedValue.Id
                            })
                            
                            pickerView.selectRow(nIndex ?? 0, inComponent: 0, animated: false)
                            selectData(at: nIndex ?? 0)
                            field.becomeFirstResponder()
                        }
                        else{
                            selectDefault(cityResidenceTextfield)
                        }
                    case residentialAreaTextfield:
                        if let selectedValue = api.area{
                            let text  = selectedValue.Name
                            fieldForPicker?.text = text
                            let nIndex  = api.areas?.index(where: { (object) -> Bool in
                                object.Id == selectedValue.Id
                            })
                            
                            pickerView.selectRow(nIndex ?? 0, inComponent: 0, animated: false)
                            selectData(at: nIndex ?? 0)
                            field.becomeFirstResponder()
                        }
                        else{
                            selectDefault(residentialAreaTextfield)
                        }
                    default:
                        break
                    }
                    
                }
            }
        }
    }
    
    let datePicker :UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.addTarget(self, action: #selector(datePickerValueChanged(sender:)), for: .valueChanged)
        return datePicker
    }()
    
    @objc func datePickerValueChanged(sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = TIDateFormats.surveyFormat
        dobTextField!.text = dateFormatter.string(from: sender.date)
    }
    
    var name: String?
    var email: String?
    var DOB: String?
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
    
    var ownerType: [homeInsuranceModel]?
    
    lazy var pickerView = UIPickerView()
    var fieldForPicker: UnderLineTextField?
    var api = HomeInsuranceDataHandler()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getPackages()

        
        let toolBar = TIHelper.accessoryViewForTextField(target: self, selector: #selector(donePicker))
        
        typeTextfield.inputAccessoryView = toolBar
        typeTextfield.inputView = pickerView
        typeTextfield.delegate = self
        
        cityResidenceTextfield.inputAccessoryView = toolBar
        cityResidenceTextfield.inputView = pickerView
        cityResidenceTextfield.delegate = self
        
        self.dobTextField.inputView = datePicker
        dobTextField.inputAccessoryView = toolBar
        dobTextField.delegate = self
        
        residentialAreaTextfield.inputAccessoryView = toolBar
        residentialAreaTextfield.inputView = pickerView
        residentialAreaTextfield.delegate = self
        
        nameTextfield.inputAccessoryView = toolBar
        emailTextField.inputAccessoryView = toolBar
        cnicTextfield.inputAccessoryView = toolBar
        addressTextfield.inputAccessoryView = toolBar
        tenantsNameTextfield.inputAccessoryView = toolBar
        tenantsCnicTextfield.inputAccessoryView = toolBar
        landlordCnicTextfield.inputAccessoryView = toolBar
        homeValueTextField.inputAccessoryView = toolBar
        landlordNameTextfield.inputAccessoryView = toolBar

        nameTextfield.delegate = self
        emailTextField.delegate = self
        cnicTextfield.delegate = self
        addressTextfield.delegate = self
        tenantsNameTextfield.delegate = self
        tenantsCnicTextfield.delegate = self
        landlordCnicTextfield.delegate = self
        homeValueTextField.delegate = self
        
        pickerView.delegate = self
        pickerView.dataSource = self
        
        // Do any additional setup after loading the view.
        
    }
    
    
    func selectData(at index: Int) {
        if fieldForPicker == cityResidenceTextfield {
            api.selectCity(at: index)
        } else if fieldForPicker == residentialAreaTextfield {
            api.selectArea(at: index)
        }
    }
    
    @objc func donePicker() {
        
        // call details service here
        if let field = typeTextfield{
            //            populateGetMobileInsuranceDetail()
            if field.text == ownerType![2].name{
                //                tenantsNameTextfield.placeholder == "Home structure value? (Max 32Million)"
                //                tenantsCnicTextfield.placeholder == "Do you want to insure Home structure?"
                tenantsNameTextfield.isHidden = true
                tenantsCnicTextfield.isHidden = true
                landlordNameTextfield.isHidden = true
                landlordCnicTextfield.isHidden = true
                homeInsuranceSwitch.isHidden = false
                switchLabel.isHidden = false
                if homeInsuranceSwitch.isOn{
                    homeValueTextField.isHidden = false
                }else{
                    homeValueTextField.isHidden = true
                }
            }else if field.text == ownerType![3].name{
//                tenantsNameTextfield.placeholder = "Land Lord Name"
//                tenantsCnicTextfield.placeholder = "Land Lord CNIC"
                landlordNameTextfield.isHidden = false
                landlordCnicTextfield.isHidden = false
                homeInsuranceSwitch.isHidden = true
                switchLabel.isHidden = true
                homeValueTextField.isHidden = true
                tenantsNameTextfield.isHidden = true
                tenantsCnicTextfield.isHidden = true
            }else if field.text == ownerType![1].name{
//                tenantsNameTextfield.placeholder = "Tenant Name"
//                tenantsCnicTextfield.placeholder = "Tenant CNIC"
                self.api.homeInsured = ""
                self.api.homeValue = ""
                landlordNameTextfield.isHidden = true
                landlordCnicTextfield.isHidden = true
                tenantsNameTextfield.isHidden = false
                tenantsCnicTextfield.isHidden = false
                homeInsuranceSwitch.isHidden = true
                switchLabel.isHidden = true
                homeValueTextField.isHidden = true
            }else{
                homeInsuranceSwitch.isHidden = true
                homeValueTextField.isHidden = true
            }
            self.view.endEditing(true)
        }else if let field = cityResidenceTextfield{
            self.view.endEditing(true)
        }else if let field = residentialAreaTextfield{
            self.view.endEditing(true)
        }else if let field = dobTextField{
            self.view.endEditing(true)
        }
        else{
            //            populateMyVehiclesDetails()
            self.view.endEditing(true)
            print("Not proper picker")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
//        NotificationCenter.default.addObserver(self, selector: #selector(cnicValueChanged(notification:)), name: NSNotification.Name.UITextField.textDidChangeNotification, object: nil)
    }
    
    @objc func cnicValueChanged(notification : Notification) {
        
        if let field = notification.object , let underlineField = field as? UITextField , underlineField == self.cnicTextfield {
            self.cnicTextfield.formatTextOnChange(changingIn: NSRange.init(location: 0, length: 0), change: "", format: .cnic)
        }
        if let field = notification.object , let underlineField = field as? UITextField , underlineField == self.tenantsCnicTextfield {
            self.tenantsCnicTextfield.formatTextOnChange(changingIn: NSRange.init(location: 0, length: 0), change: "", format: .cnic)
        }
        if let field = notification.object , let underlineField = field as? UITextField , underlineField == self.landlordCnicTextfield {
            self.landlordCnicTextfield.formatTextOnChange(changingIn: NSRange.init(location: 0, length: 0), change: "", format: .cnic)
        }
    }
    
    func selectDefault(_ textField : UITextField) {
        textField.becomeFirstResponder()
        textField.text = pickerViewDataSource[0]
        pickerView.selectRow(0, inComponent: 0, animated: false)
        selectData(at: 0)
    }
    
    func populateMyCities() {
        func fillDataSource(fromPolices policies: [City]) {
            let names = policies.flatMap{ (city) -> String? in
                return city.Name
            }
            pickerViewDataSource = names
        }
        if api.cities != nil {
            fillDataSource(fromPolices: api.cities!)
        } else {
//            self.view.makeToastActivity(.center)
            self.showActivityIndicatory()
            api.fetchAndUpdateCities(completionHandler: { (success) in
                DispatchQueue.main.async {
//                    self.view.hideToastActivity()
                    self.stopIndicator()
                    if success {
                        fillDataSource(fromPolices: self.api.cities!)
                    } else {
                        self.fieldForPicker?.resignFirstResponder()
                    }
                }
            })
        }
    }
    
    func populateMyAreas() {
        func fillDataSource(fromPolices policies: [Area]) {
            let names = policies.flatMap{ (area) -> String? in
                return area.Name
            }
            pickerViewDataSource = names
        }
        if api.areas != nil {
            fillDataSource(fromPolices: api.areas!)
        } else {
            self.showActivityIndicatory()
            api.fetchArea(completionHandler: { (success) in
                DispatchQueue.main.async {
//                    self.view.hideToastActivity()
                    self.stopIndicator()
                    if success {
                        fillDataSource(fromPolices: self.api.areas!)
                    } else {
                        self.fieldForPicker?.resignFirstResponder()
                    }
                }
            })
        }
    }
    
    func getPackages(){
        if api.homePackages != nil{
            
        }else{
//            self.view.makeToastActivity(.center)
            self.showActivityIndicatory()
            api.fetchAndUpdateHomePackage(completionHandler: { (success) in
                DispatchQueue.main.async {
//                    self.view.hideToastActivity()
                    self.stopIndicator()
                    if success{
                        print("fethced types successfully")
//                        self.view.hideToastActivity()
                        self.stopIndicator()
                        self.view.isUserInteractionEnabled = true
                        self.ownerType = self.api.homePackages
                        
                    }else{
                        print("No packages available")
                    }
                    //                    if success{
                    //                        if let controllerSummary = controller as? HIPackagesViewController {
                    //                            controllerSummary.api = self.api
                    //
                    //                            completionHandler(true)
                    //                        } else {
                    //                            completionHandler(false)
                    //                        }
                    //                        self.view.hideToastActivity()
                    //                        self.view.isUserInteractionEnabled = true
                    //
                    //                    }else{
                    //                        print("No packages available")
                    //                    }
                }
            })
        }
    }
    
}

extension HIDetailsViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if typeTextfield.isFirstResponder{
            return ownerType?.count ?? 0
        }else {
            return pickerViewDataSource.count
        }
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if fieldForPicker == typeTextfield{
            return self.ownerType?[row].name
        }else if fieldForPicker == cityResidenceTextfield{
            //get the size of array and populate picker
            return pickerViewDataSource[row]
        }else if fieldForPicker == residentialAreaTextfield{
            //get the size of array and populate picker
            return pickerViewDataSource[row]
        }
        return "Else"
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if typeTextfield.isFirstResponder{
            //            let itemselected = fieldForPicker?.text
            //            let itemselected = "Coverage Picker"
            if let value = ownerType![row].name{
                typeTextfield.text = ownerType![row].name
            }else{
                self.fieldForPicker?.resignFirstResponder()
            }
            
            
        }else if cityResidenceTextfield.isFirstResponder{
            let text = pickerViewDataSource[row]
            fieldForPicker?.text = text
            selectData(at: row)
            
            print("value of selected city is: \(api.city)")
//            let itemselected = "city Residence"
//            cityResidenceTextfield.text = itemselected
        }else if residentialAreaTextfield.isFirstResponder{
//            let itemselected = "residential Area"
//            residentialAreaTextfield.text = itemselected
            
            let text = pickerViewDataSource[row]
            fieldForPicker?.text = text
            selectData(at: row)
            
            print("value of selected city is: \(api.area)")
        }
    }
    
    
}

// MARK: - UITEXTFIELD DELEGATE
extension HIDetailsViewController: UITextFieldDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        fieldForPicker = textField as! UnderLineTextField
        
        let currentDate: Date = Date()
        var calendar: Calendar = Calendar(identifier: Calendar.Identifier.gregorian)
        calendar.timeZone = TimeZone(identifier: "UTC")!
        var components: DateComponents = DateComponents()
        components.calendar = calendar
        components.year = -18
        let maxDate: Date = calendar.date(byAdding: components, to: currentDate)!
        let maximumDate = maxDate
        
        if textField == self.dobTextField {
            datePicker.maximumDate = maximumDate
            print("please select date after today")
        }
        
        
        if textField == cityResidenceTextfield {
            populateMyCities()
        } else if textField == residentialAreaTextfield {
            populateMyAreas()
        }
        
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if textField == self.cnicTextfield{
            guard let text = textField.text else { return true }
            let newLength = text.count + string.count - range.length
            return newLength <= 15 // Bool
            
            if let textField1 = textField as? UnderLineTextField,
                textField1.isValidatingLimit {
                let shouldReplace = textField1.validateForLength(changingIn: range, change: string)
                
                if textField == self.cnicTextfield,
                    shouldReplace {
                    textField1.formatTextOnChange(changingIn: range, change: string, format: .cnic)
                }
                
                return shouldReplace
            }
        }else if textField == self.tenantsCnicTextfield{
            guard let text = textField.text else { return true }
            let newLength = text.count + string.count - range.length
            return newLength <= 15 // Bool
            
            if let textField1 = textField as? UnderLineTextField,
                textField1.isValidatingLimit {
                let shouldReplace = textField1.validateForLength(changingIn: range, change: string)
                
                if textField == self.tenantsCnicTextfield,
                    shouldReplace {
                    textField1.formatTextOnChange(changingIn: range, change: string, format: .cnic)
                }
                
                return shouldReplace
            }
        }else if textField == self.landlordCnicTextfield{
            guard let text = textField.text else { return true }
            let newLength = text.count + string.count - range.length
            return newLength <= 15 // Bool
            
            if let textField1 = textField as? UnderLineTextField,
                textField1.isValidatingLimit {
                let shouldReplace = textField1.validateForLength(changingIn: range, change: string)
                
                if textField == self.landlordCnicTextfield,
                    shouldReplace {
                    textField1.formatTextOnChange(changingIn: range, change: string, format: .cnic)
                }
                
                return shouldReplace
            }
        }else if textField == self.nameTextfield{
            do {
                let regex = try NSRegularExpression(pattern: ".*[^A-Za-z ].*", options: [])
                if regex.firstMatch(in: string, options: [], range: NSMakeRange(0, string.count)) != nil {
                return false
                }
            }
            catch {
                print("ERROR")
            }
            return true
        }else if textField == self.nameTextfield { // 30 characters are allowed on first name
            guard let text = textField.text else { return true }
            let newLength = text.count + string.count - range.length
            return newLength <= 40 // Bool
        }else if textField == self.emailTextField { // 50 characters are allowed on company name
            guard let text = textField.text else { return true }
            let newLength = text.count + string.count - range.length
            return newLength <= 80 // Bool
        }else if textField == self.addressTextfield { // 50 characters are allowed on company name
            guard let text = textField.text else { return true }
            let newLength = text.count + string.count - range.length
            return newLength <= 70 // Bool
        }else if textField == self.tenantsNameTextfield { // 70 characters are allowed on address
            guard let text = textField.text else { return true }
            let newLength = text.count + string.count - range.length
            return newLength <= 40 // Bool
        }else if textField == self.tenantsCnicTextfield { // 13 characters are allowed on CNIC
            guard let text = textField.text else { return true }
            let newLength = text.count + string.count - range.length
            return newLength <= 15 // Bool
        }else if textField == self.homeValueTextField { // 7 characters are allowed on homeValueTextField
            guard let text = textField.text else { return true }
            let newLength = text.count + string.count - range.length
            return newLength <= 8 // Bool
        }
        return true
        
//        if let field = self.cnicTextfield{
//            guard let text = textField.text else { return true }
//            let newLength = text.count + string.count - range.length
//            return newLength <= 15 // Bool
//
//            if let textField = field as? UnderLineTextField,
//                textField.isValidatingLimit {
//                let shouldReplace = textField.validateForLength(changingIn: range, change: string)
//
//                if textField == self.cnicTextfield,
//                    shouldReplace {
//                    textField.formatTextOnChange(changingIn: range, change: string, format: .cnic)
//                }
//
//                return shouldReplace
//            }
//        }else if let field = self.tenantsCnicTextfield{
//            guard let text = textField.text else { return true }
//            let newLength = text.count + string.count - range.length
//            return newLength <= 15 // Bool
//
//            if let textField = field as? UnderLineTextField,
//                textField.isValidatingLimit {
//                let shouldReplace = textField.validateForLength(changingIn: range, change: string)
//
//                if textField == self.tenantsCnicTextfield,
//                    shouldReplace {
//                    textField.formatTextOnChange(changingIn: range, change: string, format: .cnic)
//                }
//
//                return shouldReplace
//            }
//        }else if let field = self.landlordCnicTextfield{
//            guard let text = textField.text else { return true }
//            let newLength = text.count + string.count - range.length
//            return newLength <= 15 // Bool
//
//            if let textField = field as? UnderLineTextField,
//                textField.isValidatingLimit {
//                let shouldReplace = textField.validateForLength(changingIn: range, change: string)
//
//                if textField == self.landlordCnicTextfield,
//                    shouldReplace {
//                    textField.formatTextOnChange(changingIn: range, change: string, format: .cnic)
//                }
//
//                return shouldReplace
//            }
//        }else if textField == self.nameTextfield { // 30 characters are allowed on first name
//            guard let text = textField.text else { return true }
//            let newLength = text.count + string.count - range.length
//            return newLength <= 10 // Bool
//        }else if textField == self.addressTextfield { // 50 characters are allowed on company name
//            guard let text = textField.text else { return true }
//            let newLength = text.count + string.count - range.length
//            return newLength <= 70 // Bool
//        }else if textField == self.tenantsNameTextfield { // 70 characters are allowed on address
//            guard let text = textField.text else { return true }
//            let newLength = text.count + string.count - range.length
//            return newLength <= 40 // Bool
//        }else if textField == self.tenantsCnicTextfield { // 13 characters are allowed on CNIC
//            guard let text = textField.text else { return true }
//            let newLength = text.count + string.count - range.length
//            return newLength <= 15 // Bool
//        }else if textField == self.homeValueTextField { // 7 characters are allowed on homeValueTextField
//            guard let text = textField.text else { return true }
//            let newLength = text.count + string.count - range.length
//            return newLength <= 7 // Bool
//        }
//        return true
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        fieldForPicker = textField as! UnderLineTextField
        if fieldForPicker == typeTextfield{
        }
        if fieldForPicker == typeTextfield {
            homeValueTextField.text = "0"
        }
        pickerView.reloadAllComponents()
        return true
    }
}

// MARK: - Next View Controller
extension HIDetailsViewController: PagerViewDelegate {
    func willMoveTo(next controller: UIViewController, completionHandler: @escaping (Bool) -> Void) {
        if nameTextfield.text == "" || nameTextfield.text == nil{
//            self.view.makeToast("please enter the name")
            self.showToast(message: "please enter the name")
            return
        }
        if dobTextField.text == "" || dobTextField.text == nil{
            self.showToast(message: "please enter the DOB")
            return
        }
        if emailTextField.text == "" || emailTextField.text == nil{
            self.showToast(message: "please enter the email")
            return
        }
        if let email = emailTextField.text{
            if !email.isValidEmail(email: email){
                self.showToast(message: "please enter a valid email")
                return
            }
        }
        if typeTextfield.text == "" || typeTextfield.text == nil || typeTextfield.text == "- Please Select -"{
            self.showToast(message: "Please select your role")
            return
        }
        if cnicTextfield.text! == "" || cnicTextfield.text == nil || (cnicTextfield.text?.underestimatedCount)! < 15{
            self.showToast(message: "please enter the CNIC number")
            return
        }
        if addressTextfield.text == "" || addressTextfield.text == nil{
            self.showToast(message: "please enter the address")
            return
        }
        if cityResidenceTextfield.text == "" || cityResidenceTextfield.text == nil || cityResidenceTextfield.text == "Select City"{
            self.showToast(message: "please select your city")
            return
        }
        if residentialAreaTextfield.text == "" || residentialAreaTextfield.text == nil{
            self.showToast(message: "please select your Residential Area")
            return
        }
        if !(tenantsNameTextfield.isHidden){
            if tenantsNameTextfield.text == "" || tenantsNameTextfield.text == nil{
                self.showToast(message: "please Tenant's name")
                return
            }
        }
        if !(landlordNameTextfield.isHidden){
            if landlordNameTextfield.text == "" || landlordNameTextfield.text == nil{
                self.showToast(message: "please Landlord's name")
                return
            }
        }
        
        if !(landlordCnicTextfield.isHidden){
            if landlordCnicTextfield.text! == "" || landlordCnicTextfield.text == nil || (landlordCnicTextfield.text?.underestimatedCount)! < 15{
                self.showToast(message: "please enter the Landlord's CNIC number")
                return
            }
        }
        if !(tenantsCnicTextfield.isHidden){
            if tenantsCnicTextfield.text! == "" || tenantsCnicTextfield.text == nil || (tenantsCnicTextfield.text?.underestimatedCount)! < 15{
                self.showToast(message: "please enter the tenant's CNIC number")
                return
            }
        }
        if !(homeInsuranceSwitch.isHidden){
            if homeInsuranceSwitch.isOn == true{
                if homeValueTextField.text! == "" || homeValueTextField.text == nil || Int(homeValueTextField.text!)! > 30000000{
                    self.showToast(message: "Home value could not exceed 30 Million")
                    return
                } else if homeValueTextField.text! == "" || homeValueTextField.text == nil || Int(homeValueTextField.text!)! < 2000000{
                    self.showToast(message: "Minimum Home Structure value is 2 Million")
                    return
                }
            }
        }
        
        self.name = nameTextfield.text
        self.email = emailTextField.text
        self.DOB = dobTextField.text
        self.type = typeTextfield.text
        self.cnic = cnicTextfield.text ?? "0"
        self.address = addressTextfield.text ?? "no address"
        self.cityResidence = cityResidenceTextfield.text ?? "no city"
        self.residentialArea = residentialAreaTextfield.text ?? "no residential area"
        self.tenantsName = tenantsNameTextfield.text ?? ""
        self.tenantsCnic = tenantsCnicTextfield.text ?? ""
        self.landlordsName = landlordNameTextfield.text ?? ""
        self.landlordsCnic = landlordCnicTextfield.text ?? ""
        if homeInsuranceSwitch.isOn{
            self.homeInsured = "Y"
        }else{
            self.homeInsured = "N"
        }
        
        if let abc = homeValueTextField.text{
            self.homeValue = homeValueTextField.text

        }
        
        self.getPackagesController(with: controller, completionHandler: completionHandler)
        
    }
}

// MARK: - API FOR PACKAGES
extension HIDetailsViewController{
    func getPackagesController(with controller: UIViewController, completionHandler: @escaping(Bool) -> Void) {
        UIApplication.shared.beginIgnoringInteractionEvents()
        api.HomeInsurancePackages(Name: self.type ?? "", SumInsured: homeValue ?? "0") { (success, message) in
//            self.view.hideToastActivity()
            self.stopIndicator()
            UIApplication.shared.endIgnoringInteractionEvents()
            if success{
                if let controllerSummary = controller as? HIPackagesViewController {
                    self.view.isUserInteractionEnabled = true
                    self.homePackageDetail = message
                    print("name: \(self.name) ----- type:\(self.type) ----- cnic:\(self.cnic) ----- type:\(self.type)----- address:\(self.address) ----- cityResidence:\(self.cityResidence) ----- residentialArea:\(self.residentialArea) ----- tenantsName:\(self.tenantsName) ----- tenantsCnic:\(self.tenantsCnic) ----- landlordsName:\(self.landlordsName) ----- landlordsCnic:\(self.landlordsCnic) ----- homeInsured:\(self.homeInsured) ----- homeValue:\(self.homeValue) ----- type: ----- type:type")
                    self.api.name = self.name
                    self.api.email = self.email
                    self.api.DOB = self.DOB
                    self.api.type = self.type
                    self.api.cnic = self.cnic
                    self.api.address = self.address
                    self.api.cityResidence = self.cityResidence
                    self.api.residentialArea = self.residentialArea
                    self.api.tenantsName = self.tenantsName
                    self.api.tenantsCnic = self.tenantsCnic
                    self.api.landlordsName = self.landlordsName
                    self.api.landlordsCnic = self.landlordsCnic
                    self.api.homeInsured = self.homeInsured
                    self.api.homeValue = self.homeValue ?? ""

                    controllerSummary.homePackageDetail = self.homePackageDetail
                    controllerSummary.api = self.api

                    
                    completionHandler(true)
                } else {
                    completionHandler(false)
                }
//                self.view.hideToastActivity()
                self.stopIndicator()
                self.view.isUserInteractionEnabled = true
            } else {
                self.showToast(message: "not success")
            }
        }
        
    }
    
}



