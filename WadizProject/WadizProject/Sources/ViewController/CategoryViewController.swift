//
//  CategoryViewController.swift
//  WadizProject
//
//  Created by Jo JANGHUI on 2018. 8. 7..
//  Copyright © 2018년 JhDAT. All rights reserved.
//

import UIKit

class CategoryViewController: UIViewController {
    
    //MARK: - IBOutlet
    @IBOutlet weak var tableView: UITableView!
    
    let rewards = PostService()
    
    var titlename: String?
    var rewardsArr: [Rewards.Results] = []
    var searchResults: [Rewards.Results]? {
        didSet {
            tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.isHidden = false
        if rewardsArr.isEmpty {
            tableView.isHidden = true
            let empty = EmptyView(frame: view.frame)
            view.addSubview(empty)
        }
    }
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
            rewardsCell.totalPercent.textColor = Color.shared.symbolColor
            if searchResults == nil {
                let url = URL(string: rewardsArr[indexPath.row].productImg)
                rewardsCell.productImg.kf.setImage(with: url)
                rewardsCell.productName.text = rewardsArr[indexPath.row].productName
                rewardsCell.type.text = rewardsArr[indexPath.row].type
                rewardsCell.companyName.text = "| " + rewardsArr[indexPath.row].companyName
                rewardsCell.currentAmount.text = rewardsArr[indexPath.row].currentAmountFormatter
                rewardsCell.dayLeft.text = rewardsArr[indexPath.row].remainingDay
                rewardsCell.totalPercent.text = String(rewardsArr[indexPath.row].totalPercent)
                
                rewardsCell.progress.progress = rewardsArr[indexPath.row].progress
                
                if rewardsArr[indexPath.row].isFinish {
                    rewardsCell.dayFinish.isHidden = true
                } else {
                    rewardsCell.dayFinish.isHidden = false
                }
                
            } else {
                guard let search = searchResults else { return rewardsCell }
                let searchURL = URL(string: search[indexPath.row].productImg)
                rewardsCell.productImg.kf.setImage(with: searchURL)
                rewardsCell.productName.text = search[indexPath.row].productName
                rewardsCell.type.text = search[indexPath.row].type
                rewardsCell.companyName.text = "| " + search[indexPath.row].companyName
                rewardsCell.currentAmount.text = search[indexPath.row].currentAmountFormatter
                
                rewardsCell.dayLeft.text = search[indexPath.row].remainingDay
                rewardsCell.totalPercent.text = String(search[indexPath.row].totalPercent)
                
                rewardsCell.progress.progress = search[indexPath.row].progress
                
                if search[indexPath.row].isFinish {
                    rewardsCell.dayFinish.isHidden = true
                } else {
                    rewardsCell.dayFinish.isHidden = false
                }
            }
            return rewardsCell
        } else {
            let rewardsGridCell
                = tableView.dequeueReusableCell(
                    withIdentifier: "RewardsGridCell",
                    for: indexPath) as! RewardsGridTableViewCell
            tableView.rowHeight = rewardsGridCell.rowHeight
            rewardsGridCell.totalPercent.textColor = Color.shared.symbolColor
            if searchResults == nil {
                let url = URL(string: rewardsArr[indexPath.row].productImg)
                rewardsGridCell.productImg.kf.setImage(with: url)
                rewardsGridCell.productName.text = rewardsArr[indexPath.row].productName
                rewardsGridCell.type.text = rewardsArr[indexPath.row].type
                rewardsGridCell.companyName.text = "| " + rewardsArr[indexPath.row].companyName
                rewardsGridCell.currentAmount.text = rewardsArr[indexPath.row].currentAmountFormatter
                rewardsGridCell.dayLeft.text = rewardsArr[indexPath.row].remainingDay
                rewardsGridCell.totalPercent.text = String(rewardsArr[indexPath.row].totalPercent)
                rewardsGridCell.progress.progress = rewardsArr[indexPath.row].progress
                
                if rewardsArr[indexPath.row].isFinish {
                    rewardsGridCell.dayFinish.isHidden = true
                } else {
                    rewardsGridCell.dayFinish.isHidden = false
                }
            } else {
                guard let search = searchResults else { return rewardsGridCell }
                let searchURL = URL(string: search[indexPath.row].productImg)
                rewardsGridCell.productImg.kf.setImage(with: searchURL)
                rewardsGridCell.productName.text = search[indexPath.row].productName
                rewardsGridCell.type.text = search[indexPath.row].type
                rewardsGridCell.companyName.text = "| " + search[indexPath.row].companyName
                rewardsGridCell.currentAmount.text = search[indexPath.row].currentAmountFormatter
                rewardsGridCell.dayLeft.text = search[indexPath.row].remainingDay
                rewardsGridCell.totalPercent.text = String(search[indexPath.row].totalPercent)
                rewardsGridCell.progress.progress = search[indexPath.row].progress
                
                if search[indexPath.row].isFinish {
                    rewardsGridCell.dayFinish.isHidden = true
                } else {
                    rewardsGridCell.dayFinish.isHidden = false
                }
            }
            return rewardsGridCell
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        tableView.rowHeight = 0
        
        let endCell = tableView.numberOfRows(inSection: 0)
        if indexPath.row == (endCell - 4) {
            rewards.nextRewardGetList { [weak self] (reward) in
                guard let strongSelf = self else { return }
                strongSelf.rewardsArr += reward.results
                guard let nextURL = reward.next else {strongSelf.tableView.reloadData(); return }
                API.nextURL = nextURL
                strongSelf.tableView.reloadData()
                //TODO: - 6번째 로드시 post err 발생 (원인찾기)
            }
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
    
    func actionSoringChange() {
        let textArr = ["-product_interested_count", "-product_cur_amount", "-product_end_time"]
        
        let alertContoller = UIAlertController(title: "정렬", message: nil, preferredStyle: UIAlertControllerStyle.actionSheet)
        
        let interestedCount = UIAlertAction(title: "인기순", style: .default) { (action) in
            self.rewards.sortedGetList(frame: self.view.frame, title: textArr[0], category: self.titlename!, completion: { (reward) in
                self.rewardsArr = reward.results
                API.nextURL = reward.next!
                self.tableView.reloadData()
            })
        }
        
        let currentCount = UIAlertAction(title: "펀딩액순", style: .default) { (action) in
            print("currentCount")
            self.rewards.sortedGetList(frame: self.view.frame, title: textArr[1], category: self.titlename!, completion: { (reward) in
                self.rewardsArr = reward.results
                API.nextURL = reward.next!
                self.tableView.reloadData()
            })
        }
        
        let endTime = UIAlertAction(title: "마감임박", style: .default) { (action) in
            print("endTime")
            self.rewards.sortedGetList(frame: self.view.frame, title: textArr[2], category: self.titlename!, completion: { (reward) in
                self.rewardsArr = reward.results
                API.nextURL = reward.next!
                self.tableView.reloadData()
            })
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
            print("cancel")
        }
        
        for alert in [interestedCount, currentCount, endTime, cancel] {
            alertContoller.addAction(alert)
        }
        present(alertContoller, animated: true)
    }
    
    func viewChange() {
        tableView.reloadData()
    }
}

