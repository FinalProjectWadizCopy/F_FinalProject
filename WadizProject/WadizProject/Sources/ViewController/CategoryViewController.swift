//
//  CategoryViewController.swift
//  WadizProject
//
//  Created by Jo JANGHUI on 2018. 8. 7..
//  Copyright © 2018년 JhDAT. All rights reserved.
//

import UIKit

class CategoryViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var index: Int?

    override func viewDidLoad() {
        super.viewDidLoad()
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
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let rewardsTablecell
            = tableView.dequeueReusableCell(
                withIdentifier: "RewardsTableViewCell",
                for: indexPath) as! RewardsTableViewCell
        
        rewardsTablecell.rewardCollectionView.reloadData()
        
        guard let heightArr = rewardsTablecell.cellHegiht else { return rewardsTablecell }
        if GrideView.shared.isShow {
            tableView.rowHeight = heightArr[0] * 11
        } else {
            tableView.rowHeight = heightArr[1] * 11
        }
        return rewardsTablecell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        tableView.register(UINib(nibName: "HeaderCellTableViewCell", bundle: nil), forCellReuseIdentifier: "HeaderCellTableViewCell")
        let  header = tableView.dequeueReusableCell(withIdentifier: "HeaderCellTableViewCell") as! HeaderCellTableViewCell
        header.searchTextField.delegate = self as UITextFieldDelegate
        header.delegate = self as HeaderCellTableViewCellDelegate
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
        textField.resignFirstResponder()
        tableView.reloadData()
        return true
    }
}

// MARK: - HeaderCellTableViewCellDelegate

extension CategoryViewController: HeaderCellTableViewCellDelegate {
    func viewChange() {
        print("tableView.reloadData()")
        tableView.reloadData()
    }
}

