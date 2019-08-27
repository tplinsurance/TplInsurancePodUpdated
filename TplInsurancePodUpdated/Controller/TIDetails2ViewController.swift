//
//  TIDetails2ViewController.swift
//  TPLInsurance
//
//  Created by Tahir Raza on 03/12/2018.
//  Copyright © 2018 TPLHolding. All rights reserved.
//

import UIKit

class TIDetails2ViewController: UIViewController {

    @IBOutlet weak var nameInsuredTextview: UITextField!
    @IBOutlet weak var emailTextview: UITextField!
    @IBOutlet weak var dobTextview: UITextField!
    @IBOutlet weak var passportTextview: UITextField!
    @IBOutlet weak var cnicTextview: UITextField!
    @IBOutlet weak var cityTextview: UITextField!
    @IBOutlet weak var addressTextview: UITextField!
    
    var coverage: String?
    var travelTypeSelected: String?
    var travelStartDate: String?
    var travelEndDate: String?
    var destination: String?
    var selectedDestination: TIDestinationModel?
    var studentTution: String?
    
    //This controller variables
    
    var nameOfInsured: String?
    var email: String?
    var dob: String?
    var passport: String?
    var cnic: String?
    var city: String?
    var address: String?
    
    var api: travelInsuranceDataHandler?
    lazy var pickerView = UIPickerView()
    var pickerViewDataSource = [String]() {
        didSet {
            pickerView.reloadAllComponents()
            pickerView.isUserInteractionEnabled = true
            
            if pickerViewDataSource.count > 0 {
                if let field = cityTextview {
                            if let selectedValue = api?.city{
                            let text  = selectedValue.Name
                            cityTextview?.text = text
                            let nIndex  = api?.cities?.index(where: { (object) -> Bool in
                                object.Id == selectedValue.Id
                            })
                            
                            pickerView.selectRow(nIndex ?? 0, inComponent: 0, animated: false)
                            selectData(at: nIndex ?? 0)
                            field.becomeFirstResponder()
                        }
                        else{
                            selectDefault(cityTextview)
                        }
                    
                }
            }
        }
    }
    
    func selectData(at index: Int) {
        if let fieldForPicker = cityTextview {
            api?.selectCity(at: index)
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
        if api!.cities != nil {
            fillDataSource(fromPolices: api!.cities!)
        } else {
            self.showActivityIndicatory()
            api?.fetchAndUpdateCities(completionHandler: { (success) in
                DispatchQueue.main.async {
                    self.stopIndicator()
                    if success {
                        fillDataSource(fromPolices: self.api!.cities!)
                    } else {
                        self.cityTextview?.resignFirstResponder()
                    }
                }
            })
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
        dobTextview!.text = dateFormatter.string(from: sender.date)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        populateMyCities()

        // Do any additional setup after loading the view.
        let toolBar = TIHelper.accessoryViewForTextField(target: self, selector: #selector(donePicker))

        self.dobTextview.inputView = datePicker
        dobTextview.inputAccessoryView = toolBar
        dobTextview.delegate = self
        
        passportTextview.delegate = self
        cnicTextview.delegate = self
        addressTextview.delegate = self
        pickerView.delegate = self
        pickerView.dataSource = self
        
        
        nameInsuredTextview.inputAccessoryView = toolBar
        passportTextview.inputAccessoryView = toolBar
        cnicTextview.inputAccessoryView = toolBar
        cityTextview.inputAccessoryView = toolBar
        cityTextview.inputView = pickerView
        addressTextview.inputAccessoryView = toolBar
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let traveltype = travelTypeSelected{
            if traveltype == "Domestic"{
                passportTextview.isHidden = true
            }else{
                passportTextview.isHidden = false
            }
        }
        
        
//        NotificationCenter.default.addObserver(self, selector: #selector(cnicValueChanged(notification:)), name: NSNotification.Name.UITextFieldTextDidChange, object: nil)
    }
    
    @objc func cnicValueChanged(notification : Notification) {
        
//        if let field = notification.object , let underlineField = field as? UITextField , underlineField == self.cnicTextview {
//            self.cnicTextview.formatTextOnChange(changingIn: NSRange.init(location: 0, length: 0), change: "", format: .cnic)
//        }
    }
    
    @objc func donePicker() {
        
        // call details service here
        if let field = dobTextview{
            self.view.endEditing(true)
        }else if let field = cityTextview{
            self.view.endEditing(true)
        }
//        }else if fieldForPicker == travelStartDatePicker{
//            self.view.endEditing(true)
//        }else if fieldForPicker == travelEndDatePicker{
//            self.view.endEditing(true)
//        }else if fieldForPicker == destinationPicker{
//            self.view.endEditing(true)
//
//        }
        else{
            //            populateMyVehiclesDetails()
            print("Not proper picker")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension TIDetails2ViewController: PagerViewDelegate{
    func willMoveTo(next controller: UIViewController, completionHandler: @escaping (Bool) -> Void) {
        if(nameInsuredTextview.text == nil || nameInsuredTextview.text == ""){
            self.showToast(message: "Please fill your name.")
            completionHandler(false)
            return
        }
        if(emailTextview.text == nil || emailTextview.text == ""){
            self.showToast(message: "Please fill your email.")
            completionHandler(false)
            return
        }
        if let email = emailTextview.text{
            if !email.isValidEmail(email: email){
                self.showToast(message: "please enter a valid email")
                return
            }
        }
        if(dobTextview.text == nil || dobTextview.text == ""){
            self.showToast(message: "Please select Date of birth.")
            completionHandler(false)
            return
        }
        if !passportTextview.isHidden {
            if(passportTextview.text == nil || passportTextview.text == ""){
                self.showToast(message: "Please fill your passport number.")
                completionHandler(false)
                return
            }
        }
        
        if(cnicTextview.text == nil || cnicTextview.text == "" || (cnicTextview.text?.count)! < 15){
            self.showToast(message: "Please fill your cnic.")
            completionHandler(false)
            return
        }
        if(cityTextview.text == nil || cityTextview.text == "" || cityTextview.text == "Select City"){
            self.showToast(message: "Please select city.")
            completionHandler(false)
            return
        }
        if(addressTextview.text == nil || addressTextview.text == ""){
            self.showToast(message: "Please fill address.")
            completionHandler(false)
            return
        }
        
        
        if let controller = controller as? TIDetails3ViewController {
            self.nameOfInsured = nameInsuredTextview.text
            self.email = emailTextview.text
            self.dob = dobTextview.text
            self.passport = passportTextview.text
            self.cnic = cnicTextview.text
            self.city = cityTextview.text
            self.address = addressTextview.text
            //previous controller variable
            controller.coverage = self.coverage
            controller.travelTypeSelected = self.travelTypeSelected
            controller.travelStartDate = self.travelStartDate
            controller.travelEndDate = self.travelEndDate
            controller.destination = self.destination
            controller.selectedDestination = self.selectedDestination
            controller.studentTution = self.studentTution
            controller.api = self.api!
            
            //this controller variable
            controller.nameOfInsured = self.nameOfInsured
            controller.email = self.email
            controller.dob = self.dob
            controller.passport = self.passport
            controller.cnic = self.cnic
            controller.city = self.city
            controller.address = self.address
            
            print("first controller from page 2:")
            print("coverage: \(self.coverage) -- travelTypeSelected: \(self.travelTypeSelected) -- travelStartDate: \(self.travelStartDate) -- travelEndDate: \(self.travelEndDate) -- destination: \(self.destination) -- selectedDestination: \(self.selectedDestination) -- studentTution: \(self.studentTution)")
            
            print("Second controller from page 2:")
            print("nameOfInsured: \(self.nameOfInsured) -- email: \(self.email) -- dob: \(self.dob) -- passport: \(self.passport) -- cnic: \(self.cnic) -- city: \(self.city) -- address: \(self.address)")


            
            
            completionHandler(true)
        }
    }
    
}

extension TIDetails2ViewController: UITextFieldDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        //datePicker.isUserInteractionEnabled = false
        let currentDate: Date = Date()
        var calendar: Calendar = Calendar(identifier: Calendar.Identifier.gregorian)
        calendar.timeZone = TimeZone(identifier: "UTC")!
        var components: DateComponents = DateComponents()
        components.calendar = calendar
        components.year = -18
        let maxDate: Date = calendar.date(byAdding: components, to: currentDate)!
        if self.travelTypeSelected == "Hajj and Umrah" || self.travelTypeSelected == "Ziarat" || self.travelTypeSelected == "Student" || self.coverage == "Family" {
            components.year = -60
        }else{
            components.year = -100
        }
        let minDate: Date = calendar.date(byAdding: components, to: currentDate)!
        var minimumDate = minDate
        var maximumDate = maxDate
        
        if textField == self.dobTextview {
            datePicker.maximumDate = maximumDate
            datePicker.minimumDate = minimumDate
            print("please select date after today")
        }
        
//        if textField == self.dobTextview{
//            datePicker.minimumDate = Date()
//            print("please select date after today")
//        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == self.cnicTextview{
            guard let text = textField.text else { return true }
            let newLength = text.count + string.count - range.length
            return newLength <= 15 // Bool
            
            if let textField = textField as? UnderLineTextField,
                textField.isValidatingLimit {
                let shouldReplace = textField.validateForLength(changingIn: range, change: string)
                
                if textField == self.cnicTextview,
                    shouldReplace {
                    textField.formatTextOnChange(changingIn: range, change: string, format: .cnic)
                }
                
                return shouldReplace
            }
        }else if textField == self.passportTextview { // 30 characters are allowed on first name
            guard let text = textField.text else { return true }
            let newLength = text.count + string.count - range.length
            return newLength <= 9 // Bool
        }else if textField == self.addressTextview { // 30 characters are allowed on first name
            guard let text = textField.text else { return true }
            let newLength = text.count + string.count - range.length
            return newLength <= 70 // Bool
        }
        return true
    }
}

extension TIDetails2ViewController: UIPickerViewDelegate,UIPickerViewDataSource{
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerViewDataSource.count
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerViewDataSource[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let text = pickerViewDataSource[row]
        cityTextview?.text = text
        selectData(at: row)
    }
}

