//
//  HeaderCellTableViewCell.swift
//  WadizProject
//
//  Created by Jo JANGHUI on 2018. 8. 7..
//  Copyright © 2018년 JhDAT. All rights reserved.
//

import UIKit


class HeaderCellTableViewCell: UITableViewCell {

    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var viewChangeButton: UIButton!
    @IBOutlet weak var popSortingViewButton: UIButton!
    
    let buttonNameArr = ["인기순", "추천순", "펀딩액순", "마감임박순", "최신순"]
    var soringButtonArr: [UIButton] = []
    
    var sortingButton: UIButton!
    var buttonSelected = true
    
    
    @IBAction func popSortingmenu (_ sender: UIButton) {
        if buttonSelected {
            let popframe = popSortingViewButton.frame
            UIView.animate(withDuration: 1) { [weak self] in
                guard let strongSelf = self else { return }
                for idx in 0..<strongSelf.soringButtonArr.count {
                    strongSelf.soringButtonArr[idx].frame.size.width = popframe.width
                    strongSelf.soringButtonArr[idx].layoutIfNeeded()
                }
            }
            
            buttonSelected = false
        } else {
            for idx in 0..<soringButtonArr.count {
                soringButtonArr[idx].frame.size.width = 0
            }
            
            buttonSelected = true
        }
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.gray.cgColor
        
        popSortingViewButton.layer.borderColor = UIColor.gray.cgColor
        popSortingViewButton.layer.borderWidth = 1
        
        for idx in 0..<buttonNameArr.count {
            addSortingMenubutton(buttonNameArr[idx], index: idx)
        }
        
    }

    func addSortingMenubutton (_ name: String, index: Int) {
        let button = UIButton()
        button.frame.size = CGSize(width: 0, height: popSortingViewButton.frame.height)
        button.backgroundColor = UIColor.white
        button.layer.borderColor = UIColor.gray.cgColor
        button.layer.borderWidth = 0.5
        button.setTitle(name, for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.titleLabel?.font = popSortingViewButton.titleLabel?.font
        switch index {
        case 0:
            addSubview(button)
            button.translatesAutoresizingMaskIntoConstraints = false
            button.topAnchor.constraint(equalTo: popSortingViewButton.bottomAnchor, constant: 0).isActive = true
            button.leadingAnchor.constraint(equalTo: popSortingViewButton.leadingAnchor, constant: 0).isActive = true
            button.trailingAnchor.constraint(equalTo: button.leadingAnchor, constant: 0).isActive = true
        default:
            let beforeButton = soringButtonArr[index - 1]
            addSubview(button)
            button.translatesAutoresizingMaskIntoConstraints = false
            button.topAnchor.constraint(equalTo: beforeButton.bottomAnchor, constant: 0).isActive = true
            button.leadingAnchor.constraint(equalTo: beforeButton.leadingAnchor, constant: 0).isActive = true
            button.trailingAnchor.constraint(equalTo: button.leadingAnchor, constant: 0).isActive = true
        }
        soringButtonArr.append(button)
    }
    
}
