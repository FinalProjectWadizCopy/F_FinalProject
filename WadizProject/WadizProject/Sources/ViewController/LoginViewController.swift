//
//  LoginViewController.swift
//  
//
//  Created by Pure Yun on 2018. 7. 31..
//

import UIKit

import FBSDKCoreKit
import FBSDKLoginKit

import Alamofire


struct GetToken: Decodable {
    let token: String?
    let detail: String?
}


class LoginViewController: UIViewController, FBSDKLoginButtonDelegate {
    
    let url = "https://ryanden.kr/api/users/signin/"

    let alertController = UIAlertController(title: "로그인 성공", message: "대한민국 No.1 크라우드 펀딩 Wadiz", preferredStyle: .alert)
    var okAction: UIAlertAction!
    
    let alertController2 = UIAlertController(title: "로그인 실패", message: "아이디나 비밀번호가 일치하지 않습니다.\n다시 입력해주세요", preferredStyle: .alert)
    let okAction2 = UIAlertAction(title: "확인", style: .destructive, handler: { (alert) in })
    
    
    
    
    
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var pwTextField: UITextField!
    
    @IBOutlet weak var errorLabel: UILabel!

    
    @IBAction func loginButton(_sender: UIButton) {
    
        guard let username = idTextField.text,
              let password = pwTextField.text
        else { return }
        
        let params: Parameters = ["username": username, "password": password]
        
        Alamofire.request(url, method: .post, parameters: params)
            .validate(statusCode: 200..<300)
            .responseData { (response) in
                switch response.result {
                case .success(let value):
                    do {
                        let token = try JSONDecoder().decode(GetToken.self, from: value)
                        UserDefaults.standard.set(token.token, forKey: "token")
                        self.alertController.addAction(self.okAction)
                        self.present(self.alertController, animated: false)
                    } catch {
                        print("parsing err")
                    }
                case .failure(let error):
                    
                    self.alertController2.addAction(self.okAction2)
                    self.present(self.alertController2, animated: false)
                    
                    print(error)
                }
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        okAction = UIAlertAction(title: "확인", style: .destructive, handler: { (alert) in
            
        })
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: .UIKeyboardWillHide, object: nil)
        
        idTextField.addTarget(self, action: #selector(didEndOnExit(_:)), for: UIControlEvents.editingDidEndOnExit)
        pwTextField.addTarget(self, action: #selector(didEndOnExit(_:)), for: UIControlEvents.editingDidEndOnExit)

        
      let fbLoginButton = FBSDKLoginButton()
        fbLoginButton.center = self.view.center
        fbLoginButton.frame = CGRect(x: 10, y: 430, width: 355, height: 45)
        fbLoginButton.readPermissions = ["public_profile", "email"]
        fbLoginButton.delegate = self
        
        self.view.addSubview(fbLoginButton)
    }
    
    @objc func keyboardWillShow(_ sender: Notification) {
        self.view.frame.origin.y = -150
    }
    @objc func keyboardWillHide(_ sender: Notification) {
        self.view.frame.origin.y = 0
    }
    
    //엔터 누를 시 다음 입력 칸으로 가기위한 함수
    @objc func didEndOnExit(_ sender: UITextField) {
        if sender.tag == 1 {
            pwTextField.becomeFirstResponder()
        }
    }

    
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
    
    }

    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
    
    }
}



