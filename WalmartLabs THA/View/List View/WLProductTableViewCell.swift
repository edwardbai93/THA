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
    
    @IBOutlet weak var reviewStarsView: WLReviewStarsView!
    @IBOutlet weak var reviewStarsLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var inStockLabel: UILabel!
    
    func render(with model: WLProduct) {
        productNameLabel.text = model.productName
        priceLabel.text = model.price
        self.productImageView.sd_setImage(with: model.productImageUrl, placeholderImage: nil, options: .progressiveLoad, completed: nil)
        
        // Ratings
        if model.reviewCount == 0 {
            reviewStarsView.isHidden = true
            reviewStarsLabel.text = WLConstants.Strings.noRatingsText
        } else {
            reviewStarsView.isHidden = false
            reviewStarsView.currentRating = model.reviewRating
            let ratingText = String(format: "%.1f", model.reviewRating)
            reviewStarsLabel.text = ratingText
        }
        
        // In stock status
        renderInStockLabel(with: model)
    }
    
    private func renderInStockLabel(with model: WLProduct) {
        inStockLabel.text = model.inStock ?
            WLConstants.Strings.inStockStatusText :
            WLConstants.Strings.outOfStockStatusText
        inStockLabel.textColor = model.inStock ?
            WLConstants.Colors.inStockTextColor :
            WLConstants.Colors.outOfStockTextColor
    }
}
