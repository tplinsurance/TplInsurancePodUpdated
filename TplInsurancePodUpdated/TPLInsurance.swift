//
//  TPLInsurance.swift
//  TplInsurancePodUpdated
//
//  Created by Tahir Raza on 27/08/2019.
//  Copyright © 2019 Mohammed Ahsan. All rights reserved.
//

import UIKit

open class TPLInsurance: NSObject {

    weak var delegate: TPLInsuranceDelegate? = nil
    
    public static let shared = TPLInsurance()
    
    private override init() { }
    
    open func openTPLInsurance(with controller: UIViewController, delegate: TPLInsuranceDelegate) {
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

public protocol TPLInsuranceDelegate: class {
    func userDidSubmittedInsurance(proposalId: String, amount: String)
}

extension Bundle {
    static let framework = Bundle.init(identifier: "org.cocoapods.TplInsurancePodUpdated")
}
