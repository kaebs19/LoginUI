//
//  ViewController.swift
//  LoginUI
//
//  Created by mjeed on 15/09/2023.
//

import UIKit
import FBSDKLoginKit



class LoginViewController: UITableViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var facebookLogin: FBLoginButton!
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // function end keyboard
        dismissKeyboard()
        
        if let token = AccessToken.current,
            !token.isExpired {
            // User is logged in, do work such as go to next view controller.
        } else {
            facebookLogin.permissions = ["public_profile", "email"]
            facebookLogin.delegate = self

        }

        
        
    }
    
    
    // MARK: -  Configure Action - Func
    
    @IBAction func facebookButtonPressed(_ sender: UIButton) {
        ValidationCode()
        
    }

    
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        ValidationCode()
        
    }
    
    
    @IBAction func signInButtonPressed(_ sender: UIButton) {
        guard let vc = self.storyboard?.instantiateViewController(identifier: "SiginViewController") else {return}
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
    
    // validation email and password
    fileprivate func ValidationCode() {
        if let email = emailTextField.text , let password = passwordTextField.text {
            if !email.validateEmailId() {
                openAlert(title: "Alert", message: "Email address not found", alertStyle: .alert, actionTitles: ["OK"], actionStyles: [.default], actions: [{_ in
                    print("Done pressed")
                }])
            } else if !password.validatePassword() {
                openAlert(title: "Alert", message: "please enter valid password", alertStyle: .alert, actionTitles: ["OK"], actionStyles: [.default], actions: [{_ in
                    
                    print("The password is right")
                }])
            } else {
                // GO to view home ->
                
            }
            
        } else {
            openAlert(title: "Alert", message: "Please add details", alertStyle: .alert, actionTitles: ["OK"], actionStyles: [.default], actions: [{_ in
                
                print("Done pressed")
                
            }])
            
        }
    }
}

// MARK: -  TableView Delegate & DataSource
extension LoginViewController {
    
    // center table view in viewContloer
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let tableViewHeight = self.tableView.frame.height
        let contentHeight = self.tableView.contentSize.height
        
        let centeringInset = (tableViewHeight - contentHeight) / 2.0
        let topInset = max(centeringInset, 0.0)
        
        self.tableView.contentInset = UIEdgeInsets(top: topInset, left: 0.0, bottom: 0.0, right: 0.0)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.height
    }
    
}


extension LoginViewController: LoginButtonDelegate {
    
    
    func loginButton(_ loginButton: FBSDKLoginKit.FBLoginButton, didCompleteWith result: FBSDKLoginKit.LoginManagerLoginResult?, error: Error?) {
        let token = result?.token?.tokenString
        let requset = FBSDKLoginKit.GraphRequest(graphPath: "me", parameters: ["fields":"email , name"] , tokenString: token , version: nil , httpMethod: .get)
        
        requset.start { connection, result, error in
            print(result)
        }
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginKit.FBLoginButton) {
        print("logout")
    }
    
    
}
