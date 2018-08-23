//
//  RegisterViewController.swift
//  WadizProject
//
//  Created by Pure Yun on 2018. 8. 8..
//  Copyright © 2018년 JhDAT. All rights reserved.
//

import UIKit

import Alamofire

class RegisterViewController: UIViewController, UITextFieldDelegate {
    
    
    let alert = UIAlertController(title: "회원가입이 완료되었습니다.", message: "입력하신 이메일로 인증 메일을 발송했습니다. 이메일 인증 후 로그인해주세요.", preferredStyle: UIAlertControllerStyle.alert)
    let ok = UIAlertAction(title: "확인", style: UIAlertActionStyle.default)
    
    
    let url = "https://ryanden.kr/api/users/signup/"
    
    var didTaskClosure: ((String, String) -> Void)? = nil
    
    
    @IBOutlet private weak var errorLabel: UILabel!
    
    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private weak var nameTextField: UITextField!
    @IBOutlet private weak var pwTextField: UITextField!
    @IBOutlet private weak var pwCheckTextField: UITextField!
    
    
    @IBAction func completeButton(_ sender: Any) {
        
        alert.addAction(ok)

        self.present(alert, animated: false)
    
        
        guard let username = emailTextField.text,
              let nickname = nameTextField.text,
              let password = pwTextField.text,
              let check_password = pwCheckTextField.text
        else { return }
        
        let params: Parameters = ["username": username,
                                  "password": password,
                                  "check_password": check_password,
                                  "nickname": nickname]
        
//        let storyboard = UIStoryboard(name: "login", bundle: nil)
//        let mainNavi = storyboard.instantiateViewController(withIdentifier: "login")
        
        Alamofire.request(url, method: .post, parameters: params)
            .validate(statusCode: 200..<400)
            .responseData { (response) in
                switch response.result {
                case .success(let value):
                    print("successed : ",value)

                case .failure(let error):
                    print(error)
                }
        }
    }


//        guard let email = emailTextField.text else {
//            return
//        }
//        guard let name = nameTextField.text else {
//            return
//        }
//        guard let pw = pwTextField.text else {
//            return
//        }
//        guard let pwCheck = pwCheckTextField.text else {
//            return
//        }
//        if pw == pwCheck {
//            emailTextField.text = ""
//            nameTextField.text = ""
//            pwTextField.text = ""
//            pwCheckTextField.text = ""
//            print("Sign Up Success")
//
//            let userData: [String: String] = ["이메일": email, "이름": name, "비밀번호": pw]
//            let list: [[String: String]] = [userData]
//
//            UserDefaults.standard.set(list, forKey: "userList")
//
//            dismiss(animated: true, completion: nil)
//
//        } else {
//            //중복, 잘못 입력시 애니메이션
//            UIView.animate(withDuration: 0.15, animations: {
//                self.emailTextField.frame.origin.x -= 10
//                self.nameTextField.frame.origin.x -= 10
//                self.pwTextField.frame.origin.x -= 10
//                self.pwCheckTextField.frame.origin.x -= 10
//                self.emailTextField.backgroundColor = UIColor.red.withAlphaComponent(0.2)
//                self.nameTextField.backgroundColor = UIColor.red.withAlphaComponent(0.2)
//                self.pwTextField.backgroundColor = UIColor.red.withAlphaComponent(0.2)
//                self.pwCheckTextField.backgroundColor = UIColor.red.withAlphaComponent(0.2)
//            }, completion: { _ in
//                UIView.animate(withDuration: 0.15, animations: {
//                    self.emailTextField.frame.origin.x += 20
//                    self.nameTextField.frame.origin.x += 20
//                    self.pwTextField.frame.origin.x += 20
//                    self.pwCheckTextField.frame.origin.x += 20
//                }, completion: { _ in
//                    UIView.animate(withDuration: 0.15, animations: {
//                        self.emailTextField.frame.origin.x -= 10
//                        self.nameTextField.frame.origin.x -= 10
//                        self.pwTextField.frame.origin.x -= 10
//                        self.pwCheckTextField.frame.origin.x -= 10
//                        self.emailTextField.backgroundColor = UIColor.white
//                        self.nameTextField.backgroundColor = UIColor.white
//                        self.pwTextField.backgroundColor = UIColor.white
//                        self.pwCheckTextField.backgroundColor = UIColor.white
//                    })
//                })
//            })
//        }

    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: .UIKeyboardWillHide, object: nil)


        emailTextField.addTarget(self, action: #selector(didEndOnExit(_:)), for: UIControlEvents.editingDidEndOnExit)
        nameTextField.addTarget(self, action: #selector(didEndOnExit(_:)), for: UIControlEvents.editingDidEndOnExit)
        pwTextField.addTarget(self, action: #selector(didEndOnExit(_:)), for: UIControlEvents.editingDidEndOnExit)
        pwCheckTextField.addTarget(self, action: #selector(didEndOnExit(_:)), for: UIControlEvents.editingDidEndOnExit)

    }

    @objc func keyboardWillShow(_ sender: Notification) {
        self.view.frame.origin.y = -150
    }
    @objc func keyboardWillHide(_ sender: Notification) {
        self.view.frame.origin.y = 0
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    @objc func didEndOnExit(_ sender: UITextField) {
    if sender.tag == 1 {
        pwTextField.becomeFirstResponder()
    } else if sender.tag == 2 {
        pwCheckTextField.becomeFirstResponder()
    }
}


//        guard let email = emailTextField.text, emailTextField.text?.characters.count != 0 else {
//            emailTextField.isHidden = false
//            errorLabel.text = "이메일을 입력해주세요"
//            return
//        }
//        if validEmail(email: email) == false {
//            errorLabel.isHidden = false
//            errorLabel.text = "이메일 양식에 맞게 입력해주세요"
//        }
//        guard let name = nameTextField.text, nameTextField.text?.characters.count != 0 else {
//            nameTextField.isHidden = false
//            errorLabel.text = "이름을 입력해주세요"
//            return
//        }
//        guard let pw = pwTextField.text, pwTextField.text?.characters.count != 0 else {
//            pwTextField.isHidden = false
//            errorLabel.text = "비밀번호를 입력해주세요"
//            return
//        }
////        if validPassword(pwd: pw) == false {
////            errorLabel.isHidden = false
////            errorLabel.text = "영문, 숫자, 특수문자(!@#$%^&*+=-)를 조합한 8자 이상으로 입력해주세요"
////        }
//        guard let pwCheck = pwCheckTextField.text, pwCheckTextField.text?.characters.count != 0 else {
//            pwCheckTextField.isHidden = false
//            errorLabel.text = "비밀번호를 다시 입력해주세요"
//            return
//        }
//

//    func validEmail(email: String) -> Bool {
//    func validEmail(email: String, id: String){
//        let emailRegEx = "[A-Z0-9a-z.&+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
//        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
//        if emailTest.evaluate(with: email) {
//            errorLabel.text = ""
//
//        } else {
//            errorLabel.isHidden = false
//            errorLabel.text = "이메일 양식에 맞게 입력해주세요"
//        }
//
////        return emailTest.evaluate(with: email)
//    }
//
//    func validPassword(pwd: String, id: String){
//        let passwordRegEx = "^(?=.*[A-Z])(?=.*[0-9])(?=.*[a-z]).{8}"
//        let passwordTest = NSPredicate(format: "SELF MATCHES %@", passwordRegEx)
//
//        if passwordTest.evaluate(with: pwd) {
//            errorLabel.text = ""
//
//        } else {
//            errorLabel.isHidden = false
//            errorLabel.text = "영문, 숫자, 특수문자(!@#$%^&*+=-)를 조합한 8자 이상으로 입력해주세요"
//        }
//
////        return passwordTest.evaluate(with: pwd)
//    }






//
//extension RegisterViewController: UITextFieldDelegate {
//    func textFieldDidEndEditing(_ textField: UITextField) {
//        guard let textidentifier = textField.restorationIdentifier,
//        let text = textField.text else { return }
//        validEmail(email: text, id: textidentifier)
//
//                }
//}
}
