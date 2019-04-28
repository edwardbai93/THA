//
//  WLExtensions.swift
//  WalmartLabs THA
//
//  Created by Edward Bai on 4/27/19.
//  Copyright © 2019 Edward Bai. All rights reserved.
//

import Foundation
import UIKit

extension UILabel {
    func setHTMLText(_ text: String) {
        guard let encoded = text.data(using: String.Encoding.utf8) else {
            self.attributedText = nil
            return
        }
        do {
            let attrStr = try NSAttributedString(data: encoded,
                                                 options: [.documentType: NSAttributedString.DocumentType.html,
                                                           .characterEncoding: String.Encoding.utf8.rawValue],
                                                 documentAttributes: nil)
            self.attributedText = attrStr
        } catch let error {
            print(error.localizedDescription)
        }
    }
}

extension UITableView {
    func registerCell<T: UITableViewCell>(_ type: T.Type, bundle: Bundle? = nil) {
        let identifier = String(describing: T.self)
        let nib = UINib(nibName: identifier, bundle: bundle)
        register(nib, forCellReuseIdentifier: identifier)
    }
    
    func dequeueReusableCell<T: UITableViewCell>(indexPath: IndexPath) -> T {
        let identifier = String(describing: T.self)
        guard let cell = dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? T else {
            fatalError("Failed to dequeue reusable cell with identifier: \(identifier)")
        }
        return cell
    }
}
