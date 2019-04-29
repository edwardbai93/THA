//
//  WLReviewStarsView.swift
//  WalmartLabs THA
//
//  Created by Edward Bai on 4/28/19.
//  Copyright © 2019 Edward Bai. All rights reserved.
//

import UIKit

@IBDesignable class WLReviewStarsView: UIView {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initImageViews()
    }
    
    required override init(frame: CGRect) {
        super.init(frame: frame)
        initImageViews()
    }
    
    private var starImageViews = [UIImageView]()
    
    @IBInspectable var emptyStarImage: UIImage? = UIImage(named: "star_empty") {
        didSet {
            redrawStars()
        }
    }
    
    @IBInspectable var fullStarImage: UIImage? = UIImage(named: "star_full") {
        didSet {
            redrawStars()
        }
    }
    
    private func initImageViews() {
        for _ in 0..<maxRating {
            let iv = UIImageView()
            iv.contentMode = .scaleAspectFit
            iv.image = emptyStarImage
            starImageViews.append(iv)
            self.addSubview(iv)
        }
    }
    
    private func removeImageViews() {
        starImageViews.removeAll(keepingCapacity: false)
    }
    
    @IBInspectable var maxRating: Int = 5 {
        didSet {
            maxRating = max(maxRating, Int(currentRating.rounded(.up)))
            if maxRating != oldValue {
                removeImageViews()
                initImageViews()
                redrawStars()
            }
        }
    }
    
    @IBInspectable var currentRating: Double = 0.0 {
        didSet {
            if currentRating != oldValue {
                redrawStars()
            }
        }
    }
    
    @IBInspectable var starSpacing: CGFloat = 3.0 {
        didSet {
            setNeedsLayout()
        }
    }
    
    func redrawStars() {
        // 2.3          f f h e e
        // 0 1 2 3 4  / 1 2 3 4 5
        // rating >= fullStar
        // rating < nextFullStar
        //
        
        
        /*
         rating = 2.3
         i=0, rating > i+1=1 -> full
         i=1, rating > i+1=2 -> full
         i=2, rating < i+1=3, rating>i=2 -> frac
         i=3, rating <i+1=4, rating<i=3 -> empty
         */
        starImageViews.enumerated().forEach { (idx, iv) in
            if currentRating >= Double(idx + 1) {
                // Full star
                iv.image = fullStarImage
                iv.layer.mask = nil
            } else if currentRating > Double(idx) && currentRating < Double(idx + 1) {
                // Fractional star
                iv.image = fullStarImage
                let maskLayer = CALayer()
                let starWidth = iv.frame.size.width
                // Only show the fraction over the previous star level
                // eg. Rating 2.3 -> Curr level 2, only show 30% over the 3rd star
                maskLayer.frame = CGRect(x: 0, y: 0, width: CGFloat(currentRating - Double(idx)) * starWidth, height: starWidth)
                maskLayer.backgroundColor = UIColor.black.cgColor
                iv.layer.mask = maskLayer
            } else {
                // Empty star
                iv.image = emptyStarImage
                iv.layer.mask = nil
            }
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let starWidth = self.frame.size.height
        let starHeight = starWidth
        
        starImageViews.enumerated().forEach { (idx, iv) in
            let ivX = CGFloat(idx) * (starWidth + starSpacing)
            let ivFrame = CGRect(x: ivX, y: 0, width: starWidth, height: starHeight)
            iv.frame = ivFrame
        }
        
        redrawStars()
    }
}
