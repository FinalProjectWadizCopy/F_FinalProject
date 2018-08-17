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
    
    let symbolColor = UIColor(red: 0.451, green: 0.796, blue: 0.639, alpha: 1)
    var cellHeight: CGFloat?
    var menuView: UIView!
    var isMenuViewOn = false
    var MenuCGPoint = CGPoint()
    
    let rewards = PostService()
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
        titleView.textColor = symbolColor
        titleView.text = "Wadiz"
        titleView.font = UIFont.boldSystemFont(ofSize: 20)
        navigationItem.titleView = titleView
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
                button.frame.size.height = view.frame.height / 4
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
        
        // TODO: - 통신 미구현 프로퍼티
        //        let dayFinish = UILabel()           // 프로젝트 마감 임박 표시 레이블  // 나중에
        //        let totalPercent = UILabel()        // 프로젝트 달성 %              // 나중에
        //        let dayLeft = UILabel()             // 프로젝트 남은 일
        //        let progress = UIProgressView()     // 프로젝트 목표금액
        
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
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        tableView.rowHeight = 0
        
        let endCell = tableView.numberOfRows(inSection: 2)
        if indexPath.row == (endCell - 2) {
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
            return 40
        }
        return 0
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
            mainTableView.reloadData()
        default:
            print("default")
            let category = self.storyboard?.instantiateViewController(withIdentifier: "CategoryView") as! CategoryViewController
            rewards.categoryGetList(frame: view.frame, title: title) { [weak self] (reward) in
                guard let strongSelf = self else { return }
                category.rewardsArr = reward.results
                strongSelf.navigationController?.pushViewController(category, animated: true)
            }
        }
    }
}

// MARK: - HeaderCellTableViewCellDelegate

extension MainViewController: HeaderCellTableViewCellDelegate {
    func viewChange() {
        mainTableView.reloadData()
    }
}


