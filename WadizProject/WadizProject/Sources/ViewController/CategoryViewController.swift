//
//  CategoryViewController.swift
//  WadizProject
//
//  Created by Jo JANGHUI on 2018. 8. 7..
//  Copyright © 2018년 JhDAT. All rights reserved.
//

import UIKit

class CategoryViewController: UIViewController {
    
    
    //        ["전체보기", "테크·가전", "패션·잡화", "뷰티", "푸드", "홈리빙", "디자인소품", "여행·레저", "스포츠·모빌리티", "반려동물", "공연·컬처", "소셜·캠페인", "교육·키즈", "게임·취미", "출판"]
    
    @IBOutlet weak var tableView: UITableView!
    
    var titlename: String?
    
    let rewards = PostService()
    var rewardsArr: [Rewards.Results] = []
    var searchResults: [Rewards.Results]? {
        didSet {
            tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        print("rewardsArr : ", rewardsArr.isEmpty)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.isHidden = false
        if rewardsArr.isEmpty {
            tableView.isHidden = true
            print("tableView.isHidden")
            let empty = EmptyView(frame: view.frame)
            view.addSubview(empty)
//            let view = EmptyView(frame: self.view.frame)
//            view.addSubview(view)
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension CategoryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            if searchResults == nil {
                return rewardsArr.count
            } else {
                guard let search = searchResults?.count else { return 0}
                return search
            }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if GrideView.shared.isShow {
            let rewardsCell
                = tableView.dequeueReusableCell(
                    withIdentifier: "RewardsCell",
                    for: indexPath) as! RewardsTableViewCell
            tableView.rowHeight = rewardsCell.rowHeight

            if searchResults == nil {
                let url = URL(string: rewardsArr[indexPath.row].productImg)
                rewardsCell.productImg.kf.setImage(with: url)
                rewardsCell.productName.text = rewardsArr[indexPath.row].productName
                rewardsCell.type.text = rewardsArr[indexPath.row].type
                rewardsCell.companyName.text = "| " + rewardsArr[indexPath.row].companyName
                rewardsCell.totalAAmount.text = String(rewardsArr[indexPath.row].totalAAmount)
            } else {
                guard let search = searchResults else { return rewardsCell }
                let searchURL = URL(string: search[indexPath.row].productImg)
                rewardsCell.productImg.kf.setImage(with: searchURL)
                rewardsCell.productName.text = search[indexPath.row].productName
                rewardsCell.type.text = search[indexPath.row].type
                rewardsCell.companyName.text = "| " + search[indexPath.row].companyName
                rewardsCell.totalAAmount.text = String(search[indexPath.row].totalAAmount)
            }
            return rewardsCell
        } else {
            let rewardsGridCell
                = tableView.dequeueReusableCell(
                    withIdentifier: "RewardsGridCell",
                    for: indexPath) as! RewardsGridTableViewCell
            tableView.rowHeight = rewardsGridCell.rowHeight

            if searchResults == nil {
                let url = URL(string: rewardsArr[indexPath.row].productImg)
                rewardsGridCell.productImg.kf.setImage(with: url)
                rewardsGridCell.productName.text = rewardsArr[indexPath.row].productName
                rewardsGridCell.type.text = rewardsArr[indexPath.row].type
                rewardsGridCell.companyName.text = "| " + rewardsArr[indexPath.row].companyName
                rewardsGridCell.totalAAmount.text = String(rewardsArr[indexPath.row].totalAAmount)
            } else {
                guard let search = searchResults else { return rewardsGridCell }
                let searchURL = URL(string: search[indexPath.row].productImg)
                rewardsGridCell.productImg.kf.setImage(with: searchURL)
                rewardsGridCell.productName.text = search[indexPath.row].productName
                rewardsGridCell.type.text = search[indexPath.row].type
                rewardsGridCell.companyName.text = "| " + search[indexPath.row].companyName
                rewardsGridCell.totalAAmount.text = String(search[indexPath.row].totalAAmount)
            }
            return rewardsGridCell
        }
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        tableView.register(UINib(nibName: "HeaderCellTableViewCell", bundle: nil), forCellReuseIdentifier: "HeaderCellTableViewCell")
        let  header = tableView.dequeueReusableCell(withIdentifier: "HeaderCellTableViewCell") as! HeaderCellTableViewCell
        header.searchTextField.delegate = self as UITextFieldDelegate
        header.delegate = self
        return header
    }
}

// MARK:- UITableViewDelegate

extension CategoryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
            return 40
    }
}

// MARK:- UITextFieldDelegate

extension CategoryViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let text = textField.text else { return  true }
        rewards.searchGetList(frame: view.frame, text: text){[weak self] (reward) in
            guard let strongSelf = self else { return }
            strongSelf.searchResults = reward.results
        }
        textField.resignFirstResponder()
        return true
    }
}

// MARK: - HeaderCellTableViewCellDelegate

extension CategoryViewController: HeaderCellTableViewCellDelegate {
    func viewChange() {
        tableView.reloadData()
    }
}

