//
//  homePagerViewController.swift
//  TPLInsurance
//
//  Created by Tahir Raza on 30/11/2018.
//  Copyright © 2018 TPLHolding. All rights reserved.
//

import UIKit

class homePagerViewController: PagerViewController {
    
    override func viewDidLoad() {
        
        let controller = (storyboard!.instantiateViewController(withIdentifier: "HIDetailsViewController"), "Home Insurance - Details", false)
        let controller1 = (storyboard!.instantiateViewController(withIdentifier: "HIPackagesViewController"), "Home Insurance - Packages", true)
        let controller2 = (storyboard!.instantiateViewController(withIdentifier: "HISummaryViewController"), "Home Insurance - Summary", false)

        pages = [controller,controller1,controller2]
        
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
    
}
