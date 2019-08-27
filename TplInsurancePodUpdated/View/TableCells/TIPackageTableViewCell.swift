//
//  TIPackageTableViewCell.swift
//  TPLInsurance
//
//  Created by Tahir Raza on 03/12/2018.
//  Copyright © 2018 TPLHolding. All rights reserved.
//

import UIKit

class TIPackageTableViewCell: UITableViewCell {

    @IBOutlet weak var headingLabel: UILabel!
    @IBOutlet weak var subHeadingLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var btnKnowMore: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
