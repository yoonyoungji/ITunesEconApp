//
//  SubViewController.swift
//  KakaoEconApp
//
//  Created by YoungD on 2018. 3. 31..
//  Copyright © 2018년 YoungD. All rights reserved.
//

import UIKit


class SubViewController: UIViewController {
    @IBOutlet weak var mainCollectionView: UICollectionView!
    
    var subItemList = DisplayAppSubData()
    var returnId = Int()
    
    
    var cellTypes: CellType = CellType(
        items: [
            .topItem,
            .screenShotImage,
            .contentData(title: "설명"),
            .contentData(title: "releaseNotes"),
            .infoData(title : "개발자"),
            .infoData(title : "카테고리"),
            .infoData(title : "업데이트"),
            .infoData(title : "버전"),
            .infoData(title : "등급"),
            .textData(title: "버전 업데이트 기록"),
            .textData(title: "개발자 웹사이트"),
            .textData(title: "개인정보 취급방침"),
            .textData(title: "개발자 앱"),
            ]
    )

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    
        mainCollectionView.delegate = self
        mainCollectionView.dataSource = self
        
    }
    override func viewDidLayoutSubviews() {

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let listitem = AppListItem()
        listitem.subItem(id: returnId, completion: {[weak self] response in
            switch response {
            case .success(let items):
                self?.subItemList = items
                self?.title = self?.subItemList.appName
                self?.mainCollectionView.reloadData()
            case .failure(let error):
                print(error)
            }
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension SubViewController : UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
         return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.cellTypes.items.count
    }
    
   func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch self.cellTypes.items[indexPath.item] {
        case .topItem:
            let topCell = collectionView.dequeueReusableCell(withReuseIdentifier: "topCell", for: indexPath) as! topCell
            topCell.titleLabel.text = self.subItemList.appName
            topCell.subTitleLabel.text = self.subItemList.artistName
            topCell.userRatingView.rate = self.subItemList.averageUserRating
            let url = self.subItemList.appImageURL
            if  url != ""{
                let data = try? Data(contentsOf: URL(string : url)!)
                DispatchQueue.main.async {
                    topCell.mainImageView.image = UIImage(data: data!)
                }
            }

            topCell.ageMainLabel.text = "\(self.subItemList.averageUserRating)"
            topCell.evlSubLabel.text = "\(self.subItemList.reviewCount)개의 평가"
            return topCell
        case .screenShotImage:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "screenImageCell", for: indexPath) as! screenImageCell

            cell.dataInitialize(imageURLS: self.subItemList.screenshotURLs)
            cell.subImageCollectionView.reloadData()
            return cell

        case .contentData(let title):
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "explainTextCell", for: indexPath) as! explainTextCell
            if title == "설명" {
                cell.explainTitleLabel.text = "설명"
                cell.explainLabel.text = self.subItemList.description
                
            } else if title == "releaseNotes" {
                cell.explainTitleLabel.text = "새로운 기능"
                cell.explainLabel.text = self.subItemList.releaseNotes
            }
            return cell
            
        case .infoData(let title):
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "infoExplainCell", for: indexPath) as! infoExplainCell
         
            cell.titleLabel.text = title
            if title == "개발자"{
                cell.subTitleLabel.text = self.subItemList.artistName
            }
            else if title == "카테고리"{
                cell.subTitleLabel.text = self.subItemList.genre
            }
            else if title == "업데이트"{
                cell.subTitleLabel.text = self.subItemList.releaseDate
            }
            else if title == "버전"{
                cell.subTitleLabel.text = self.subItemList.appVersion
            }
            else if title == "등급"{
                cell.subTitleLabel.text = String(self.subItemList.averageUserRating)
            }
            return cell
            
        case .textData(let title):
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "infoTitleCell", for: indexPath) as! infoTitleCell
            cell.titleLabel.text = title
            return cell
            
        default:
            return UICollectionViewCell()
        }
        
    }

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch self.cellTypes.items[indexPath.item] {
        case .topItem:
            return CGSize(width: self.view.bounds.width, height: 220)
        case.screenShotImage:
            return CGSize(width: self.view.frame.width, height: 360)
        case .contentData(let title):
            var height: CGFloat = 0
            if title == "설명" {
                height = 800
            } else if title == "releaseNotes" {
                  height = 300
            }
            return CGSize(width: self.view.frame.width, height: height)
            
        case .textData(title: ""):
            return CGSize(width: self.view.frame.width, height: 50)
            
        case .infoData:
            return CGSize(width: self.view.frame.width, height: 50)
            
        default:
            return CGSize(width: self.view.frame.width, height: 50)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.5
    }
    
    
    
    
}
