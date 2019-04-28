//
//  WLNetworkingManager.swift
//  WalmartLabs THA
//
//  Created by Edward Bai on 4/27/19.
//  Copyright © 2019 Edward Bai. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class WLProductListResponse {
    let products: [WLProduct]
    let totalProducts: Int
    let pageNumber: Int
    let pageSize: Int
    let statusCode: Int
    
    init(json: JSON) {
        products = json["products"].arrayValue.map { WLProduct(fromJSON: $0) }
        totalProducts = json["totalProducts"].intValue
        pageNumber = json["pageNumber"].intValue
        pageSize = json["pageSize"].intValue
        statusCode = json["statusCode"].intValue
    }
}

typealias WLResultType = Alamofire.Result
typealias WLProductListResultBlock = (WLResultType<WLProductListResponse>) -> Void

protocol WLProductListDataProvider {
    func fetchProductList(pageNumber: Int,
                          pageSize: Int,
                          resultBlock: @escaping WLProductListResultBlock)
}

public let requestBaseUrl = URL(string: "https://mobile-tha-server.firebaseapp.com")!

class WLNetworkingManager: WLProductListDataProvider {
    func fetchProductList(pageNumber: Int, pageSize: Int, resultBlock: @escaping WLProductListResultBlock) {
        
        let requestUrl = requestBaseUrl
            .appendingPathComponent("walmartproducts")
            .appendingPathComponent(String(pageNumber))
            .appendingPathComponent(String(pageSize))
        
        Alamofire
            .request(requestUrl)
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    let jsonData = JSON(value)
                    let res = WLProductListResponse(json: jsonData)
                    resultBlock(WLResultType<WLProductListResponse>.success(res))
                case .failure(let error):
                    resultBlock(WLResultType<WLProductListResponse>.failure(error))
                }
        }
    }
}
