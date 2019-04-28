//
//  WLProductDetailPageViewController.swift
//  WalmartLabs THA
//
//  Created by Edward Bai on 4/28/19.
//  Copyright © 2019 Edward Bai. All rights reserved.
//

import UIKit
import SDWebImage

class WLProductDetailPageViewController: UIViewController {
    
    var product: WLProduct!
    @IBOutlet weak var productLabel: UILabel!
    
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
        
        self.productLabel.text = product.productId
        self.navigationController?.title = product.productId
    }
    
    func render(with model: WLProduct) {
        
    }
}
