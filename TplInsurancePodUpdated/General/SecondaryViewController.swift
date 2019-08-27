//
//  SecondaryViewController.swift
//  TPLInsurance
//
//  Created by Sajad on 2/7/18.
//  Copyright © 2018 TPLHolding. All rights reserved.
//

import UIKit

open class SecondaryViewController: UIViewController {
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.barTintColor = UIColor(red: 227.0/255.0, green: 118.0/255.0, blue: 57.0/255.0, alpha: 1.0)
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.tintColor = UIColor(red: 117.0/255.0, green: 117.0/255.0, blue: 117.0/255.0, alpha: 1.0)
        navigationItem.backBarButtonItem = UIBarButtonItem(title: " ", style: .plain, target: nil, action: nil)
    }
    
    
    open override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.barTintColor = UIColor.white
        navigationController?.navigationBar.isTranslucent = true
    }
    
}
