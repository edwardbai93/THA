//
//  WLJSONLoader.swift
//  WalmartLabs THATests
//
//  Created by Edward Bai on 4/27/19.
//  Copyright © 2019 Edward Bai. All rights reserved.
//

import Foundation
import SwiftyJSON

class WLJSONLoader {
    class func loadJSON(filename: String, bundle: Bundle = Bundle.main) -> JSON? {
        if let filePath = bundle.path(forResource: filename, ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: filePath))
                let json = try JSON(data: data)
                return json
            } catch let error {
                print(error.localizedDescription)
                return nil
            }
        } else {
            return nil
        }
    }
}
