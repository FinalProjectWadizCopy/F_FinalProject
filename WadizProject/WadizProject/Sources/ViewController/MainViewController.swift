//
//  MainViewController.swift
//  WadizProject
//
//  Created by Jo JANGHUI on 2018. 7. 31..
//  Copyright © 2018년 JhDAT. All rights reserved.
//

import UIKit
import Kingfisher

class MainViewController: UIViewController {
    
    @IBOutlet weak var leftNaviButton: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
    
    let rewards = PostService()
    
    var cellHeight: CGFloat?
    var menuView: UIView!
    var isMenuViewOn = false
    var MenuCGPoint = CGPoint()
    var rewardsResults: [Rewards.Results] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        menuView = MenuView(frame: view.frame)
        view.addSubview(menuView)
        setNavigation()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    func setNavigation() {
        let titleView = UILabel()
        titleView.textColor = Color.shared.symbolColor
        titleView.text = "Wadiz"
        titleView.font = UIFont.boldSystemFont(ofSize: 20)
        navigationItem.titleView = titleView
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "뒤로가기",
                                                           style: UIBarButtonItemStyle.plain,
                                                           target: nil, action: nil)
        
        navigationItem.backBarButtonItem?.tintColor = Color.shared.symbolColor
        
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(naviTitleTouch))
        titleView.isUserInteractionEnabled = true
        titleView.addGestureRecognizer(recognizer)
    }
    
    @objc func naviTitleTouch() {
        rewards.rewardGetList { [weak self] (reward) in
            guard let strongSelf = self else { return }
            strongSelf.rewardsResults = reward.results
            if reward.next == nil {
                API.nextURL = ""
            } else {
                API.nextURL = reward.next!
            }
            strongSelf.tableView.reloadData()
        }
    }
    
    // MARK: - IBAction
    @IBAction func presentMenuView() {
        let moveLagnth = self.view.frame.width
        
        if !isMenuViewOn {
            UIView.animate(withDuration: 0.3) { [weak self] in
                guard let strongSelf = self else { return }
                strongSelf.menuView.frame.origin.x += moveLagnth
                strongSelf.leftNaviButton.image = UIImage(named: "exit")
                strongSelf.view.layoutIfNeeded()
            }
            isMenuViewOn = true
        } else {
            UIView.animate(withDuration: 0.3) { [weak self] in
                guard let strongSelf = self else { return }
                strongSelf.menuView.frame.origin.x -= moveLagnth
                strongSelf.leftNaviButton.image = UIImage(named: "menu")
                strongSelf.view.layoutIfNeeded()
            }
            isMenuViewOn = false
        }
    }
    
    @objc func actionRecommendButton (_ button: UIButton) {
        print(button.titleLabel?.text)
    }
    
    func checkNextURL(_ next: String?) {
        if next == nil {
            API.nextURL = ""
        } else {
            API.nextURL = next!
        }
    }
}


// MARK:- UITableViewDataSource

extension MainViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int { return 3 }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 2 {
            return rewardsResults.count
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.separatorStyle = .none
        if indexPath.section == 0 {
            RecommendTableViewCell.viewFrame = view.frame
            let recommendCell = tableView.dequeueReusableCell(
                withIdentifier: "RecommendTableViewCell",
                for: indexPath) as! RecommendTableViewCell
            recommendCell.buttonArr.forEach { (button) in
                button.frame.size.height = view.frame.height / 3
                button.addTarget(self, action: #selector(actionRecommendButton), for: .touchUpInside)
            }
            tableView.rowHeight = recommendCell.buttonArr[indexPath.row].frame.size.height
            return recommendCell
        }
        else if indexPath.section == 1 {
            let categoryCell = tableView.dequeueReusableCell(
                withIdentifier: "CategoryTableViewCell",
                for: indexPath) as! CategoryTableViewCell
            tableView.rowHeight = view.frame.height / 6
            categoryCell.delegate = self
            return categoryCell
        }
        
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
        let endCell = tableView.numberOfRows(inSection: 2)
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
        if section == 2 {
            tableView.register(UINib(nibName: "HeaderCellTableViewCell", bundle: nil), forCellReuseIdentifier: "HeaderCellTableViewCell")
            let  header = tableView.dequeueReusableCell(withIdentifier: "HeaderCellTableViewCell") as! HeaderCellTableViewCell
            header.searchTextField.delegate = self as UITextFieldDelegate
            header.delegate = self
            return header
        }
        return nil
    }
    
}

// MARK:- UITableViewDelegate

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 2 {
            return 45
        }
        return 0
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
extension MainViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let text = textField.text else { return  true }
        rewards.rewardsSearchGetList(frame: view.frame, text: text){ [weak self] (reward) in
            guard let strongSelf = self else { return }
            strongSelf.rewardsResults = []
            strongSelf.rewardsResults = reward.results
            strongSelf.checkNextURL(reward.next)
            if strongSelf.rewardsResults.isEmpty {
                strongSelf.searchEmptyAlert()
            }
            strongSelf.tableView.reloadData()
        }
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        let index = IndexPath.init(row: 0, section: 2)
        self.tableView.scrollToRow(at: index, at: .middle, animated: false)
        return true
    }
    
    func searchEmptyAlert() {
        let alertController = UIAlertController(title: "검색 결과가 없습니다.", message:  nil, preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ok", style: .default) { [weak self] (action) in
            guard let strongSelf = self else { return }
            strongSelf.rewards.rewardGetList { (reward) in
                strongSelf.rewardsResults = reward.results
                strongSelf.checkNextURL(reward.next)
                strongSelf.tableView.reloadData()
            }
        }
        alertController.addAction(ok)
        present(alertController, animated: true)
    }
}


// MARK: - CategorybuttonDelegate
extension MainViewController: CategorybuttonDelegate {
    func presentView(_ title: String) {
        
        switch title {
        case "전체보기":
            rewards.rewardGetList { [weak self] (reward) in
                guard let strongSelf = self else { return }
                strongSelf.rewardsResults = reward.results
                strongSelf.checkNextURL(reward.next)
                strongSelf.tableView.reloadData()
            }
            
        default:
            let category = self.storyboard?.instantiateViewController(withIdentifier: "CategoryView") as! CategoryViewController
            rewards.categoryGetList(frame: view.frame, title: title) { [weak self] (reward) in
                guard let strongSelf = self else { return }
                category.titlename = title
                category.rewardsResults = reward.results
                strongSelf.checkNextURL(reward.next)
                strongSelf.navigationController?.pushViewController(category, animated: true)
            }
        }
    }
}

// MARK: - HeaderCellTableViewCellDelegate
extension MainViewController: HeaderCellTableViewCellDelegate {
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


