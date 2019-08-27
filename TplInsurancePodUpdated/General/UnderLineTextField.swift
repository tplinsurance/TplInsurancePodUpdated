//
//  UnderLineTextField.swift
//  TPLInsurance
//
//  Created by Sajad on 1/24/18.
//  Copyright © 2018 TPLHolding. All rights reserved.
//

import UIKit


@IBDesignable
class UnderLineTextField: ValidationTextField {

    @IBInspectable var underLineColor: UIColor = UIColor.black
    @IBInspectable var rightImage: UIImage?
    
    var rightImageView : UIImageView?
    
    
    func setRightControl() {
        if let image = rightImage {
            let view = UIView(frame: CGRect(x: 0, y: 0, width: 44.0, height: 44.0))
            //view.backgroundColor = UIColor.red
            
            let imageViewSize: CGFloat = 16.0
            let containerCenter = view.center
            let imageView = UIImageView(frame: CGRect(x: containerCenter.x,
                                                      y: containerCenter.y - imageViewSize/2,
                                                      width: imageViewSize,
                                                      height: imageViewSize))
            imageView.contentMode = .scaleAspectFit
            imageView.image = image
            imageView.tintColor = UIColor(red: 0.0/255.0, green: 0.0/255.0, blue: 0.0/255.0, alpha: 1.0)
            rightImageView = imageView
            view.addSubview(imageView)
            
            rightView = view
            rightViewMode = .always
            //isUserInteractionEnabled = false
        }
    }
    
    override var isEnabled: Bool {
        didSet {
            super.isEnabled = isEnabled
            underLineColor = isEnabled ? UIColor.black : UIColor.lightGray
            self.textColor = isEnabled ? UIColor.black : UIColor.lightGray
            if rightImage != nil , let imageView = rightImageView {
                imageView.tintColor = isEnabled ? UIColor.black : UIColor.lightGray
            }
        }
    }
    
    override func awakeFromNib() {
        setRightControl()
    }
    
    override func draw(_ rect: CGRect) {
        // Drawing code
        let path = UIBezierPath()
        underLineColor.set()
        path.move(to: CGPoint(x: 0.0, y: frame.height-1.0))
        path.addLine(to: CGPoint(x: frame.width, y: frame.height-1.0))
        path.stroke()
        //setRightControl()
    }
    
    

}
