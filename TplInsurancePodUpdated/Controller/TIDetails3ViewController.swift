//
//  TIDetails3ViewController.swift
//  TPLInsurance
//
//  Created by Tahir Raza on 03/12/2018.
//  Copyright © 2018 TPLHolding. All rights reserved.
//

import UIKit

class TIDetails3ViewController: UIViewController {

    @IBOutlet weak var bNameTextview: UITextField!
    @IBOutlet weak var bAddressTextview: UITextField!
    @IBOutlet weak var bCnicTextview: UITextField!
    @IBOutlet weak var bContactTextview: UITextField!
    @IBOutlet weak var bRelationTextview: UITextField!
        
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
    //ThisController
    var bName: String?
    var bAddress: String?
    var bCnic: String?
    var bContact: String?
    var bRelation: String?
    
//    var relations: [TIGetRelationshipModel]?
    var api = travelInsuranceDataHandler()
    
    lazy var pickerView = UIPickerView()

    override func viewDidLoad() {
        super.viewDidLoad()
        getrelations()
        let toolBar = TIHelper.accessoryViewForTextField(target: self, selector: #selector(donePicker))
        
        //delegates for textviews
        bNameTextview.delegate = self
        bAddressTextview.delegate = self
        bCnicTextview.delegate = self
        bContactTextview.delegate = self
        bRelationTextview.delegate = self
        bRelationTextview.inputView = pickerView
        
        bNameTextview.inputAccessoryView = toolBar
        bAddressTextview.inputAccessoryView = toolBar
        bCnicTextview.inputAccessoryView = toolBar
        bContactTextview.inputAccessoryView = toolBar
        bRelationTextview.inputAccessoryView = toolBar
        
        pickerView.delegate = self
        pickerView.dataSource = self

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(self, selector: #selector(cnicValueChanged(notification:)), name: NSNotification.Name.NSMetadataQueryDidUpdate, object: nil)
    }
    
    @objc func donePicker() {
        self.view.endEditing(true)
    }
    
    @objc func cnicValueChanged(notification : Notification) {
        
        if let field = notification.object , let underlineField = field as? UITextField , underlineField == self.bCnicTextview {
//            self.bCnicTextview.(changingIn: NSRange.init(location: 0, length: 0), change: "", format: .cnic)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension TIDetails3ViewController{
    func getrelations(){
        if api.Relationships != nil{
            
        }else{
            self.showActivityIndicatory()
            api.TIGetRelationship(completionHandler: { (success) in
                DispatchQueue.main.async {
                    self.stopIndicator()
                    if success{
                        print("fetched Relations successfully")
                       self.stopIndicator()
                        self.view.isUserInteractionEnabled = true
//                        self.relations = self.api.Relationships
                        
                    }else{
                        print("No packages available")
                    }
                }
            })
        }
    }
    
}

extension TIDetails3ViewController: UITextFieldDelegate{
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == self.bCnicTextview{
            guard let text = textField.text else { return true }
            let newLength = text.count + string.count - range.length
            return newLength <= 15 // Bool
            
            if let textField = textField as? UnderLineTextField,
                textField.isValidatingLimit {
                let shouldReplace = textField.validateForLength(changingIn: range, change: string)
                
                if textField == self.bCnicTextview,
                    shouldReplace {
                    textField.formatTextOnChange(changingIn: range, change: string, format: .cnic)
                }
                
                return shouldReplace
            }
        }else if textField == self.bNameTextview { // 30 characters are allowed on first name
            guard let text = textField.text else { return true }
            let newLength = text.count + string.count - range.length
            return newLength <= 30 // Bool
        }else if textField == self.bAddressTextview { // 30 characters are allowed on first name
            guard let text = textField.text else { return true }
            let newLength = text.count + string.count - range.length
            return newLength <= 70 // Bool
        }else if textField == self.bContactTextview { // 30 characters are allowed on first name
            guard let text = textField.text else { return true }
            let newLength = text.count + string.count - range.length
            return newLength <= 11 // Bool
        }
        return true
    }
    
}

extension TIDetails3ViewController: UIPickerViewDelegate, UIPickerViewDataSource{
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return api.Relationships?.count ?? 0
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return api.Relationships![row].name ?? "no text"
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let text = api.Relationships![row].name
        bRelationTextview?.text = text
        selectData(at: row)
    }
    
    func selectData(at index: Int) {
        if let fieldForPicker = bRelationTextview {
            api.selectedBeneRelationships(at: index)
        }
    }
}

extension TIDetails3ViewController: PagerViewDelegate{
    
    func willMoveTo(next controller: UIViewController, completionHandler: @escaping (Bool) -> Void) {
        if(bNameTextview.text == nil || bNameTextview.text == ""){
            self.showToast(message: "Please fill beneficiary name.")
//            completionHandler(false)
            return
        }
        if(bAddressTextview.text == nil || bAddressTextview.text == ""){
            self.showToast(message: "Please fill beneficiary address.")
//            completionHandler(false)
            return
        }
        if(bCnicTextview.text == nil || bCnicTextview.text == "" || (bCnicTextview.text?.count)! < 15){
            self.showToast(message: "Please fill your cnic number.")
//            completionHandler(false)
            return
        }
        if(bContactTextview.text == nil || bContactTextview.text == "" || bContactTextview.text?.count ?? 0 < 11){
            self.showToast(message: "Please fill your contact number.")
//            completionHandler(false)
            return
        }
        if(bRelationTextview.text == nil || bRelationTextview.text == "" || bRelationTextview.text == "- Please Select -"){
            self.showToast(message: "Please select relation.")
//            completionHandler(false)
            return
        }
        
        if self.coverage! == "Individual" {
            print("coverage in 3rd controller is: \(self.coverage)")
            completionHandler(false)
        }else{
            completionHandler(true)
            print("coverage in 3rd controller is not indiviual")
        }
        

        
        
//        if let controller = controller as? TIFamilyDetailsViewController {
//            self.bName = bNameTextview.text
//            self.bAddress = bAddressTextview.text
//            self.bCnic = bCnicTextview.text
//            self.bContact = bContactTextview.text
//            self.bRelation = bRelationTextview.text
//            //first controller variable
//            controller.coverage = self.coverage
//            controller.travelTypeSelected = self.travelTypeSelected
//            controller.travelStartDate = self.travelStartDate
//            controller.travelEndDate = self.travelEndDate
//            controller.destination = self.destination
//            controller.selectedDestination = self.selectedDestination
//            controller.api = self.api
//
//            //first controller variable
//            controller.nameOfInsured = self.nameOfInsured
//            controller.dob = self.dob
//            controller.passport = self.passport
//            controller.cnic = self.cnic
//            controller.city = self.city
//            controller.address = self.address
//
//            //this controller variable
//            controller.bName = self.bName
//            controller.bAddress = self.bAddress
//            controller.bCnic = self.bCnic
//            controller.bContact = self.bContact
//            controller.bRelation = self.bRelation
//
//            completionHandler(true)
//        }
        
//        completionHandler(false)
        
        // FIXME: commenting ahsan's logic
        if self.coverage == "Individual" {
            if let controller = controller as? NewTIPackagesViewController {
                self.bName = bNameTextview.text
                self.bAddress = bAddressTextview.text
                self.bCnic = bCnicTextview.text
                self.bContact = bContactTextview.text
                self.bRelation = bRelationTextview.text

                controller.coverage = self.coverage
                controller.travelTypeSelected = self.travelTypeSelected
                controller.travelStartDate = self.travelStartDate
                controller.travelEndDate = self.travelEndDate
                controller.destination = self.destination
                controller.selectedDestination = self.selectedDestination
                controller.studentTution = self.studentTution
                controller.api = self.api
                
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
                
                print("first controller from page 3:")
                print("coverage: \(self.coverage) -- travelTypeSelected: \(self.travelTypeSelected) -- travelStartDate: \(self.travelStartDate) -- travelEndDate: \(self.travelEndDate) -- destination: \(self.destination) -- selectedDestination: \(self.selectedDestination) -- studentTution: \(self.studentTution)")
                
                print("Second controller from page 3:")
                print("nameOfInsured: \(self.nameOfInsured) -- email: \(self.email) -- dob: \(self.dob) -- passport: \(self.passport) -- cnic: \(self.cnic) -- city: \(self.city) -- address: \(self.address)")
                
                print("third controller from page 3:")
                print("bName: \(self.bName) -- bAddress: \(self.bAddress) -- bCnic: \(self.bCnic) -- bContact: \(self.bContact) -- bRelation: \(self.bRelation)")
                
//                completionHandler(true)

//                    let defaultAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { [weak self](action) in
//                        self?.navigationController?.popViewController(animated: true)
//                        completionHandler(true)
//
//                    })
//
//                    TIHelper.showAlert(ViewController: self, AlertTitle: "Request Alert", AlertMessage: "dont have to upload family members", AlertStyle: .alert , Actions: [defaultAction])

            }else {
                completionHandler(false)
            }


        } else {
            if let controller = controller as? TIFamilyDetailsViewController {
                self.bName = bNameTextview.text
                self.bAddress = bAddressTextview.text
                self.bCnic = bCnicTextview.text
                self.bContact = bContactTextview.text
                self.bRelation = bRelationTextview.text
                //first controller variable
                controller.coverage = self.coverage
                controller.travelTypeSelected = self.travelTypeSelected
                controller.travelStartDate = self.travelStartDate
                controller.travelEndDate = self.travelEndDate
                controller.destination = self.destination
                controller.selectedDestination = self.selectedDestination
                controller.studentTution = self.studentTution
                controller.api = self.api

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
                
                print("first controller from page 3:")
                print("coverage: \(self.coverage) -- travelTypeSelected: \(self.travelTypeSelected) -- travelStartDate: \(self.travelStartDate) -- travelEndDate: \(self.travelEndDate) -- destination: \(self.destination) -- selectedDestination: \(self.selectedDestination) -- studentTution: \(self.studentTution)")

                print("Second controller from page 3:")
                print("nameOfInsured: \(self.nameOfInsured) -- email: \(self.email) -- dob: \(self.dob) -- passport: \(self.passport) -- cnic: \(self.cnic) -- city: \(self.city) -- address: \(self.address)")

                print("third controller from page 3:")
                print("bName: \(self.bName) -- bAddress: \(self.bAddress) -- bCnic: \(self.bCnic) -- bContact: \(self.bContact) -- bRelation: \(self.bRelation)")
                completionHandler(true)


            }

        }
    }
    
}

