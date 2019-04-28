//
//  WLProductListViewModel.swift
//  WalmartLabs THA
//
//  Created by Edward Bai on 4/27/19.
//  Copyright © 2019 Edward Bai. All rights reserved.
//

import Foundation

class WLProductListViewModel: NSObject {
    fileprivate var products = [WLProduct]()
    
    let searchViewModel = WLProductSearchViewModel(provider: WLNetworkingManager())
    
    func fetchNextPage(refresh: Bool = false, completion: @escaping (Error?) -> ()) {
        searchViewModel.fetchNextPage { [unowned self] res in
            switch res {
            case .success(let value):
                let fetchedProducts = value.products
                if refresh {
                    self.products = fetchedProducts
                } else {
                    self.products.append(contentsOf: fetchedProducts)
                }
                completion(nil)
            case .failure(let error):
                print(error.localizedDescription)
                completion(error)
            }
        }
    }
    
    func shouldLoadNextPage(atScrollingPosition indexPath: IndexPath) -> Bool {
        let currAll = products.count
        let scrolledIdx = indexPath.row
        return scrolledIdx == currAll - 5
    }
}

extension WLProductListViewModel: ListDataSourceProtocol {
    typealias ItemType = WLProduct
    
    var numberOfItems: Int {
        return products.count
    }
    
    func item(at indexPath: IndexPath) -> WLProduct? {
        let idx = indexPath.row
        guard idx < numberOfItems else { return nil }
        return products[idx]
    }
}

/// Simple list data source type without sections
protocol ListDataSourceProtocol {
    associatedtype ItemType
    
    var numberOfItems: Int { get }
    func item(at indexPath: IndexPath) -> ItemType?
}

