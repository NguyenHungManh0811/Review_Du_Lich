//
//  ViewControllerEdit.swift
//  Review Du Lich
//
//  Created by Apple on 9/16/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit
import FirebaseDatabase
protocol EditTourDelegate {
    func editsuccess()
}
class ViewControllerEdit: UIViewController {
    @IBOutlet weak var tftendiadiem: UITextField!
    @IBOutlet weak var tfimgname: UITextField!
    @IBOutlet weak var tvgioithieu: UITextView!
    @IBOutlet weak var tvdiemden: UITextView!
    @IBOutlet weak var tvchuy: UITextView!
    
    var datatour: Data?
    var delegate: EditTourDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        bindData()
    }
    func bindData(){
        if let tour = datatour{
            tftendiadiem.text = tour.tendiadiem
            tfimgname.text = tour.img
            tvgioithieu.text = tour.gioithieu
            tvdiemden.text = tour.diadiem
            tvchuy.text = tour.chuy
        }
    }
    @IBAction func TaponSave(_ sender: Any) {
        let databaseRef = Database.database().reference()
        if let tour = datatour{
            let value:[String: Any] = ["tendiadiem": tftendiadiem.text, "gioithieu": tvgioithieu.text, "diadiem": tvdiemden.text, "chuy": tvchuy.text,"img": tfimgname.text]
            databaseRef.child("Data").child(tour.tendiadiem).updateChildValues(value)
            delegate?.editsuccess()
            dismiss(animated: true, completion: nil)
        }
    }
    
}
