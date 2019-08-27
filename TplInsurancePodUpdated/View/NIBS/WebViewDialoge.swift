//
//  WebViewDialoge.swift
//  TPLInsurance
//
//  Created by Tahir Raza on 13/11/2018.
//  Copyright © 2018 TPLHolding. All rights reserved.
//

import UIKit

class WebViewDialoge: UIView {
    @IBOutlet weak var btnDone: UIButton!
    
    class func instanceFromNib() -> WebViewDialoge {
        return UINib(nibName: "WebViewDialoge", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! WebViewDialoge
    }
 
}
