//
//  TravelPagerViewController.swift
//  TPLInsurance
//
//  Created by Tahir Raza on 30/11/2018.
//  Copyright © 2018 TPLHolding. All rights reserved.
//

import UIKit

class TravelPagerViewController: PagerViewController {
    
    var controller: (UIViewController, String, Bool)? = nil
    var controller1: (UIViewController, String, Bool)? = nil
    var controller2: (UIViewController, String, Bool)? = nil
    var controller3: (UIViewController, String, Bool)? = nil
    var controller4: (UIViewController, String, Bool)? = nil
    var controller5: (UIViewController, String, Bool)? = nil
    var controller6: (UIViewController, String, Bool)? = nil
    var controller7: (UIViewController, String, Bool)? = nil
    
    override func viewDidLoad() {
        
        self.controller = (storyboard!.instantiateViewController(withIdentifier: "TIDetails1ViewController"), "Travel Insurance - Details", false)
        self.controller1 = (storyboard!.instantiateViewController(withIdentifier: "TIDetails2ViewController"), "Travel Insurance - Personal Details", true)
        self.controller2 = (storyboard!.instantiateViewController(withIdentifier: "TIDetails3ViewController"), "Travel Insurance - Beneficiary Details", false)
        self.controller3 = (storyboard!.instantiateViewController(withIdentifier: "TIFamilyDetailsViewController"), "Travel Insurance - Family Details", false)
        self.controller4 = (storyboard!.instantiateViewController(withIdentifier: "NewTIPackagesViewController"), "Travel Insurance - Packages", false)
        self.controller5 = (storyboard!.instantiateViewController(withIdentifier: "TISummaryViewController"), "Travel Insurance - Summary", false)
        pages = [controller,controller1,controller2,controller3,controller4,controller5]

        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        self.navigationItem.setHidesBackButton(true, animated:true);
        let newBackButton = UIBarButtonItem(title: "Quit", style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.backCustom(sender:)))
        self.navigationItem.leftBarButtonItem = newBackButton
        
    }
    
    @objc func backCustom(sender: UIBarButtonItem) {
        
        let cancelAlert = UIAlertController(title: "Quit", message: "Are you sure you want to quit from this process?", preferredStyle: UIAlertController.Style.alert)
        
        cancelAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func SetFamilySelected(selected: Bool) {
        if selected {
             pages = [controller,controller1,controller2,controller3,controller4,controller5,controller6]
        } else {
            if let index = pages.index(where: { (indexController) -> Bool in
                return indexController?.0 == self.controller3?.0
            }) {
                self.pages.remove(at: index)
            }
        }
    }
    
    
}
