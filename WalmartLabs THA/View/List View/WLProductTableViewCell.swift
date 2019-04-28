//
//  WLProductTableViewCell.swift
//  WalmartLabs THA
//
//  Created by Edward Bai on 4/27/19.
//  Copyright © 2019 Edward Bai. All rights reserved.
//

import UIKit
import SDWebImage

class WLProductTableViewCell: UITableViewCell {
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productImageView: UIImageView!
    
    @IBOutlet weak var idxLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    func render(with model: WLProduct) {
        self.productNameLabel.text = model.productName
        self.priceLabel.text = model.price
        self.productImageView.sd_setImage(with: model.productImageUrl, placeholderImage: nil, options: .progressiveLoad, completed: nil)
    }
}
