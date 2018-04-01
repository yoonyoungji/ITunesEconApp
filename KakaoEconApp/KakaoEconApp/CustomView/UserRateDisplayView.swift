//
//  UserRateDisplayView.swift
//  KakaoEconApp
//
//  Created by YoungD on 2018. 4. 1..
//  Copyright © 2018년 YoungD. All rights reserved.
//

import UIKit

class UserRatingView: UIView {

    struct Metric {
        static let spacing: CGFloat = 2
        static let maxRate: Int = 5
    }

    var rate: Float? = 0 {
        didSet {
            self.drawStar()
        }
    }

    public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.backgroundColor = .clear
    }
    
    fileprivate func drawStar() {
        guard let rating = self.rate, rating > 0 else { return }
        
        let width = self.frame.size.height
        let userRating = CGFloat(rating)
        
        for i in 0..<Metric.maxRate {
            let index = CGFloat(i)
            let imageFrame = CGRect(x: (width + Metric.spacing) * index,
                                    y: 0,
                                    width: width,
                                    height: width)
            if index < userRating {
                if 0 < floor(userRating - index) {
                    let imageView = UIImageView(image: #imageLiteral(resourceName: "fill_star"))
                    imageView.frame = imageFrame
                    self.addSubview(imageView)
                } else {
                    let imageView = UIImageView(image: #imageLiteral(resourceName: "half_star"))
                    imageView.frame = imageFrame
                    self.addSubview(imageView)
                }
            } else {
                let imageView = UIImageView(image: #imageLiteral(resourceName: "empty_star"))
                imageView.frame = imageFrame
                self.addSubview(imageView)
            }
        }
    }
    
}
