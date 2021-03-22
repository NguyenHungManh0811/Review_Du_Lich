//
//  ViewControllerLogin.swift
//  Review Du Lich
//
//  Created by Apple on 9/4/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit
import TransitionButton
import Toast_Swift
import FirebaseAuth
import FBSDKLoginKit
import GoogleSignIn

class ViewControllerLogin: UIViewController{
    

    @IBOutlet weak var btnDangnhap: TransitionButton!
    @IBOutlet weak var btnDangky: TransitionButton!
    @IBOutlet weak var btnQuenmatkhau: UIButton!
    @IBOutlet weak var btnFacebook: FBLoginButton!
    @IBOutlet weak var btnGoogle:GIDSignInButton!
    
    @IBOutlet weak var tfemail: UITextField!
    @IBOutlet weak var tfpassword: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBtnDangnhap()
        setupFBBtn()
        
    }
     func setupFBBtn()  {
           btnFacebook.delegate = self
       }
    func setupGoogleButton(){
        GIDSignIn.sharedInstance()?.presentingViewController = self
        GIDSignIn.sharedInstance()?.delegate = self
        GIDSignIn.sharedInstance().signIn()
        
    }
    func setupBtnDangnhap()  {
        btnDangnhap.backgroundColor = .green
        btnDangnhap.setTitle("Đăng Nhập", for: .normal)
        btnDangnhap.setTitleColor(.black, for: .normal)
        btnDangnhap.cornerRadius = 10
        btnDangnhap.spinnerColor = .white
        btnDangnhap.addTarget(self, action: #selector(TaponbtnLogin), for: .touchUpInside)
    }
    @objc func TaponbtnLogin(){
        btnDangnhap.startAnimation()
        let qualityOfServiceClass = DispatchQoS.QoSClass.background
        let backgrounfQueue = DispatchQueue.global(qos: qualityOfServiceClass)
        backgrounfQueue.async {
            sleep(1)
            DispatchQueue.main.async {
                self.btnDangnhap.stopAnimation(animationStyle: .expand, revertAfterDelay: 0) {
                    self.view.endEditing(true)
                    if self.tfemail.text == "" || self.tfpassword.text == ""{
                        self.view.makeToast("Vui lòng nhập đầy đủ thông tin")
                    }else{
                        Auth.auth().signIn(withEmail: self.tfemail.text!, password: self.tfpassword.text!) { (authData, error) in
                            if error != nil{
                                self.view.makeToast(error?.localizedDescription)
                            }
                            else{
                                authData?.user.reload(completion: { (error) in
                                    if authData?.user.isEmailVerified == true {
                                        // Login thanh cong chuyen den man hinh khac
                                        self.view.makeToast("Login thanh cong")
                                        if self.tfemail.text == "manhdiep0811@gmail.com" && self.tfpassword.text == "123456"{
                                            let vc = ViewControllerAdList(nibName: "ViewControllerAdList", bundle: nil)
                                            vc.modalPresentationStyle = .overFullScreen
                                            self.navigationController?.pushViewController(vc, animated: true)
                                        }
                                        else{
                                            self.loginsuccess()
                                        }
                                        
                                    }
                                    else{
                                        self.view.makeToast("Email chua duoc xac thuc")
                                    }
                                })
                            }

                        }

                    }

                }
            }
        }
    }
    
    @IBAction func TaponBtnDangky(_ sender: Any) {
        let vc = ViewControllerRegister(nibName: "ViewControllerRegister", bundle: nil)
        vc.modalPresentationStyle = .overFullScreen
        navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func taponWithGoogle(_ sender: Any) {
        setupGoogleButton()
    }
    
    func loginsuccess(){

        navigationController?.popViewController(animated: true)
       }
   
}

extension ViewControllerLogin: LoginButtonDelegate{
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        if error != nil{
            self.view.makeToast(error?.localizedDescription)
        }
        else{
            // lay data fb ra
            let fbLoginManager: LoginManager = LoginManager()
            fbLoginManager.logIn(permissions:[ "public_profile", "email"], from: self) { (facebookData, error) in
                if error != nil{
                    self.view.makeToast(error?.localizedDescription)
                }
                else{
                    if let data = facebookData{
                        if data.grantedPermissions.contains("email"){
                            GraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name, last_name, picture.type(large), email"]).start { (connection, result, error) in
                                if error != nil{
                                    self.view.makeToast(error?.localizedDescription)
                                }
                                else{
                                    if let dict = result as? NSDictionary{
                                        guard let name = dict.object(forKey: "name") as? String else {return}
                                        guard let email = dict.object(forKey: "email") as? String else {return}
                                        print(name)
                                        print(email)
                                        
                                        // get token Facebook
                                        let FacebookToken = FacebookAuthProvider.credential(withAccessToken: AccessToken.current!.tokenString)
                                        dump(FacebookToken)
                                        Auth.auth()
                                            .signIn(with: FacebookToken) { (authdata, error) in
                                                if error != nil{
                                                    self.view.makeToast(error?.localizedDescription)
                                                    
                                                }
                                                else{
                                                    self.view.makeToast("Login Facebook success")
                                                    self.loginsuccess()
                                                }
                                        }
                                    }
                                    
                                }
                            }
                        }
                        
                    }
                }
            }
        }
    }
    
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
        
    }
    
    
}
extension ViewControllerLogin: GIDSignInDelegate{
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if error != nil{
            self.view.makeToast(error.localizedDescription)
        }else{
            self.view.makeToast("google success")
            // get google firebase
            guard let authentication = user.authentication else { return }
            let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken, accessToken: authentication.accessToken)
            Auth.auth().signIn(with: credential) { (authData, error) in
                if error != nil{
                    self.view.makeToast(error?.localizedDescription)
                }
                else{
                    self.view.makeToast("Login google success")
                    self.loginsuccess()
                }
            }
        }
    }
    
    
}
