//
//  ViewControllerAdList.swift
//  Review Du Lich
//
//  Created by Apple on 9/16/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit
import FirebaseDatabase

class ViewControllerAdList: UIViewController {

    @IBOutlet weak var tableviewAD: UITableView!
    @IBOutlet weak var tfSearch: UITextField!
    var arrListTour = [Data]()
    var datatour: Data?
    override func viewDidAppear(_ animated: Bool) {
        getdatafirebase()
        arrListTour.removeAll()
        tableviewAD.reloadData()
    }
    override func viewDidLoad() {
     
        super.viewDidLoad()
        getdatafirebase()
        setuptableviewListtour()
    }

    func  getdataSearch() {
        let dataRef = Database.database().reference()
        dataRef.child("Data").observe(.childAdded) { (data) in
            dataRef.child("Data").child(data.key).observe(.value) { (snapshot) in
                if let dict = snapshot.value as? [String: Any]{
                    let data1 = Data(dict: dict)
                    if self.tfSearch.text == ""{
                        let data1 = Data(dict: dict)
                        self.arrListTour.append(data1)
                        self.tableviewAD.reloadData()
                    }
                    else{
                        if data1.tendiadiem == self.tfSearch.text{
                            self.arrListTour.append(data1)
                            self.tableviewAD.reloadData()
                        }
                    }
                    
                }
                dataRef.child("Data").child(data.key).removeAllObservers()
            }
            dataRef.child("Data").removeAllObservers()
        }
    }
    @IBAction func TaponSearch(_ sender: Any) {
        if tfSearch.text == ""{
            arrListTour.removeAll()
            tableviewAD.reloadData()
            
        }
        else{
            arrListTour.removeAll()
            tableviewAD.reloadData()
            getdataSearch()
        }
    }
    @IBAction func TaponAddTour(_ sender: Any) {
        let vc = ViewControllerADminAdd(nibName: "ViewControllerADminAdd", bundle: nil)
        vc.modalPresentationStyle = .overFullScreen
        navigationController?.pushViewController(vc, animated: true)
        arrListTour.removeAll()
        getdatafirebase()
    }
    func getdatafirebase(){
        let dataRef = Database.database().reference()
        dataRef.child("Data").observe(.childAdded) { (data) in
            dataRef.child("Data").child(data.key).observe(.value) { (snapshot) in
                if let dict = snapshot.value as? [String: Any]{
                    let data1 = Data(dict: dict)
                    self.arrListTour.append(data1)
                    self.tableviewAD.reloadData()
                }
                dataRef.child("Data").child(data.key).removeAllObservers()
            }
            dataRef.child("Data").removeAllObservers()
        }
    }
    func setuptableviewListtour(){
        
        tableviewAD.delegate = self
        tableviewAD.dataSource = self
        let nib = UINib(nibName: "TableViewCellAdmin", bundle: nil)
        tableviewAD.register(nib, forCellReuseIdentifier: "Cell2")
    }

}
extension ViewControllerAdList: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrListTour.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableviewAD.dequeueReusableCell(withIdentifier: "Cell2") as! TableViewCellAdmin
        let data = arrListTour[indexPath.row]
        cell.imgcell.image = UIImage(named: data.img)
        cell.lbTitlle.text = data.tendiadiem
        cell.lbCell.text = data.gioithieu
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 151
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let alert = UIAlertController(title: nil, message: "Choose option", preferredStyle: .actionSheet)
        let action1 = UIAlertAction(title: "Edit", style: .default) { (edit) in
            let data1 = self.arrListTour[indexPath.row]
            let vc = ViewControllerEdit(nibName: "ViewControllerEdit", bundle: nil)
            vc.datatour = data1
            vc.delegate = self
            self.present(vc, animated: true, completion: nil)
        }
        let action2 = UIAlertAction(title: "Delete", style: .destructive) { (delete) in
            let tenđiaiem = self.arrListTour[indexPath.row].tendiadiem
            
            let databaseRef = Database.database().reference()
//            if let tour = self.datatour{
//                databaseRef.child("Data").child(tour.id).removeValue()
//
//            }
            databaseRef.child("Data").child(tenđiaiem).removeValue()
            
            self.arrListTour.removeAll()
            self.getdatafirebase()
            
        }
        let action3 = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(action1)
        alert.addAction(action2)
        alert.addAction(action3)
        self.present(alert, animated: true, completion: nil)
    }
}
extension ViewControllerAdList: EditTourDelegate{
    func editsuccess() {
        self.arrListTour.removeAll()
        getdatafirebase()
    }
    
    
}
