//
//  ViewController.swift
//  TplInsurancTesting
//
//  Created by Tahir Raza on 23/07/2019.
//  Copyright © 2019 Mohammed Ahsan. All rights reserved.
//

import UIKit

open class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    //    let InsuranceType = ["Car Insurance", "Mobile Insurance", "Home Insurance", "Travel Insurance"]
    let InsuranceType = ["Travel Insurance", "Home Insurance"]
    let InsuranceDetails = ["Get peace of mind for wherever the road takes you", "Safe travels, we have got you covered"]
    let InsuranceTypeImages = ["vehicle_claim", "home_insuranceLogo"]
    let insuranceDialogDetails = ["1. Personal CNIC\n  2. Beneficiary CNIC\n  3. Beneficiary Address\n", "1. Personal CNIC\n  2. Tenant /  Landlord CNIC\n"]
    let generalDialogDetail = "Please make sure you have the below information ready, while filling out the form:\n"
    
    //    let defaultAction = UIAlertAction(title: "Continue", style: UIAlertActionStyle.default, handler: { [weak self](action) in
    //
    //    })
    
    
    
    //    refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
    //    print("Handle Ok logic here")
    //    }))
    
    @IBOutlet weak var dataTable: UITableView!
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        dataTable.delegate = self
        dataTable.dataSource = self
        
        self.navigationItem.title = "Buy Insurance"
        
        // Do any additional setup after loading the view.
        
        self.navigationItem.setHidesBackButton(true, animated:true);
        let newBackButton = UIBarButtonItem(title: "Exit", style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.backCustom(sender:)))
        self.navigationItem.leftBarButtonItem = newBackButton
        
    }
    
    @objc func backCustom(sender: UIBarButtonItem) {
        
        let cancelAlert = UIAlertController(title: "Exit", message: "Are you sure you want to quit from this process?", preferredStyle: UIAlertController.Style.alert)
        
        cancelAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
            self.dismiss(animated: true, completion: nil)
        }))
        
        cancelAlert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { (action: UIAlertAction!) in
            
            cancelAlert .dismiss(animated: true, completion: nil)
            
        }))
        
        present(cancelAlert, animated: true, completion: nil)
        
    }
    
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated) //UIColor(red: 227.0/255.0, green: 118.0/255.0, blue: 57.0/255.0, alpha: 1.0)
        navigationController?.navigationBar.barTintColor = UIColor(red: 243.0/255.0, green: 111.0/255.0, blue: 33.0/255.0, alpha: 1.0)
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.tintColor = UIColor(red: 117.0/255.0, green: 117.0/255.0, blue: 117.0/255.0, alpha: 1.0)
        navigationItem.backBarButtonItem = UIBarButtonItem(title: " ", style: .plain, target: nil, action: nil)
    }
    
    
    open override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.barTintColor = UIColor.white
        navigationController?.navigationBar.isTranslucent = true
    }
    
    
    
    open override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //        return InsuranceType.count
        return 2
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellInsuranceType")
        cell?.textLabel?.numberOfLines = 0
        cell?.textLabel?.textColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1.0)
        //        cell?.textLabel?.text = "Car Insurance"
        cell?.imageView?.image = UIImage(named: InsuranceTypeImages[indexPath.row])
        cell?.textLabel?.text = InsuranceType[indexPath.row]
        cell?.detailTextLabel?.text = InsuranceDetails[indexPath.row]
        
        return cell!
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let defaultAcction = UIAlertAction(title: "Continue", style: UIAlertAction.Style.default) { (UIAlertAction) in
            //            var iType = self.InsuranceType[indexPath.row]
            tableView.deselectRow(at: indexPath, animated: true)
            if self.InsuranceType[indexPath.row] == self.InsuranceType[0]{
                self.performSegue(withIdentifier: "request qoute", sender: self)
            }else if self.InsuranceType[indexPath.row] == self.InsuranceType[1]{
                self.performSegue(withIdentifier: "showHome", sender: self)
            }
        }
        
        TIHelper.showAlert(ViewController: self, AlertTitle: "Request Alert", AlertMessage: "\(generalDialogDetail)\n \(insuranceDialogDetails[indexPath.row])", AlertStyle: .alert , Actions: [defaultAcction])
        
        
    }
    
}

