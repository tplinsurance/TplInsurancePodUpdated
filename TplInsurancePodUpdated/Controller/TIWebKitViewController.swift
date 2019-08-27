//
//  TIWebKitViewController.swift
//  TPLInsurance
//
//  Created by Tahir Raza on 27/12/2018.
//  Copyright © 2018 TPLHolding. All rights reserved.
//

import UIKit
import WebKit
//webView

class TIWebKitViewController: UIViewController {
    var myurl : String?

    @IBOutlet weak var TIWebView: WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()

        print("url =\(String(describing: myurl))")
        
        let url : NSString = myurl! as NSString
        let urlStr : NSString = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) as! NSString
        let searchURL : NSURL = NSURL(string: urlStr as String)!
        
        print("NSurl =\(String(describing: searchURL))")
        let request = URLRequest(url: searchURL as URL)
        
        TIWebView.load(request)
        
        self.navigationItem.hidesBackButton = true
        let newBackButton = UIBarButtonItem(title: "Back", style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.back(sender:)))
        self.navigationItem.leftBarButtonItem = newBackButton
        
    }
    
    @objc func back(sender: UIBarButtonItem) {

        let cancelAlert = UIAlertController(title: "Quit", message: "Are you sure you want to go back to home?", preferredStyle: UIAlertController.Style.alert)

        cancelAlert.addAction(UIAlertAction(title: "Confirm", style: .default, handler: { (action: UIAlertAction!) in
//            self.navigationController?.popViewController(animated: false)
            if let viewControllers = self.navigationController?.viewControllers, viewControllers.count > 0 {
                for each in viewControllers {
                    if each.isKind(of: ViewController.self) {
                        self.navigationController?.popToViewController(each, animated: true)
                    }
                }
            }
//            self.navigationController?.popViewController(animated: true)

//            let viewControllers: [UIViewController] = self.navigationController!.viewControllers as [UIViewController]
//            self.navigationController!.popToViewController(viewControllers[viewControllers.count - 6], animated: true)

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
