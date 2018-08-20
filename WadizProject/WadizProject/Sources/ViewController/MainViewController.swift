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
    @IBOutlet weak var mainTableView: UITableView!
    
    let rewards = PostService()
    
    var cellHeight: CGFloat?
    var menuView: UIView!
    var isMenuViewOn = false
    var MenuCGPoint = CGPoint()
    var rewardsArr: [Rewards.Results] = []
    var searchResults: [Rewards.Results]? {
        didSet {
            mainTableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        menuView = MenuView(frame: view.frame)
        view.addSubview(menuView)
        setNavigation()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        mainTableView.reloadData()
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
        searchResults = nil
        rewards.rewardGetList { [weak self] (reward) in
            guard let strongSelf = self else { return }
            strongSelf.rewardsArr = reward.results
            if reward.next == nil {
                API.nextURL = ""
            } else {
                API.nextURL = reward.next!
            }
            strongSelf.mainTableView.reloadData()
            let index = IndexPath.init(row: 0, section: 2)
            strongSelf.mainTableView.scrollToRow(at: index, at: .top, animated: true)
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
        print("actionRecommendButton")
        print(button.titleLabel?.text)
    }
}


// MARK:- UITableViewDataSource

extension MainViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int { return 3 }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 2 {
            if searchResults == nil {
            return rewardsArr.count
            } else {
                guard let search = searchResults?.count else { return 0}
                return search
            }
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
                rewardsCell.currentAmount.text = String(search[indexPath.row].currentAmountFormatter)
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
                rewardsGridCell.currentAmount.text = String(search[indexPath.row].currentAmountFormatter)
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
        
        let endCell = tableView.numberOfRows(inSection: 2)
        if indexPath.row == (endCell - 4) {
            rewards.nextRewardGetList { [weak self] (reward) in
                guard let strongSelf = self else { return }
                strongSelf.rewardsArr += reward.results
                guard let nextURL = reward.next else {strongSelf.mainTableView.reloadData(); return }
                API.nextURL = nextURL
                strongSelf.mainTableView.reloadData()
                //TODO: - 6번째 로드시 post err 발생 (원인찾기)
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
        rewards.detailGetList(pk: rewardsArr[indexPath.row].pk) { (detail) in
            detailView.detailData = detail
            self.navigationController?.pushViewController(detailView, animated: true)
        }
    }
}

// MARK:- UITextFieldDelegate

extension MainViewController: UITextFieldDelegate{
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


// MARK: - CategorybuttonDelegate

extension MainViewController: CategorybuttonDelegate {
    func presentView(_ title: String) {

        switch title {
        case "전체보기":
            searchResults = nil
            rewards.rewardGetList { [weak self] (reward) in
                guard let strongSelf = self else { return }
                strongSelf.rewardsArr = reward.results
                if reward.next == nil {
                    API.nextURL = ""
                } else {
                    API.nextURL = reward.next!
                }
                strongSelf.mainTableView.reloadData()
            }
            
        default:
            let category = self.storyboard?.instantiateViewController(withIdentifier: "CategoryView") as! CategoryViewController
            rewards.categoryGetList(frame: view.frame, title: title) { [weak self] (reward) in
                guard let strongSelf = self else { return }
                category.titlename = title
                category.rewardsArr = reward.results
                if reward.next == nil {
                    API.nextURL = ""
                } else {
                    API.nextURL = reward.next!
                }
                strongSelf.navigationController?.pushViewController(category, animated: true)
            }
        }
    }
}

// MARK: - HeaderCellTableViewCellDelegate

extension MainViewController: HeaderCellTableViewCellDelegate {
    
    func actionSoringChange() {
        let textArr = ["-product_start_time", "-product_interested_count", "-product_cur_amount", "product_end_time"]
        
        let alertContoller = UIAlertController(title: "정렬", message: nil, preferredStyle: UIAlertControllerStyle.actionSheet)
        
        let startTime = UIAlertAction(title: "최신순", style: .default) { (action) in
            print("endTime")
            self.rewards.sortedGetList(frame: self.view.frame, title: textArr[0], category: "", completion: { (reward) in
                self.rewardsArr = reward.results
                API.nextURL = reward.next!
                self.mainTableView.reloadData()
            })
        }
        
        let interestedCount = UIAlertAction(title: "인기순", style: .default) { (action) in
            self.rewards.sortedGetList(frame: self.view.frame, title: textArr[1], category: "", completion: { (reward) in
                self.rewardsArr = reward.results
                API.nextURL = reward.next!
                self.mainTableView.reloadData()
            })
        }
        
        let currentCount = UIAlertAction(title: "펀딩액순", style: .default) { (action) in
            print("currentCount")
            self.rewards.sortedGetList(frame: self.view.frame, title: textArr[2], category: "", completion: { (reward) in
                self.rewardsArr = reward.results
                API.nextURL = reward.next!
                self.mainTableView.reloadData()
            })
        }
        
        let endTime = UIAlertAction(title: "마감순", style: .default) { (action) in
            print("endTime")
            self.rewards.sortedGetList(frame: self.view.frame, title: textArr[3], category: "", completion: { (reward) in
                self.rewardsArr = reward.results
                API.nextURL = reward.next!
                self.mainTableView.reloadData()
            })
        }
        
       
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
            print("cancel")
        }
        
        for alert in [startTime, interestedCount, currentCount, endTime, cancel] {
            alertContoller.addAction(alert)
        }
        present(alertContoller, animated: true)
        
    }
    func viewChange() {
        mainTableView.reloadData()
    }
}


