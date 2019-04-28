//
//  WLProduct.swift
//  WalmartLabs THA
//
//  Created by Edward Bai on 4/27/19.
//  Copyright © 2019 Edward Bai. All rights reserved.
//

import Foundation
import SwiftyJSON

/*
 {
 "productId":"003e3e6a-3f84-43ac-8ef3-a5ae2db0f80e",
 "productName":"Ellerton TV Console",
 "shortDescription":"<p><span style=\"color:#FF0000;\"><b>White Glove Delivery Included</b></span></p>\n\n<ul>\n\t<li>Excellent for the gamer, movie enthusiest, or interior decorator in your home</li>\n\t<li>Built-in power strip for electronics</li>\n\t<li>Hardwood solids and cherry veneers</li>\n</ul>\n",
 "longDescription":"<p>The Ellerton media console is well-suited for today&rsquo;s casual lifestyle. Its elegant style and expert construction will make it a centerpiece in any home. Soundly constructed, the Ellerton uses hardwood solids &amp; cherry veneers elegantly finished in a rich dark cherry finish. &nbsp;With ample storage for electronics &amp; media, it also cleverly allows for customization with three choices of interchangeable door panels.</p>\n",
 "price":"$949.00",
 "productImage":"/images/image2.jpeg",
 "reviewRating":2,
 "reviewCount":1,
 "inStock":true
 }
 
 */

public class WLProduct: NSObject {
    let productId: String
    let productName: String
    
    /// Short HTML description string
    let shortDescription: String
    
    /// Long HTML description string
    let longDescription: String
    
    let price: String
    let productImageUrl: URL?
    let reviewRating: Double
    let reviewCount: Int
    let inStock: Bool
    
    init(fromJSON json: JSON) {
        productId = json["productId"].stringValue
        productName = json["productName"].stringValue
        shortDescription = json["shortDescription"].stringValue
        longDescription = json["longDescription"].stringValue
        price = json["price"].stringValue
        
        if let imagePath = json["productImage"].string {
            productImageUrl = requestBaseUrl.appendingPathComponent(imagePath)
        } else {
            productImageUrl = nil
        }
        
        reviewRating = json["reviewRating"].doubleValue
        reviewCount = json["reviewCount"].intValue
        inStock = json["inStock"].boolValue
        
        super.init()
    }
}
