//
//  HeaderCellTableViewCell.swift
//  WadizProject
//
//  Created by Jo JANGHUI on 2018. 8. 7..
//  Copyright © 2018년 JhDAT. All rights reserved.
//

import UIKit



protocol HeaderCellTableViewCellDelegate: class {
    func viewChange()
    func actionSoringChange()
}

class HeaderCellTableViewCell: UITableViewCell {
    weak var delegate: HeaderCellTableViewCellDelegate?

    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var viewChangeButton: UIButton!
    @IBOutlet weak var popSortingViewButton: UIButton!
    
    let buttonTitle = ["최신순", "인기순", "펀딩액순", "마감임박순"]
    var sortingButtonArr: [UIButton] = []
    
    var popButtonSelected = true
    
    @IBAction func viewChangeButton(_ sender: UIButton) {
        if GrideView.shared.isShow {
            sender.setBackgroundImage(UIImage(named: "HeaderList"), for: .normal)
            GrideView.shared.isShow = false
            delegate?.viewChange()
        } else {
            sender.setBackgroundImage(UIImage(named: "HeaderGrid"), for: .normal)
            GrideView.shared.isShow = true
            delegate?.viewChange()
        }
    }
    
    @IBAction func popSortingmenu (_ sender: UIButton) {
        print("delegate popSortingmenu")
        delegate?.actionSoringChange()
        
//        popSortingViewButton.setTitle(title, for: .normal)
//        if popButtonSelected {
//            let popframe = popSortingViewButton.frame
//            UIView.animate(withDuration: 0.5) { [weak self] in
//                guard let strongSelf = self else { return }
//                for idx in 0..<strongSelf.sortingButtonArr.count {
//                    strongSelf.sortingButtonArr[idx].frame.size.width = popframe.width
//                    strongSelf.sortingButtonArr[idx].layoutIfNeeded()
//                }
//            }
//            popButtonSelected = false
//        } else {
//            for idx in 0..<sortingButtonArr.count {
//                sortingButtonArr[idx].frame.size.width = 0
//            }
//            popButtonSelected = true
//        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        if !GrideView.shared.isShow {
            viewChangeButton.setBackgroundImage(UIImage(named: "HeaderList"), for: .normal)
        } else {
            viewChangeButton.setBackgroundImage(UIImage(named: "HeaderGrid"), for: .normal)
        }
        
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.gray.cgColor
        
        popSortingViewButton.layer.borderColor = UIColor.gray.cgColor
        popSortingViewButton.layer.borderWidth = 1
        
//        for idx in 0..<buttonTitle.count {
//            addSortingButton(buttonTitle[idx], index: idx)
//        }
        
        
    }
    
    func test() {
        print("test")
    }
    
    func addSortingButton (_ name: String, index: Int) {
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
            button.heightAnchor.constraint(equalToConstant: 40).isActive = true
        default:
            let beforeButton = sortingButtonArr[index - 1]
            addSubview(button)
            button.translatesAutoresizingMaskIntoConstraints = false
            button.topAnchor.constraint(equalTo: beforeButton.bottomAnchor, constant: 0).isActive = true
            button.leadingAnchor.constraint(equalTo: beforeButton.leadingAnchor, constant: 0).isActive = true
            button.trailingAnchor.constraint(equalTo: button.leadingAnchor, constant: 0).isActive = true
            button.heightAnchor.constraint(equalTo: beforeButton.heightAnchor).isActive = true
        }
        sortingButtonArr.append(button)
    }
}
