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
    var alert: UIAlertController!
    var ok: UIAlertAction!
//    let ok = UIAlertAction(title: "확인", style: UIAlertActionStyle.default)
    
    
    let url = "https://ryanden.kr/api/users/signup/"
    
    var didTaskClosure: ((String, String) -> Void)? = nil
    
    
    @IBOutlet private weak var errorLabel: UILabel!
    
    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private weak var nameTextField: UITextField!
    @IBOutlet private weak var pwTextField: UITextField!
    @IBOutlet private weak var pwCheckTextField: UITextField!
    
    
    @IBAction func completeButton(_ sender: Any) {

        guard let username = emailTextField.text,
            let nickname = nameTextField.text,
            let password = pwTextField.text,
            let check_password = pwCheckTextField.text
            else { return }
        
        let params: Parameters = ["username": username,
                                  "password": password,
                                  "check_password": check_password,
                                  "nickname": nickname]
        
        Alamofire.request(url, method: .post, parameters: params)
            .validate(statusCode: 200..<400)
            .responseData { (response) in
                switch response.result {
                case .success(let value):
                self.alert.addAction(self.ok)
                self.present(self.alert, animated: false)
                case .failure(let error):
                    print(error.localizedDescription)
                }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: .UIKeyboardWillHide, object: nil)
        
        
        emailTextField.addTarget(self, action: #selector(didEndOnExit(_:)), for: UIControlEvents.editingDidEndOnExit)
        nameTextField.addTarget(self, action: #selector(didEndOnExit(_:)), for: UIControlEvents.editingDidEndOnExit)
        pwTextField.addTarget(self, action: #selector(didEndOnExit(_:)), for: UIControlEvents.editingDidEndOnExit)
        pwCheckTextField.addTarget(self, action: #selector(didEndOnExit(_:)), for: UIControlEvents.editingDidEndOnExit)
        
        alert = UIAlertController(title: "회원가입이 완료되었습니다.", message: "입력하신 이메일로 인증 메일을 발송했습니다. 이메일 인증 후 로그인해주세요." , preferredStyle: UIAlertControllerStyle.alert)
        
        ok = UIAlertAction(title: "확인", style: .default) { (action) in
            self.dismiss(animated: true, completion: nil)
//            let storyboard = UIStoryboard(name: "LoginView", bundle: nil)
//            let vc = storyboard.instantiateViewController(withIdentifier: "login")
//            self.navigationController?.present(<#T##viewControllerToPresent: UIViewController##UIViewController#>, animated: <#T##Bool#>, completion: <#T##(() -> Void)?##(() -> Void)?##() -> Void#>)
        }
        
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
    
}
