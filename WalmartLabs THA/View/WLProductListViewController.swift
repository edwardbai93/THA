//
//  WLProductListViewController.swift
//  WalmartLabs THA
//
//  Created by Edward Bai on 4/27/19.
//  Copyright © 2019 Edward Bai. All rights reserved.
//

import UIKit



class WLProductListViewController: UIViewController {

    @IBOutlet weak var productsTableView: UITableView!
    
    let reuseIdentifier = "product"
    
    let listViewModel = WLProductListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        productsTableView.delegate = self
        productsTableView.dataSource = self
        
        productsTableView.registerCell(WLProductTableViewCell.self)
        
        fetchProducts(refresh: true)
    }
    
    func fetchProducts(refresh: Bool = false) {
        listViewModel.fetchNextPage(refresh: refresh) { [unowned self] _ in
            self.productsTableView.reloadData()
        }
    }
}

extension WLProductListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        // Prepare to load next page
        
        let shouldLoadNextPage = listViewModel.shouldLoadNextPage(atScrollingPosition: indexPath)
        if shouldLoadNextPage {
            fetchProducts()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let product = listViewModel.item(at: indexPath) {
            
        }
    }
}

extension WLProductListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listViewModel.numberOfItems
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let productCell: WLProductTableViewCell = tableView.dequeueReusableCell(indexPath: indexPath)
        if let product = listViewModel.item(at: indexPath) {
            productCell.idxLabel.text = String(indexPath.row)
            productCell.render(with: product)
        }
        return productCell
    }
}
