//
//  MainCollectionViewCell.swift
//  KakaoEconApp
//
//  Created by YoungD on 2018. 4. 1..
//  Copyright © 2018년 YoungD. All rights reserved.
//

import UIKit

struct Font {
    static let subTitleLabel = UIFont.systemFont(ofSize: 12)
}


class topCell : UICollectionViewCell{
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var moreButton: UIButton!
    
    @IBOutlet weak var userRatingView: UserRatingView!
    
    @IBOutlet weak var evlSubLabel: UILabel!
    @IBOutlet weak var ageMainLabel: UILabel!
    @IBOutlet weak var ageSubLabel: UILabel!
    
    override func awakeFromNib() {
        sendButton.layer.cornerRadius = 15
        moreButton.layer.cornerRadius = 16
    }
}


class screenImageCell : UICollectionViewCell{
    @IBOutlet weak var subImageCollectionView: UICollectionView!
    var displayImageURLs = Array<String>()
    
    override func awakeFromNib() {
        subImageCollectionView.delegate = self
        subImageCollectionView.dataSource = self
        subImageCollectionView.backgroundColor = UIColor.clear
    }
 
    func dataInitialize(imageURLS : Array<String>){
        self.displayImageURLs = imageURLS
    }
    
}
extension screenImageCell : UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.displayImageURLs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "onlyImageCell", for: indexPath) as! onlyImageCell
        let data = self.displayImageURLs[indexPath.row]
        let url = URL(string: data)
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: url!)
            DispatchQueue.main.async {
                cell.mainImageView.image = UIImage(data: data!)
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
       
        return CGSize(width: 200, height: 300)
    }
    

}

class onlyImageCell : UICollectionViewCell{
    @IBOutlet weak var mainImageView: UIImageView!
    
}

class explainTextCell : UICollectionViewCell{
    @IBOutlet weak var explainLabel: UILabel!
    @IBOutlet weak var explainTitleLabel: UILabel!
    
   
    
}

class infoTitleCell : UICollectionViewCell{
    
    @IBOutlet weak var titleLabel: UILabel!
}

class infoExplainCell : UICollectionViewCell{
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    
}

