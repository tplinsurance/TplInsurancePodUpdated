//
//  GenralHelper.swift
//  TplInsurancTesting
//
//  Created by Tahir Raza on 25/07/2019.
//  Copyright © 2019 Mohammed Ahsan. All rights reserved.
//

//import Foundation
import UIKit

extension UIViewController {
    func showToast(message: String) {
        guard let window = UIApplication.shared.keyWindow else {
            return
        }
        
        let toastLbl = UILabel()
        toastLbl.text = message
        toastLbl.textAlignment = .center
        toastLbl.font = UIFont.systemFont(ofSize: 18)
        toastLbl.textColor = UIColor.white
        toastLbl.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLbl.numberOfLines = 0
        
        
        let textSize = toastLbl.intrinsicContentSize
        let labelHeight = ( textSize.width / window.frame.width ) * 30
        let labelWidth = min(textSize.width, window.frame.width - 40)
        let adjustedHeight = max(labelHeight, textSize.height + 20)
        
        toastLbl.frame = CGRect(x: 20, y: (window.frame.height - 90 ) - adjustedHeight, width: labelWidth + 20, height: adjustedHeight)
        toastLbl.center.x = window.center.x
        toastLbl.layer.cornerRadius = 10
        toastLbl.layer.masksToBounds = true
        
        window.addSubview(toastLbl)
        
        UIView.animate(withDuration: 3.0, animations: {
            toastLbl.alpha = 0
        }) { (_) in
            toastLbl.removeFromSuperview()
        }
        
        
    }
    
    func showActivityIndicatory() {
        var activityView = UIActivityIndicatorView(style: .whiteLarge)
        activityView.center = self.view.center
        self.view.addSubview(activityView)
        activityView.startAnimating()
    }
    
    func stopIndicator(){
        UIActivityIndicatorView().stopAnimating()
    }
}

/*
 import UIKit
 
 open class TPLInsurance: NSObject {
 
 private(set) weak var delegate: TPLInsuranceDelegate? = nil
 
 public static let shared = TPLInsurance()
 
 private override init() { }
 
 func openTPLInsurance(with controller: UIViewController, delegate: TPLInsuranceDelegate) {
 self.delegate = delegate
 presentInitialController(controller: controller)
 }
 
 private func presentInitialController(controller: UIViewController) {
 let storyBoard : UIStoryboard = UIStoryboard(name: "InsuranceMain", bundle: .framework)
 let nextViewController = storyBoard.instantiateViewController(withIdentifier: "ViewController")
 let navigationController = UINavigationController(rootViewController: nextViewController)
 controller.present(navigationController, animated:true, completion:nil)
 }
 
 }
 
 protocol TPLInsuranceDelegate: class {
 func userDidSubmittedInsurance(proposalId: String, amount: String)
 }
 
 extension Bundle {
 static let framework = Bundle.init(identifier: "org.cocoapods.TplInsurancePodUpdated")
 }
 */
