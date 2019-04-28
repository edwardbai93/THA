//
//  WLProductParsingTest.swift
//  WalmartLabs THATests
//
//  Created by Edward Bai on 4/27/19.
//  Copyright © 2019 Edward Bai. All rights reserved.
//

import XCTest
import SwiftyJSON
@testable import WalmartLabs_THA

class WLProductParsingTest: XCTestCase {

    var json: JSON?
    
    override func setUp() {
        json = WLJSONLoader.loadJSON(filename: "testProduct", bundle: Bundle(for: WLProductParsingTest.self))
    }

    func testWLProductParsing() {
        guard let json = json else {
            XCTFail("Failed to load JSON from file")
            return
        }
        let product = WLProduct(fromJSON: json)
        XCTAssertEqual(product.productId, "003e3e6a-3f84-43ac-8ef3-a5ae2db0f80e")
        XCTAssertEqual(product.productName, "Ellerton TV Console")
        XCTAssertEqual(product.shortDescription, "<p><span style=\"color:#FF0000;\"><b>White Glove Delivery Included</b></span></p>\n\n<ul>\n\t<li>Excellent for the gamer, movie enthusiest, or interior decorator in your home</li>\n\t<li>Built-in power strip for electronics</li>\n\t<li>Hardwood solids and cherry veneers</li>\n</ul>\n")
        XCTAssertEqual(product.longDescription, "<p>The Ellerton media console is well-suited for today&rsquo;s casual lifestyle. Its elegant style and expert construction will make it a centerpiece in any home. Soundly constructed, the Ellerton uses hardwood solids &amp; cherry veneers elegantly finished in a rich dark cherry finish. &nbsp;With ample storage for electronics &amp; media, it also cleverly allows for customization with three choices of interchangeable door panels.</p>\n")
        XCTAssertEqual(product.price, "$949.00")
        
        let expectedImageURL = URL(string: "https://mobile-tha-server.firebaseapp.com/images/image2.jpeg")
        XCTAssertEqual(product.productImageUrl, expectedImageURL)
        
        XCTAssertEqual(product.reviewRating, 2)
        XCTAssertEqual(product.reviewCount, 1)
        XCTAssertEqual(product.inStock, true)
        
    }
}
