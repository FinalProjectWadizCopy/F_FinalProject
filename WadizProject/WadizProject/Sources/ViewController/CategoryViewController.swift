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
    var rewardsResults: [Rewards.Results] = []
    var searchResults: [Rewards.Results]? {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleSetup()
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.isHidden = false
        
        if rewardsResults.isEmpty {
            tableView.isHidden = true
            let empty = EmptyView(frame: view.frame)
            view.addSubview(empty)
        }
    }
    
    func titleSetup () {
        let title = UILabel()
        title.textColor = Color.shared.symbolColor
        title.text = titlename
        title.font = UIFont.boldSystemFont(ofSize: 20)
        navigationItem.titleView = title
    }
    
    func checkNextURL(_ next: String?) {
        if next == nil {
            API.nextURL = ""
        } else {
            API.nextURL = next!
        }
    }
}

extension CategoryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rewardsResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.separatorStyle = .none
        if GrideView.shared.isShow {
            let rewardsCell
                = tableView.dequeueReusableCell(
                    withIdentifier: "RewardsCell",
                    for: indexPath) as! RewardsTableViewCell
            tableView.rowHeight = rewardsCell.rowHeight
            rewardsCell.totalPercent.textColor = Color.shared.symbolColor
            
            let url = URL(string: rewardsResults[indexPath.row].productImg)
            rewardsCell.productImg.kf.setImage(with: url)
            rewardsCell.productName.text = rewardsResults[indexPath.row].productName
            rewardsCell.type.text = rewardsResults[indexPath.row].type
            rewardsCell.companyName.text = "| " + rewardsResults[indexPath.row].companyName
            rewardsCell.currentAmount.text = rewardsResults[indexPath.row].currentAmountFormatter
            rewardsCell.dayLeft.text = rewardsResults[indexPath.row].remainingDay
            rewardsCell.totalPercent.text = String(rewardsResults[indexPath.row].totalPercent)
            rewardsCell.progress.progress = rewardsResults[indexPath.row].progress
            rewardsCell.selectionStyle = UITableViewCellSelectionStyle.none
            switch rewardsResults[indexPath.row].isFinish {
            case "err":
                rewardsCell.dayFinish.isHidden = true
            case "통과":
                rewardsCell.dayFinish.isHidden = true
            default:
                rewardsCell.dayFinish.isHidden = false
                rewardsCell.dayFinish.text = rewardsResults[indexPath.row].isFinish
            }
            return rewardsCell
        } else {
            let rewardsGridCell
                = tableView.dequeueReusableCell(
                    withIdentifier: "RewardsGridCell",
                    for: indexPath) as! RewardsGridTableViewCell
            tableView.rowHeight = rewardsGridCell.rowHeight
            rewardsGridCell.totalPercent.textColor = Color.shared.symbolColor
            let url = URL(string: rewardsResults[indexPath.row].productImg)
            rewardsGridCell.productImg.kf.setImage(with: url)
            rewardsGridCell.productName.text = rewardsResults[indexPath.row].productName
            rewardsGridCell.type.text = rewardsResults[indexPath.row].type
            rewardsGridCell.companyName.text = "| " + rewardsResults[indexPath.row].companyName
            rewardsGridCell.currentAmount.text = rewardsResults[indexPath.row].currentAmountFormatter
            rewardsGridCell.dayLeft.text = rewardsResults[indexPath.row].remainingDay
            rewardsGridCell.totalPercent.text = String(rewardsResults[indexPath.row].totalPercent)
            rewardsGridCell.progress.progress = rewardsResults[indexPath.row].progress
            rewardsGridCell.selectionStyle = UITableViewCellSelectionStyle.none
            switch rewardsResults[indexPath.row].isFinish {
            case "err":
                rewardsGridCell.dayFinish.isHidden = true
            case "통과":
                rewardsGridCell.dayFinish.isHidden = true
            default:
                rewardsGridCell.dayFinish.isHidden = false
                rewardsGridCell.dayFinish.text = rewardsResults[indexPath.row].isFinish
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
                strongSelf.rewardsResults += reward.results
                strongSelf.checkNextURL(reward.next)
                strongSelf.tableView.reloadData()
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailView = self.storyboard?.instantiateViewController(withIdentifier: "DetailView") as! DetailViewController
        rewards.detailGetList(pk: rewardsResults[indexPath.row].pk) { (detail) in
            detailView.detailData = detail
            self.navigationController?.pushViewController(detailView, animated: true)
        }
    }
}

// MARK:- UITextFieldDelegate
extension CategoryViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let text = textField.text else { return  true }
        rewards.rewardsSearchGetList(frame: view.frame, text: text){ [weak self] (reward) in
            guard let strongSelf = self else { return }
            strongSelf.rewardsResults = []
            strongSelf.rewardsResults = reward.results
            strongSelf.checkNextURL(reward.next)
            strongSelf.tableView.reloadData()
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
    
    func actionSoringChange() {
        let textArr = ["-product_start_time",
                       "-product_interested_count",
                       "-product_cur_amount",
                       "product_end_time"]
        
        let alertContoller = UIAlertController(title: "정렬",
                                               message: nil,
                                               preferredStyle: UIAlertControllerStyle.actionSheet)
        
        let startTime = UIAlertAction(title: "최신순", style: .default) { [weak self] (action) in
            guard let strongSelf = self else { return }
            strongSelf.rewards.sortedGetList(frame: strongSelf.view.frame,
                                             title: textArr[0],
                                             category: "",
                                             completion: { (reward) in
                                                strongSelf.rewardsResults = reward.results
                                                strongSelf.checkNextURL(reward.next)
                                                strongSelf.tableView.reloadData()
            })
        }
        
        let interestedCount = UIAlertAction(title: "인기순", style: .default) { [weak self] (action) in
            guard let strongSelf = self else { return }
            strongSelf.rewards.sortedGetList(frame: strongSelf.view.frame,
                                             title: textArr[1],
                                             category: "",
                                             completion: { (reward) in
                                                strongSelf.rewardsResults = reward.results
                                                strongSelf.checkNextURL(reward.next)
                                                strongSelf.tableView.reloadData()
            })
        }
        
        let currentCount = UIAlertAction(title: "펀딩액순", style: .default) { [weak self] (action) in
            guard let strongSelf = self else { return }
            strongSelf.rewards.sortedGetList(frame: strongSelf.view.frame,
                                             title: textArr[2],
                                             category: "",
                                             completion: { (reward) in
                                                strongSelf.rewardsResults = reward.results
                                                strongSelf.checkNextURL(reward.next)
                                                strongSelf.tableView.reloadData()
            })
        }
        
        let endTime = UIAlertAction(title: "마감순", style: .default) { [weak self] (action) in
            guard let strongSelf = self else { return }
            strongSelf.rewards.sortedGetList(frame: strongSelf.view.frame,
                                             title: textArr[3],
                                             category: "",
                                             completion: { (reward) in
                                                strongSelf.rewardsResults = reward.results
                                                strongSelf.checkNextURL(reward.next)
                                                strongSelf.tableView.reloadData()
            })
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel) { (action) in }
        
        for alert in [startTime, interestedCount, currentCount, endTime, cancel] {
            alertContoller.addAction(alert)
        }
        
        present(alertContoller, animated: true)
    }
}
