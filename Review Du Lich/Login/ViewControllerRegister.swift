//
//  ViewControllerRegister.swift
//  Review Du Lich
//
//  Created by Apple on 9/7/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit
import Toast_Swift
import FirebaseAuth

class ViewControllerRegister: UIViewController {
    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var btnDangky: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btnDangky.backgroundColor = .green
        btnDangky.setTitleColor(.white, for: .normal)
        btnDangky.layer.cornerRadius = 10
    }
    
    
    @IBAction func TaponDangKy(_ sender: Any) {
        view.endEditing(true)
        if tfEmail.text == "" || tfPassword.text == ""{
            self.view.makeToast("Nhập đủ thông tin...")
        }
        else{
            Auth.auth().createUser(withEmail: tfEmail.text!, password: tfPassword.text!) { (authData, error) in
                if error != nil{
                    self.view.makeToast(error!.localizedDescription)
                }
                else{
                    self.view.makeToast("Dang ky thanh cong")
                   
                    self.navigationController?.popViewController(animated: true)
//                    let vc = ViewControllerLogin(nibName: "ViewControllerLogin", bundle: nil)
//                    vc.modalPresentationStyle = .overFullScreen
//                    self.navigationController?.popToViewController(vc, animated: true)
                }
                //gui otp ve mail
//                authData?.user.sendEmailVerification(completion: { (error) in
//                    if error != nil {
//                        self.view.makeToast(error!.localizedDescription)
//
//                    }
//                    else{
//                        self.view.makeToast("Gui OTP ve Mail")
//                    }
//                })
            }
        }
    }
    
    
}
