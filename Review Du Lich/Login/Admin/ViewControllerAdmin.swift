//
//  ViewControllerAdmin.swift
//  Review Du Lich
//
//  Created by Apple on 9/15/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit
import FirebaseDatabase
import Toast_Swift
class ViewControllerAdmin: UIViewController {

    @IBOutlet weak var tfDiaDiemID: UITextField!
    @IBOutlet weak var tvGioithieu: UITextView!
    @IBOutlet weak var tvdiemden: UITextView!
    @IBOutlet weak var tvChuy: UITextView!
    @IBOutlet weak var btnSave: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        btnSave.layer.cornerRadius = 10
        
        // Do any additional setup after loading the view.
    }

    @IBAction func taponSave(_ sender: Any) {
        view.endEditing(true)
        if tfDiaDiemID.text == "" || tvGioithieu.text == "" || tvdiemden.text == "" || tvChuy.text == "" {
            self.view.makeToast("Nhập đủ thông tin dịa điểm du lịch")
        }else{
            let databaseRef = Database.database().reference()
            let id = databaseRef.childByAutoId().key!
            let value: [String: Any] = ["tendiadiem": tfDiaDiemID.text, "gioithieu": tvGioithieu.text, "diadiem": tvdiemden.text, "chuy": tvChuy.text, "id": id]
            databaseRef.child("Data").child(id).setValue(value)
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.tfDiaDiemID.text = ""
                self.tvGioithieu.text = ""
                self.tvdiemden.text = ""
                self.tvChuy.text = ""
                self.view.makeToast("Thêm địa điểm thành công")
            }
        }
        
        navigationController?.popViewController(animated: true)
        
    }


}
