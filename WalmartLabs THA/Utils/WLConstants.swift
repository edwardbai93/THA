//
//  WLConstants.swift
//  WalmartLabs THA
//
//  Created by Edward Bai on 4/28/19.
//  Copyright © 2019 Edward Bai. All rights reserved.
//

import Foundation
import UIKit

struct WLConstants {
    struct Colors {
        static let inStockTextColor = UIColor(red: 78/255, green: 188/255, blue: 31/255, alpha: 1)
        static let outOfStockTextColor = UIColor(red: 195/255, green: 0/255, blue: 0/255, alpha: 1)
    }
    
    struct Strings {
        static let inStockStatusText = "In stock"
        static let outOfStockStatusText = "Out of stock"
        
        // Ratings
        static let noRatingsText = "No ratings yet"
        static let reviewCountFormatSingular = "See %d review"
        static let reviewCountFormatPlural = "See all %d reviews"
        
        // Product Details
        static let productDetailDescriptionHeaderText = "About this item"
    }
}
