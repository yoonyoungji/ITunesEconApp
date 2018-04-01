//
//  ViewController.swift
//  KakaoEconApp
//
//  Created by YoungD on 2018. 3. 31..
//  Copyright © 2018년 YoungD. All rights reserved.
//

import UIKit
class mainListCell : UITableViewCell{
    
    @IBOutlet weak var subImageView: UIImageView!
    @IBOutlet weak var mainTitleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var sendButton: UIButton!
    
    override func awakeFromNib() {
        self.sendButton.layer.cornerRadius = 15
    }
}

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
    var appItems = Array<DisplayAppData>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorInset = UIEdgeInsets.zero
        if #available(iOS 11.0, *) {
            tableView.contentInsetAdjustmentBehavior = .never
        } else {
            automaticallyAdjustsScrollViewInsets = false
        }
        self.title = "금융"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "카테고리", style: .plain, target: self, action: #selector(leftBarButtonAction))
 
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let index = self.tableView.indexPathForSelectedRow{
            self.tableView.deselectRow(at: index, animated: true)
        }
        
        let listitem = AppListItem()
        listitem.initData(completion: {[weak self] response in
            switch response {
            case .success(let apps):
                self?.appItems = apps
                self?.tableView.reloadData()
                
            case .failure(let error):
                print(error)
            }
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func leftBarButtonAction() {

    }

}

extension ViewController : UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let subVC = mainStoryboard.instantiateViewController(withIdentifier: "SubViewController") as! SubViewController
        subVC.returnId = Int(self.appItems[indexPath.row].id)!
        self.navigationController!.pushViewController(subVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.appItems.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mainListCell", for: indexPath) as! mainListCell
        let data = self.appItems[indexPath.row]
        cell.mainTitleLabel.text = data.appName
        cell.subTitleLabel.text = data.category
        
        let url = URL(string: data.imageURL)
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: url!)
            DispatchQueue.main.async {
                cell.subImageView.image = UIImage(data: data!)
            }
        }
        
        return cell
    }
}

