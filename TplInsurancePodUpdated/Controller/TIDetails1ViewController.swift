//
//  TIDetails1ViewController.swift
//  TPLInsurance
//
//  Created by Tahir Raza on 03/12/2018.
//  Copyright © 2018 TPLHolding. All rights reserved.
//

import UIKit

class TIDetails1ViewController: UIViewController,UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var coveragePicker: UnderLineTextField!
    @IBOutlet weak var travelTypePicker: UnderLineTextField!
    @IBOutlet weak var travelStartDatePicker: UnderLineTextField!
    @IBOutlet weak var travelEndDatePicker: UnderLineTextField!
    @IBOutlet weak var destinationPicker: UnderLineTextField!
    var startDateFor: Date?
    @IBOutlet weak var studentLabel: UILabel!
    @IBOutlet weak var studentSwitch: UISwitch!
    
    var travelType: [TITravelTypeModel]?
    var destinationArray: [TIDestinationModel]? = [TIDestinationModel]()
    var cities: [City]?
    var filteredCitiesForZiarat: [TIDestinationModel]?
    let coutriesToRemove: [TIDestinationModel] = [TIDestinationModel.init(with: "1", name:"Saudia Arabia"), TIDestinationModel.init(with: "2", name:"Iran"), TIDestinationModel.init(with: "3", name:"Iraq"), TIDestinationModel.init(with: "4", name:"Syria")]
    //    let indexCountriesToRemove = ["name":"Saudia Arabia", "name":"Iran", "name":"Iraq", "name":"Syria"]
    var selectedDestination: TIDestinationModel?
    //    var selectedCity: City?
    var coverageType = ["Individual","Family"]
    
    var coverage: String?
    var travelTypeSelected: String?
    var travelStartDate: String?
    var travelEndDate: String?
    var destination: String?
    var studentTution: String?
    
    @IBAction func switchAction(_ sender: Any) {
        if studentSwitch.isOn{
            studentTution = "Y"
        }else{
            studentTution = "N"
        }
    }
    
    lazy var pickerView = UIPickerView()
    var fieldForPicker: UnderLineTextField?
    let datePicker :UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.addTarget(self, action: #selector(datePickerValueChanged(sender:)), for: .valueChanged)
        return datePicker
    }()
    
    @objc func datePickerValueChanged(sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = TIDateFormats.surveyFormat
        fieldForPicker!.text = dateFormatter.string(from: sender.date)
        if fieldForPicker == travelStartDatePicker {
            startDateFor = sender.date
        }
        
    }
    
    var api = travelInsuranceDataHandler()
    
    override func viewWillAppear(_ animated: Bool) {
        
        //        populateCoverage()
        datePicker.minimumDate = nil
        datePicker.maximumDate = nil
        getTravelType()
        getCitiesNew()
        getCountriesNew()
        print("Loaded successfully view will appear!")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        populateCoverage()
        //        getTravelType()
        //        getCitiesNew()
        //        getCountriesNew()
        
        print("Loaded successfully view did load called!")
        
        
        let toolBar = TIHelper.accessoryViewForTextField(target: self, selector: #selector(donePicker))
        
        coveragePicker.inputAccessoryView = toolBar
        coveragePicker.inputView = pickerView
        coveragePicker.delegate = self
        
        travelTypePicker.inputAccessoryView = toolBar
        travelTypePicker.inputView = pickerView
        travelTypePicker.delegate = self
        
        self.travelStartDatePicker.inputView = datePicker
        travelStartDatePicker.inputAccessoryView = toolBar
        travelStartDatePicker.delegate = self
        
        //        travelStartDatePicker.inputAccessoryView = toolBar
        //        travelStartDatePicker.inputView = pickerView
        //        travelStartDatePicker.delegate = self
        
        //        travelEndDatePicker.inputAccessoryView = toolBar
        //        travelEndDatePicker.inputView = pickerView
        //        travelEndDatePicker.delegate = self
        
        self.travelEndDatePicker.inputView = datePicker
        travelEndDatePicker.inputAccessoryView = toolBar
        travelEndDatePicker.delegate = self
        
        destinationPicker.inputAccessoryView = toolBar
        destinationPicker.inputView = pickerView
        destinationPicker.delegate = self
        
        pickerView.delegate = self
        pickerView.dataSource = self
        
    }
    
    @objc func donePicker() {
        
        // call details service here
        if fieldForPicker == coveragePicker{
            //            populateGetMobileInsuranceDetail()
            self.view.endEditing(true)
            //            travelType![row].name
        }else if fieldForPicker == travelTypePicker{
            if coveragePicker.text == coverageType[1]{
                let itemselected = travelType![1].name
                travelTypePicker.text = itemselected
            }else if fieldForPicker?.text == travelType![2].name{
                studentLabel.isHidden = false
                studentSwitch.isHidden = false
            }else{
                studentLabel.isHidden = true
                studentSwitch.isHidden = true
            }
            self.view.endEditing(true)
        }else if fieldForPicker == travelStartDatePicker{
            self.view.endEditing(true)
        }else if fieldForPicker == travelEndDatePicker{
            self.view.endEditing(true)
        }else if fieldForPicker == destinationPicker{
            self.view.endEditing(true)
            
        }
        else{
            //            populateMyVehiclesDetails()
            print("Not proper picker")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func populateCoverage() {
        //        self.view.makeToast("save local variable for coverage")
        
        self.coverage = coveragePicker.text
        
        //        self.view.makeToastActivity(.center)
        
        //        dataHandler.GetMobilePolicyDetail(policy: selectedPolicy!, completionHandler: { (mobileDetails) in
        //            self.view.hideToastActivity()
        //            if let mobileProfile = mobileDetails {
        //                self.mobileProfile = mobileProfile
        //                self.policyTable.reloadData()
        //            } else {
        //                self.textFieldPickerView?.resignFirstResponder()
        //                self.view.makeToast("No Mobile policy details found")
        //            }
        //        })
    }
    
    func populateTravelType() {
        self.showToast(message: "save local variable for Travel type")
    }
    
    func populateDestination() {
        self.showToast(message: "save local variable for Destination")
    }
    
    //MARK:- Picker view delegate
    
    //MARK: - Number components of pickerview
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if fieldForPicker == coveragePicker{
            return coverageType.count
        }else if fieldForPicker == travelTypePicker{
            if coveragePicker.text == "" || coveragePicker.text == nil{
                self.view.endEditing(true)
                self.showToast(message: "please select coverage first")
                return 0
            }else if coveragePicker.text == coverageType[1]{
                return 1
            }else{
                return travelType?.count ?? 0
            }
        }else if fieldForPicker == destinationPicker{
            print("self.travelTypePicker \(travelTypePicker.text)")
            if travelTypePicker.text != "Domestic"{
                if self.api.destinationArray != nil {
                    //                    return (self.api.destinationArray?.count)!
                }else{
                    getCountriesNew()
                    pickerView.reloadAllComponents()
                }
                
                if  (travelTypePicker.text != nil) && (travelTypePicker.text != "") && (travelTypePicker.text == "Ziarat") {
                    
                    let filterdObject = destinationArray!.filter { $0.name?.lowercased() == "Iran".lowercased() || $0.name?.lowercased() == "Iraq".lowercased() || $0.name?.lowercased() == "Saudi Arabia".lowercased() || $0.name?.lowercased() == "Syria".lowercased()}
                    
                    self.filteredCitiesForZiarat = filterdObject
                    print("FILTER ARRAY: \(filterdObject)")
                    
                    return filteredCitiesForZiarat?.count ?? 0
                }else{
                    return (self.api.destinationArray?.count)!
                }
            }else{
                if cities != nil {
                    return (cities?.count)!
                }else{
                    getCitiesNew()
                    pickerView.reloadAllComponents()
                    return (cities?.count)!
                }
            }
        }
        //        if coveragePicker.isFirstResponder{
        //           return coverageType.count
        //        }else if travelTypePicker.isFirstResponder{
        //            if coveragePicker.text == "" || coveragePicker.text == nil{
        //                self.view.endEditing(true)
        //                self.view.makeToast("please select coverage first")
        ////                return 0
        //            }else if coveragePicker.text == coverageType[1]{
        //                return 1
        //            }else{
        //                return (travelType?.count)!
        //            }
        //        }else if destinationPicker.isFirstResponder{
        //            return (destinationArray?.count)!
        //        }
        
        //        if fieldForPicker == coveragePicker{
        //            //get the size of array and populate picker
        //        }else if fieldForPicker == travelTypePicker{
        //            //get the size of array and populate picker
        //        }else if fieldForPicker == destinationPicker{
        //            //get the size of array and populate picker
        //        }
        return 2
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    //MARK: - TITLE components of pickerview
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if fieldForPicker == coveragePicker{
            //get the size of array and populate picker
            return coverageType[row]
        }else if fieldForPicker == travelTypePicker{
            //get the size of array and populate picker
            if coveragePicker.text == "" || coveragePicker.text == nil{
               self.showToast(message: "please select coverage first")
                return nil
            }else if coveragePicker.text == coverageType[1]{
                return travelType![1].name
            }else{
                return travelType![row].name
            }
        }else if fieldForPicker == destinationPicker{
            //get the size of array and populate picker
            if travelTypePicker.text != "" && travelTypePicker.text != nil && travelTypePicker.text == "Ziarat"{
                //MARK: - Previous work done for filter array
                
                //                let filtered = destinationArray?.filter{ $0.name!.contains("Iran") }
                //                filtered?.forEach { self.filteredCitiesForZiarat?.append($0)
                //                    print($0)
                //                }
                //                let filtered1 = destinationArray?.filter{ $0.name!.contains("Saudia Arabia") }
                //                filtered1?.forEach { self.filteredCitiesForZiarat?.append($0)
                //                    print($0)
                //                }
                //
                //                guard let filteredArray = filteredCitiesForZiarat
                //                    else
                //                {
                //                    print("No result in filtered array")
                //                    return "-"
                //                }
                //                if filteredCitiesForZiarat?.count > 0{
                //                    return filteredCitiesForZiarat![row].name
                //                }
                if let country = filteredCitiesForZiarat {
                    return country[row].name
                } else {
                    print("Unable to retrieve the number of rooms.")
                }
                return ""
                
                //                if self.api.destinationArray != nil {
                //                    return (self.api.destinationArray?.count)!
                //                }else{
                //                    getCitiesNew()
                //                    pickerView.reloadAllComponents()
                //                }
            }else if travelTypePicker.text != "" && travelTypePicker.text != nil && travelTypePicker.text != "Domestic"{
                return self.api.destinationArray![row].name
            }else{
                return (self.api.cities![row].Name)
            }
        }
        return "Else"
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if coveragePicker.isFirstResponder{
            //            let itemselected = fieldForPicker?.text
            let itemselected = coverageType[row]
            coveragePicker.text = itemselected
            travelTypePicker.isUserInteractionEnabled = true
        }else if travelTypePicker.isFirstResponder{
            if coveragePicker.text == coverageType[1]{
                let itemselected = travelType![1].name
                travelTypePicker.text = itemselected
            }else{
                let itemselected = travelType![row].name
                travelTypePicker.text = itemselected
                if itemselected == travelType![4].name{
                    destinationPicker.isHidden = true
                    //                    if let firstMatch = yourArray.first{$0.id == lookupId} {
                    //                        print("found it: \(firstMatch)")
                    //                    }
                    // FIXME: yaha destination value daalo hardcotted saudi ki
                    let nameD = "Saudi Arabia"
                    let idD = "161"
                    let destinationSelectedManual = TIDestinationModel(with: idD, name: nameD)
                    selectedDestination = destinationSelectedManual
                    
                    //                    if let itemselected = self.api.destinationArray?.first(where: {$0.id == "161"}) {
                    //                        destinationPicker.text = itemselected
                    //                    }
                    
                }else{
                    destinationPicker.isHidden = false
                }
            }
            //            let itemselected = travelType![row].name
            //            travelTypePicker.text = itemselected
        }else if destinationPicker.isFirstResponder{
            if travelTypePicker.text != "" && travelTypePicker.text != nil && travelTypePicker.text == "Ziarat"{
                selectedDestination = self.filteredCitiesForZiarat![row]
                let itemselected = selectedDestination?.name!
                destinationPicker.text = itemselected
            }else if travelTypePicker.text != "" && travelTypePicker.text != nil && travelTypePicker.text != "Domestic"{
                selectedDestination = self.api.destinationArray![row]
                let itemselected = selectedDestination?.name!
                destinationPicker.text = itemselected
                //                return destinationArray![row].name
            }else{
                let selectedCity = cities![row]
                let city = selectedCity.Name
                let cityId = String(describing: selectedCity.Id)
                
                let selectedDestinationNew = TIDestinationModel.init(with: cityId, name: city)
                selectedDestination = selectedDestinationNew
                let itemselected = selectedDestination?.name!
                destinationPicker.text = itemselected
            }
        }else if fieldForPicker == travelTypePicker{
            if coveragePicker.text == coverageType[1]{
                let itemselected = travelType![1].name
                travelTypePicker.text = itemselected
            }else if fieldForPicker?.text == travelType![2].name{
                studentLabel.isHidden = false
                studentSwitch.isHidden = false
            }else{
                studentLabel.isHidden = true
                studentSwitch.isHidden = true
            }
            self.view.endEditing(true)
        }
    }
    
    
}


extension TIDetails1ViewController: UITextFieldDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        //        fieldForPicker = textField as! UnderLineTextField
        
        //datePicker.isUserInteractionEnabled = false
        if textField == self.travelStartDatePicker || textField == self.travelEndDatePicker {
            if textField == self.travelEndDatePicker && coveragePicker.text == coverageType[0] && travelTypePicker.text == "Domestic" && travelStartDatePicker.text != "" {
                datePicker.minimumDate = startDateFor
                
                let calendar = Calendar.current
                
                let maxDate = calendar.date(byAdding: .day,
                                            value: 29,
                                            to: startDateFor!)
                datePicker.maximumDate = maxDate
                return
            }else if textField == self.travelEndDatePicker && coveragePicker.text == coverageType[0] && travelTypePicker.text == "Ziarat" && travelStartDatePicker.text != "" {
                datePicker.minimumDate = startDateFor
                
                let calendar = Calendar.current
                
                let maxDate = calendar.date(byAdding: .day,
                                            value: 44,
                                            to: startDateFor!)
                datePicker.maximumDate = maxDate
                return
            }else if textField == self.travelEndDatePicker && coveragePicker.text == coverageType[0] && travelTypePicker.text == "Hajj and Umrah" && travelStartDatePicker.text != "" {
                datePicker.minimumDate = startDateFor
                
                let calendar = Calendar.current
                
                let maxDate = calendar.date(byAdding: .day,
                                            value: 44,
                                            to: startDateFor!)
                datePicker.maximumDate = maxDate
                return
            }else if textField == self.travelEndDatePicker && coveragePicker.text == coverageType[0] && travelTypePicker.text == "Student" && travelStartDatePicker.text != "" {
                //                datePicker.minimumDate = startDateFor
                
                let calendar = Calendar.current
                
                let maxDate = calendar.date(byAdding: .month,
                                            value: 6,
                                            to: datePicker.minimumDate!)
                datePicker.minimumDate = maxDate
                return
            }else if textField == self.travelEndDatePicker && travelStartDatePicker.text != nil && travelTypePicker.text == "International" {
                datePicker.minimumDate = startDateFor
                
                var calendar = Calendar.current
                
                var maxDate = calendar.date(byAdding: .day,
                                            value: 363,
                                            to: startDateFor!)
                datePicker.maximumDate = maxDate
                return
            }
            
            
            datePicker.minimumDate = Date()
            print("minimum date set here thats today")
        }
        
        
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if (textField == coveragePicker) {
            travelTypePicker.text = ""
            travelStartDatePicker.text = ""
            travelEndDatePicker.text = ""
            destinationPicker.text = ""
            studentSwitch.isHidden = true
            studentLabel.isHidden = true
            
        }
        
        
        if (textField == travelTypePicker) {
            travelStartDatePicker.text = ""
            travelEndDatePicker.text = ""
            destinationPicker.text = ""
        }
        
        fieldForPicker = textField as! UnderLineTextField
        pickerView.reloadAllComponents()
        return true
        
        
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == coveragePicker && coveragePicker.text != nil || coveragePicker.text != ""{
            travelTypePicker.isUserInteractionEnabled = true
        }
    }
    
}

extension TIDetails1ViewController{
    func getTravelType(){
        if api.Relationships != nil{
            
        }else{
            self.showActivityIndicatory()
            api.TITravelType(completionHandler: { (success) in
                DispatchQueue.main.async {
                    self.stopIndicator()
                    if success{
                        print("fetched Relations successfully")
                        self.stopIndicator()
                        self.view.isUserInteractionEnabled = true
                        self.travelType = self.api.travelType
                        
                    }else{
                        print("No packages available")
                    }
                }
            })
        }
    }
    
    func getCitiesNew(){
        if api.cities != nil {
            
        } else {
            self.view.isUserInteractionEnabled = false
            self.showActivityIndicatory()
            DispatchQueue.main.async {
                self.api.fetchAndUpdateCities(completionHandler: { (success) in
                    DispatchQueue.main.async {
                        self.stopIndicator()
                        if success {
                            print("fetched Destinations successfully")
                            //                        self.destinationArray = self.api.destinationArray
                            self.cities = self.api.cities
                            self.stopIndicator()
                            self.view.isUserInteractionEnabled = true
                            self.pickerView.reloadAllComponents()
                        } else {
                            self.fieldForPicker?.resignFirstResponder()
                        }
                    }
                })
            }
        }
        //        if api.destinationArray != nil{
        //
        //        }else{
        //            self.view.makeToastActivity(.center)
        //            api.TIDestination(completionHandler: { (success) in
        //                DispatchQueue.main.async {
        //                    self.view.hideToastActivity()
        //                    if success{
        //                        print("fetched Destinations successfully")
        //                        self.view.hideToastActivity()
        //                        self.view.isUserInteractionEnabled = true
        //                        self.destinationArray = self.api.destinationArray
        //
        //                    }else{
        //                        print("No Destinations available")
        //                    }
        //                }
        //            })
        //        }
    }
    
    func getCountriesNew(){
        if api.destinationArray != nil{
            
        }else{
            self.showActivityIndicatory()
            api.TIDestination(completionHandler: { (success) in
                DispatchQueue.main.async {
                    self.stopIndicator()
                    if success{
                        print("fetched Destinations successfully")
                        self.stopIndicator()
                        self.view.isUserInteractionEnabled = true
                        self.destinationArray = self.api.destinationArray
                        //                        self.cities = self.api.cities
                        
                    }else{
                        print("No Destinations available")
                    }
                }
            })
        }
    }
    
}

extension TIDetails1ViewController: PagerViewDelegate{
    func willMoveTo(next controller: UIViewController, completionHandler: @escaping (Bool) -> Void) {
        if(coveragePicker.text == nil || coveragePicker.text == ""){
            self.showToast(message: "Please select the coverage.")
            completionHandler(false)
            return
        }
        if(travelTypePicker.text == nil || travelTypePicker.text == ""){
           self.showToast(message: "Please select travel type.")
            completionHandler(false)
            return
        }
        if(travelStartDatePicker.text == nil || travelStartDatePicker.text == ""){
            self.showToast(message: "Please select the start date.")
            completionHandler(false)
            return
        }
        if(travelEndDatePicker.text == nil || travelEndDatePicker.text == ""){
            self.showToast(message: "Please select the end date.")
            completionHandler(false)
            return
        }
        if destinationPicker.isHidden != true{
            if(destinationPicker.text == nil || destinationPicker.text == ""){
                self.showToast(message: "Please select your destination.")
                completionHandler(false)
                return
            }
        }
        //        if studentSwitch.isHidden != true{
        //            if(studentSwitch.text == nil || destinationPicker.text == ""){
        //                self.view.makeToast("Please select your destination.")
        //                completionHandler(false)
        //                return
        //            }
        //        }
        
        
        
        if let controller = controller as? TIDetails2ViewController {
            self.coverage = coveragePicker.text
            self.travelTypeSelected = travelTypePicker.text
            self.travelStartDate = travelStartDatePicker.text
            self.travelEndDate = travelEndDatePicker.text
            self.destination = destinationPicker.text ?? "Saudi Arabia"
            if studentSwitch.isOn{
                self.studentTution = "y"
            }else{
                self.studentTution = "N"
            }
            
            
            controller.coverage = self.coverage
            controller.travelTypeSelected = self.travelTypeSelected
            controller.travelStartDate = self.travelStartDate
            controller.travelEndDate = self.travelEndDate
            controller.destination = self.destination
            controller.selectedDestination = self.selectedDestination
            controller.studentTution = self.studentTution
            controller.api = self.api
            
            print("coverage: \(self.coverage) -- travelTypeSelected: \(self.travelTypeSelected) -- travelStartDate: \(self.travelStartDate) -- travelEndDate: \(self.travelEndDate) -- destination: \(self.destination) -- selectedDestination: \(self.selectedDestination) -- studentTution: \(self.studentTution)")
            
            completionHandler(true)
        }
    }
    
}


//MARK: - Filter array code:

//                let arrayRemainingCountries = destinationArray
//                    .enumerated()
//                    .filter { !coutriesToRemove.contains(where: $0.name) }
//                    .map { $0.element }

//                print(arrayRemainingCountries)
//                let filtered = destinationArray?.filter{ indexCountriesToRemove.name!.contains($0.name) }
//                if filtered != nil{
//                    guard let value1 = filtered?[0]
//                        else
//                            {
//                                print("No value")
//                                return 0
//                            }
//                    self.filteredCitiesForZiarat?.append(value1)
//                }

//                if let check1 = filtered{
//                    let value1 = filtered![0]{
//                        self.filteredCitiesForZiarat?.append(value1)
//                    }
//                }
//                filtered?.forEach { self.filteredCitiesForZiarat?.append($0)
//                    print($0)
//                }

//MARK: - commented now
//                let filtered1 = destinationArray?.filter{ $0.name!.contains("Saudia Arabia") }
//                filtered1?.forEach { self.filteredCitiesForZiarat?.append($0)
//                    print($0)
//                }
//
//                guard let filteredArraySize = filteredCitiesForZiarat?.count
//                    else
//                {
//                    print("No result in filtered array")
//                    return 0
//                }
