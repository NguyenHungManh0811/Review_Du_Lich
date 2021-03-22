//
//  ViewControllerADminAdd.swift
//  Review Du Lich
//
//  Created by Apple on 9/16/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit
import FirebaseDatabase

class ViewControllerADminAdd: UIViewController {
    
    @IBOutlet weak var tfDiaDiemID: UITextField!
    @IBOutlet weak var tfImage: UITextField!
    @IBOutlet weak var tvGioithieu: UITextView!
    @IBOutlet weak var tvdiemden: UITextView!
    @IBOutlet weak var tvChuy: UITextView!
    @IBOutlet weak var btnSave: UIButton!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        btnSave.layer.cornerRadius = 10
        // Do any additional setup after loading the view.
    }
//    func getdatafirebase(){
//        let dataRef = Database.database().reference()
//        dataRef.child("Data").observe(.childAdded) { (data) in
//            dataRef.child("Data").child(data.key).observe(.value) { (snapshot) in
//                if let dict = snapshot.value as? [String: Any]{
//                    let data1 = Data(dict: dict)
//                    self.arraytour.append(data1)
//                }
//            }
//            dataRef.child("Data").removeAllObservers()
//        }
//    }
    @IBAction func TaponSave(_ sender: Any) {
        view.endEditing(true)
        if tfDiaDiemID.text == "" || tvGioithieu.text == "" || tvdiemden.text == "" || tvChuy.text == "" {
            self.view.makeToast("Nhập đủ thông tin dịa điểm du lịch")
        }else{
            let databaseRef = Database.database().reference()
//            let id = databaseRef.childByAutoId().key!
            let id = tfDiaDiemID.text
            let value: [String: Any] = ["tendiadiem": tfDiaDiemID.text, "gioithieu": tvGioithieu.text, "diadiem": tvdiemden.text, "chuy": tvChuy.text,"img": tfImage.text, "id": id]
            databaseRef.child("Data").child(id!).setValue(value)
//            databaseRef.child("Data").child(id)
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.tfDiaDiemID.text = ""
                self.tfImage.text = ""
                self.tvGioithieu.text = ""
                self.tvdiemden.text = ""
                self.tvChuy.text = ""
                self.view.makeToast("Thêm địa điểm thành công")
            }
        }
        
        navigationController?.popViewController(animated: true)
    }
}
