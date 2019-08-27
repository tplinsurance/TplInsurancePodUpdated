//
//  TIFamilyDetailsViewController.swift
//  TPLInsurance
//
//  Created by Tahir Raza on 03/12/2018.
//  Copyright © 2018 TPLHolding. All rights reserved.
//

import UIKit

class TIFamilyDetailsViewController: UIViewController {
    //Variables
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
    var numberOfKids: Int = 0
    var numberOfBrother: Int = 0
    var numberOfFather: Int = 0
    var numberOfHusband: Int = 0
    var numberOfMother: Int = 0
    var numberOfSister: Int = 0
    var numberOfWife: Int = 0
    var address: String?
    //ThirdController
    var bName: String?
    var bAddress: String?
    var bCnic: String?
    var bContact: String?
    var bRelation: String?
    var selectedDate: Date?
    var travelPackageDetail: [TravelPackageModel]?

    //ThisController
    var yourArray = [familyData]()
    var api = travelInsuranceDataHandler()
    lazy var pickerView = UIPickerView()

    @IBOutlet weak var nameTextview: UnderLineTextField!
    @IBOutlet weak var dobTextview: UnderLineTextField!
    @IBOutlet weak var cnicTextview: UnderLineTextField!
    @IBOutlet weak var relationTextview: UnderLineTextField!
    @IBOutlet weak var addMemberOutlet: UIButton!
    @IBOutlet weak var familyMemberTable: UITableView!
    @IBAction func addMemberAction(_ sender: Any) {
        if nameTextview.text == nil || nameTextview.text == ""{
            self.showToast(message: "Please enter the name")
        }else if dobTextview.text == nil || dobTextview.text == ""{
            self.showToast(message: "Please enter the date of birth")
        }else if cnicTextview.text != "", let cnic = cnicTextview.text, cnic.count != 13 {
                self.showToast(message: "Please enter correct nic number")
        }else if relationTextview.text == nil || relationTextview.text == ""{
            self.showToast(message: "Please enter the relation")
        }else{
            
            if yourArray.count < 4{
                var member = familyData(name: nameTextview.text ?? "", dob: selectedDate! , cnic: cnicTextview.text ?? "-", relation: relationTextview.text ?? "-")
                
                let currentDate: Date = Date()
                var calendar: Calendar = Calendar(identifier: Calendar.Identifier.gregorian)
                calendar.timeZone = TimeZone(identifier: "UTC")!
                var component: DateComponents = DateComponents()
                component.calendar = calendar
                component.year = -18
                let maxDate: Date = calendar.date(byAdding: component, to: currentDate)!
                component.year = -150
                let minDate: Date = calendar.date(byAdding: component, to: currentDate)!
                var minimumDate = minDate
                var maximumDate = maxDate
                
                //work here
                if member.relation == api.TravelRelationships![1].name  || member.relation == api.TravelRelationships![5].name {
                    if member.relation == api.TravelRelationships![1].name || member.relation == api.TravelRelationships![5].name{
                        if numberOfKids <= 3{
                            numberOfKids = numberOfKids + 1
                        }else{
                            self.showToast(message: "Number of kids can not be more then 3")
                            return
                        }
                    }
                    
                }
                
                if (member.relation == api.TravelRelationships![5].name && member.dob <= maximumDate) {
                    self.showToast(message: "Not an Eligible \(api.TravelRelationships![5].name!)")
                    return
                    
                }else if (member.relation == api.TravelRelationships![1].name && member.dob <= maximumDate) {
                    self.showToast(message: "Not an Eligible \(api.TravelRelationships![1].name!)")
                    return
                    
                }else{
                    if yourArray.count > 0 {
                        yourArray.append(member)
                        
                    }else{
                        if member.relation == api.TravelRelationships![5].name || member.relation == api.TravelRelationships![1].name{
                            numberOfKids = numberOfKids + 1
                        }
                        yourArray.insert(member, at: 0)
                    }
                    
                    familyMemberTable.reloadData()
                }
                
            }else{
                self.showToast(message: "Number of family member cannot be more then 4")
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
        dobTextview!.text = dateFormatter.string(from: sender.date)
        selectedDate = sender.date
        print(selectedDate)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        getrelations()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let toolBar = TIHelper.accessoryViewForTextField(target: self, selector: #selector(donePicker))
        
//        getrelations()
        
        self.dobTextview.inputView = datePicker
        dobTextview.inputAccessoryView = toolBar
        dobTextview.delegate = self
        
        nameTextview.inputAccessoryView = toolBar
        relationTextview.inputView = pickerView
        relationTextview.inputAccessoryView = toolBar
        cnicTextview.delegate = self
        nameTextview.delegate = self
        cnicTextview.inputAccessoryView = toolBar
        
        pickerView.delegate = self
        pickerView.dataSource = self
        
        familyMemberTable.delegate = self
        familyMemberTable.dataSource = self
        familyMemberTable.allowsSelection = false

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func deleteMember(_ sender: UIButton) {
        print("This click is done from \(sender.tag)")
        if yourArray.count > 0{
            let abc = yourArray[sender.tag]
            if abc.relation == api.TravelRelationships![1].name || abc.relation == api.TravelRelationships![5].name{
                numberOfKids = numberOfKids - 1
            }
            yourArray.remove(at: sender.tag)
            print(yourArray)
            familyMemberTable.reloadData()
        }else{
            self.showToast(message: "nothing to delete")
        }
    }
    
    @objc func donePicker() {
        self.view.endEditing(true)
    }

}

extension TIFamilyDetailsViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return yourArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "abcFamily") as? TIFamilyCellTableViewCell  else {
            return UITableViewCell()
        }
        
        cell.nameLabel.text = yourArray[indexPath.row].name
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = TIDateFormats.surveyFormat
       cell.dobLabel.text = dateFormatter.string(from: yourArray[indexPath.row].dob)
        
//        cell.dobLabel.text = yourArray[indexPath.row].dob
        cell.cnicLabel.text = yourArray[indexPath.row].cnic
        cell.relationLabel.text = yourArray[indexPath.row].relation
//        cell.delBtn.tag = indexPath.row
//        cell.delBtn.addTarget(self, action: #selector(self.deleteMember(_:)), for: .touchUpInside)
        
        cell.clearBtn.tag = indexPath.row
        cell.clearBtn.addTarget(self, action: #selector(self.deleteMember(_:)), for: .touchUpInside)
        
        return cell
//        cell.nameLabel.text = "Mohammed Ahsan"
//        cell.dobLabel.text = "1/1/1995"
//        cell.cnicLabel.text = "42301-670000-0"
//        cell.relationLabel.text = "Father"
//        return cell
    }
    
    
}

extension TIFamilyDetailsViewController: UIPickerViewDelegate, UIPickerViewDataSource{
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return api.TravelRelationships?.count ?? 0
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return api.TravelRelationships![row].name ?? "no text"
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let text = api.TravelRelationships![row].name
        relationTextview?.text = text
        selectData(at: row)
    }
    
    func selectData(at index: Int) {
        if let fieldForPicker = relationTextview {
            api.selectedFamilyRelationships(at: index)
        }
    }
}

extension TIFamilyDetailsViewController{
    func getrelations(){
        if api.TravelRelationships != nil{
            pickerView.reloadAllComponents()
        }else{
            self.showActivityIndicatory()
            api.TIGetTravelRelationship(completionHandler: { (success) in
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

extension TIFamilyDetailsViewController: UITextFieldDelegate{
//    func textFieldDidBeginEditing(_ textField: UITextField) {
//        //datePicker.isUserInteractionEnabled = false
//        let currentDate: Date = Date()
//        var calendar: Calendar = Calendar(identifier: Calendar.Identifier.gregorian)
//        calendar.timeZone = TimeZone(identifier: "UTC")!
//        var components: DateComponents = DateComponents()
//        components.calendar = calendar
//        components.year = -18
//        let maxDate: Date = calendar.date(byAdding: components, to: currentDate)!
//        components.year = -150
//        let minDate: Date = calendar.date(byAdding: components, to: currentDate)!
//        var minimumDate = minDate
//        var maximumDate = maxDate
//
//        if textField == self.dobTextview {
//            datePicker.maximumDate = maximumDate
//            datePicker.minimumDate = minimumDate
////            print("please select date after today")
//        }
////        if textField == self.dobTextview{
////            datePicker.minimumDate = Date()
////            print("please select date after today")
////        }
//    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == self.cnicTextview{
            guard let text = textField.text else { return true }
            let newLength = text.count + string.count - range.length
            return newLength <= 13 // Bool
            
            if let textField = textField as? UnderLineTextField,
                textField.isValidatingLimit {
                let shouldReplace = textField.validateForLength(changingIn: range, change: string)
                
                if textField == self.cnicTextview,
                    shouldReplace {
                    textField.formatTextOnChange(changingIn: range, change: string, format: .cnic)
                }
                
                return shouldReplace
            }
        }else if textField == self.nameTextview { // 30 characters are allowed on first name
            guard let text = textField.text else { return true }
            let newLength = text.count + string.count - range.length
            return newLength <= 30 // Bool
        }
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
//        if textField == relationTextview{
//            getrelations()
//        }
        
        //datePicker.isUserInteractionEnabled = false
        let currentDate: Date = Date()
//        var calendar: Calendar = Calendar(identifier: Calendar.Identifier.gregorian)
//        calendar.timeZone = TimeZone(identifier: "UTC")!
//        var components: DateComponents = DateComponents()
//        components.calendar = calendar
//        let maxDate: Date = calendar.date(byAdding: components, to: currentDate)!
//        components.year = -150
//        var maximumDate = maxDate
        
        if textField == self.dobTextview {
//            datePicker.maximumDate = maximumDate
            datePicker.maximumDate = currentDate
            print("please select date after today")
        }
     
    }
}

// MARK: - API CALLING

extension TIFamilyDetailsViewController{
    
    
//    func getPackagesController(with controller: UIViewController, completionHandler: @escaping(Bool) -> Void) {
//        api.TravelInsurancePackages(Coverage: self.coverage ?? "-", TravelType: self.travelTypeSelected ?? "International", WithTution: "N", StartDate: travelStartDate ?? "", EndDate: travelEndDate ?? "2018-12-31", DOB: self.dob ?? "1980-08-22") { (success, message) in
//            self.view.hideToastActivity()
//            self.view.isUserInteractionEnabled = true
//            if success{
//                if let controller = controller as? NewTIPackagesViewController {
//
//                    //first controller variable
//                    self.travelPackageDetail = message
//                    controller.coverage = self.coverage
//                    controller.travelTypeSelected = self.travelTypeSelected
//                    controller.travelStartDate = self.travelStartDate
//                    controller.travelEndDate = self.travelEndDate
//                    controller.destination = self.destination
//                    controller.selectedDestination = self.selectedDestination
//                    controller.api = self.api
//
//                    //first controller variable
//                    controller.nameOfInsured = self.nameOfInsured
//                    controller.dob = self.dob
//                    controller.passport = self.passport
//                    controller.cnic = self.cnic
//                    controller.city = self.city
//                    controller.address = self.address
//
//                    //third controller variable
//                    controller.bName = self.bName
//                    controller.bAddress = self.bAddress
//                    controller.bCnic = self.bCnic
//                    controller.bContact = self.bContact
//                    controller.bRelation = self.bRelation
//                    controller.travelPackageDetail = self.travelPackageDetail
//
//                    //Family Detail View Controller
//                    controller.yourArray = self.yourArray
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
//
//    }
    
}

// MARK: - Pager moving

extension TIFamilyDetailsViewController: PagerViewDelegate{
    func willMoveTo(next controller: UIViewController, completionHandler: @escaping (Bool) -> Void) {
//        if(nameInsuredTextview.text == nil || nameInsuredTextview.text == ""){
//            self.view.makeToast("Please fill your name.")
//            completionHandler(false)
//            return
//        }
//        if(dobTextview.text == nil || dobTextview.text == ""){
//            self.view.makeToast("Please select Date of birth.")
//            completionHandler(false)
//            return
//        }
//        if(passportTextview.text == nil || passportTextview.text == ""){
//            self.view.makeToast("Please fill your passport number.")
//            completionHandler(false)
//            return
//        }
//        if(cnicTextview.text == nil || cnicTextview.text == ""){
//            self.view.makeToast("Please fill your cnic.")
//            completionHandler(false)
//            return
//        }
//        if(cityTextview.text == nil || cityTextview.text == ""){
//            self.view.makeToast("Please select city.")
//            completionHandler(false)
//            return
//        }
        
        if(yourArray.count < 1){
            self.showToast(message: "Please fill family details")
            completionHandler(false)
            return
        }

        
        if let controller = controller as? NewTIPackagesViewController {
            
            //first controller variable
//            self.travelPackageDetail = message
            controller.coverage = self.coverage
            controller.travelTypeSelected = self.travelTypeSelected
            controller.travelStartDate = self.travelStartDate
            controller.travelEndDate = self.travelEndDate
            controller.destination = self.destination
            controller.selectedDestination = self.selectedDestination
            controller.api = self.api
            
            //first controller variable
            controller.nameOfInsured = self.nameOfInsured
            controller.email = self.email
            controller.dob = self.dob
            controller.passport = self.passport
            controller.cnic = self.cnic
            controller.city = self.city
            controller.address = self.address
            
            //third controller variable
            controller.bName = self.bName
            controller.bAddress = self.bAddress
            controller.bCnic = self.bCnic
            controller.bContact = self.bContact
            controller.bRelation = self.bRelation
            controller.travelPackageDetail = self.travelPackageDetail
            
            //Family Detail View Controller
            controller.yourArray = self.yourArray
            
            print("first controller from page 4:")
            print("coverage: \(self.coverage) -- travelTypeSelected: \(self.travelTypeSelected) -- travelStartDate: \(self.travelStartDate) -- travelEndDate: \(self.travelEndDate) -- destination: \(self.destination) -- selectedDestination: \(self.selectedDestination) -- studentTution: \(self.studentTution)")

            print("Second controller from page 4:")
            print("nameOfInsured: \(self.nameOfInsured) -- dob: \(self.dob) -- passport: \(self.passport) -- cnic: \(self.cnic) -- city: \(self.city) -- address: \(self.address)")

            print("third controller from page 4:")
            print("bName: \(self.bName) -- bAddress: \(self.bAddress) -- bCnic: \(self.bCnic) -- bContact: \(self.bContact) -- bRelation: \(self.bRelation)")

            print("family detail controller from page 4:")
            print("yourArray: \(self.yourArray)")
            
            completionHandler(true)
        } else {
            completionHandler(false)
        }


//        self.getPackagesController(with: controller, completionHandler: completionHandler)

        
    }
    
}


//extra work for family array cehcking
//            for value in yourArray{
//                if value.relation == api.TravelRelationships![1].name || value.relation == api.TravelRelationships![5].name{
//                    if numberOfKids <= 3{
//                        numberOfKids = numberOfKids + 1
//                    }else{
//                        self.view.makeToast("Number of kids can not be more then 3")
//                        return
//                    }
//                }else{
//                    var dataRelation = value.relation
//                    if member.relation == dataRelation{
//                        self.view.makeToast("This relationship already exist!")
//                        return
//                    }
//                }
//            }

