//
//  WLProductSearchViewModel.swift
//  WalmartLabs THA
//
//  Created by Edward Bai on 4/27/19.
//  Copyright © 2019 Edward Bai. All rights reserved.
//

import Foundation

enum WLProductSearchError: Error, CustomStringConvertible {
    case unknown
    case noMoreToFetch
    case noReachability
    
    var description: String {
        switch self {
        case .unknown:
            return WLConstants.Strings.defaultErrorTitle
        case .noMoreToFetch:
            return WLConstants.Strings.noMoreResultsMessage
        case .noReachability:
            return WLConstants.Strings.noReachabilityMessage
        }
    }
    
    var localizedDescription: String {
        return self.description
    }
}

class WLProductSearchViewModel {
    private var isRequestInProgress = false
    private var currentPage = 0 // Start from 1
    private(set) var total = 0
    private let pageSize = 20
    
    var shouldFetchNextPage: Bool {
        return currentPage * pageSize <= total
    }
    private let dataProvider: WLProductListDataProvider
    
    init(provider: WLProductListDataProvider) {
        self.dataProvider = provider
    }
    
    func fetchNextPage(completion: @escaping WLProductListResultBlock) {
        guard !isRequestInProgress else {
            // Ignore the request
            return
        }
        
        guard shouldFetchNextPage else {
            completion(WLResultType.failure(WLProductSearchError.noMoreToFetch))
            return
        }
        
        isRequestInProgress = true
        let nextPage = currentPage + 1
        
        dataProvider.fetchProductList(pageNumber: nextPage, pageSize: pageSize) { [unowned self] result in
            switch result {
            case .success(let response):
                self.total = response.totalProducts
                self.currentPage = nextPage
            case .failure(let error):
                print(error.localizedDescription)
            }
            completion(result)
            self.isRequestInProgress = false
        }
    }
}
