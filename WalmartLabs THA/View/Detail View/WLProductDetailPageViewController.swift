//
//  WLProductDetailPageViewController.swift
//  WalmartLabs THA
//
//  Created by Edward Bai on 4/28/19.
//  Copyright © 2019 Edward Bai. All rights reserved.
//

import UIKit
import SDWebImage

class WLProductDetailPageViewController: UITableViewController {
    private let kItemSummarySection = 0
    private let kItemDetailSection = 1
    
    @IBOutlet weak var productShortDescCell: UITableViewCell!
    
    var product: WLProduct!
    
    // Reviews
    @IBOutlet weak var productEmptyReviewLabel: UILabel!
    @IBOutlet weak var productReviewStarsView: WLReviewStarsView!
    @IBOutlet weak var productReviewSummaryButton: UIButton!
    
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productPriceLabel: UILabel!
    @IBOutlet weak var productInStockLabel: UILabel!
    @IBOutlet weak var productShortDescLabel: UILabel!
    @IBOutlet weak var productLongDescLabel: UILabel!
    
    class func newPage(for product: WLProduct) -> WLProductDetailPageViewController {
        let sb = UIStoryboard(name: "Main", bundle: Bundle.main)
        guard let vc = sb.instantiateViewController(withIdentifier: "product_detail") as? WLProductDetailPageViewController else {
            fatalError("Failed to instantiate view controller!")
        }
        vc.product = product
        return vc
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView() // Fake footer
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        render(with: product)
    }
    
    func render(with model: WLProduct) {
        productNameLabel.text = model.productName
        productImageView.sd_setImage(with: model.productImageUrl, placeholderImage: nil, options: .progressiveLoad, context: nil)
        
        // Reviews section
        if model.reviewCount == 0 {
            productReviewStarsView.isHidden = true
            productReviewSummaryButton.isHidden = true
            productEmptyReviewLabel.isHidden = false
            productEmptyReviewLabel.text = WLConstants.Strings.noRatingsText
        } else {
            productReviewStarsView.isHidden = false
            productReviewSummaryButton.isHidden = false
            productEmptyReviewLabel.isHidden = true
            productReviewStarsView.currentRating = model.reviewRating
            renderReviewSummaryButtonText(with: model)
        }
        
        // Price section
        productPriceLabel.text = model.price
        renderInStockLabel(with: model)
        
        productShortDescLabel.setHTMLText(model.shortDescription)
        if model.shortDescription == nil {
            productShortDescCell.removeFromSuperview()
        }
        productLongDescLabel.setHTMLText(model.longDescription)
    }
    
    private func renderInStockLabel(with model: WLProduct) {
        productInStockLabel.text = model.inStock ?
            WLConstants.Strings.inStockStatusText :
            WLConstants.Strings.outOfStockStatusText
        productInStockLabel.textColor = model.inStock ?
            WLConstants.Colors.inStockTextColor :
            WLConstants.Colors.outOfStockTextColor
    }
    
    private func renderReviewSummaryButtonText(with model: WLProduct) {
        let count = model.reviewCount
        switch count {
        case 0:
            productReviewSummaryButton.isHidden = true
        case 1:
            let text = String(format: WLConstants.Strings.reviewCountFormatSingular, count)
            productReviewSummaryButton.setTitle(text, for: .normal)
            productReviewSummaryButton.isHidden = false
        default:
            let text = String(format: WLConstants.Strings.reviewCountFormatPlural, count)
            productReviewSummaryButton.setTitle(text, for: .normal)
            productReviewSummaryButton.isHidden = false
        }
    }
    
    // MARK: Override superclass
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == kItemDetailSection {
            return product.longDescription == nil ? nil : WLConstants.Strings.productDetailDescriptionHeaderText
        }
        return super.tableView(tableView, titleForHeaderInSection: section)
    }
}
