//
//  WLProductDetailContainerViewController.swift
//  WalmartLabs THA
//
//  Created by Edward Bai on 4/27/19.
//  Copyright © 2019 Edward Bai. All rights reserved.
//

import UIKit

class WLProductDetailContainerViewController: UIPageViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSource = self
    }
    
    var listItemNavigation: WLProductListViewModel!
    
    class func newPage(for product: WLProduct) -> WLProductDetailContainerViewController {
        let sb = UIStoryboard(name: "Main", bundle: Bundle.main)
        guard let vc = sb.instantiateViewController(withIdentifier: "product_detail_container") as? WLProductDetailContainerViewController else {
            fatalError("Failed to instantiate view controller!")
        }
        let pageVC = WLProductDetailPageViewController.newPage(for: product)
        vc.setViewControllers([pageVC], direction: .forward, animated: true, completion: nil)
        return vc
    }
}

extension WLProductDetailContainerViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if let detailPage = viewController as? WLProductDetailPageViewController,
            let prevItem = listItemNavigation.previousItem(for: detailPage.product) {
            let pageVC = WLProductDetailPageViewController.newPage(for: prevItem)
            return pageVC
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if let detailPage = viewController as? WLProductDetailPageViewController,
            let prevItem = listItemNavigation.nextItem(for: detailPage.product) {
            let pageVC = WLProductDetailPageViewController.newPage(for: prevItem)
            return pageVC
        }
        return nil
    }
}
