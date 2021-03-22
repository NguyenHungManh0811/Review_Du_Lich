//
//  ViewController.swift
//  Review Du Lich
//
//  Created by Apple on 9/4/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit
import ImageSlideshow
import SearchTextField
import FirebaseDatabase
class tourist {
    var image = ""
    var tittle = ""
    var detail = ""
    init(image: String, tittle: String, detail: String) {
        self.image = image
        self.tittle = tittle
        self.detail = detail
    }
}
class ViewController: UIViewController {
    
    @IBOutlet weak var ImageSlideshow1: ImageSlideshow!
    @IBOutlet weak var TableviewHome: UITableView!
    @IBOutlet weak var SearchTf: UITextField!
    var ListTourist = [Data]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getdatafirebase()
        setupimgSlideshow()
        setuptableview()    
    }
    
    func getdatafirebase(){
        let dataRef = Database.database().reference()
        dataRef.child("Data").observe(.childAdded) { (data) in
            dataRef.child("Data").child(data.key).observe(.value) { (snapshot) in
                if let dict = snapshot.value as? [String: Any]{
                    let data1 = Data(dict: dict)
                    self.ListTourist.append(data1)
                    self.TableviewHome.reloadData()
                }
                dataRef.child("Data").removeAllObservers()
            }
            dataRef.child("Data").removeAllObservers()
        }
    }
    @IBAction func TaponBtnlogin(_ sender: Any) {
        let vcLogin = ViewControllerLogin(nibName: "ViewControllerLogin", bundle: nil)
        vcLogin.modalPresentationStyle = .overFullScreen
        navigationController?.pushViewController(vcLogin, animated: true)
    }
    
    func setupimgSlideshow(){
        ImageSlideshow1.contentScaleMode = .scaleAspectFill
        let input: [InputSource] = [ImageSource(image: UIImage(named: "Nha Trang1")!),
                                    ImageSource(image: UIImage(named: "Sapa1")!),
                                    ImageSource(image: UIImage(named: "Mộc Châu1")!),
                                    ImageSource(image: UIImage(named: "Vịnh Hạ Long1")!),
                                    ImageSource(image: UIImage(named: "Sapa4")!)]
        ImageSlideshow1.setImageInputs(input)
        ImageSlideshow1.slideshowInterval = 3
        
    }
    func setuptableview(){
        TableviewHome.delegate = self
        TableviewHome.dataSource = self
        let nib = UINib(nibName: "TableViewCellHome", bundle: nil)
        TableviewHome.register(nib, forCellReuseIdentifier: "Cell1")
    }
}
extension ViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ListTourist.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = TableviewHome.dequeueReusableCell(withIdentifier: "Cell1") as! TableViewCellHome
            let data = ListTourist[indexPath.row]
        cell.imgcell.image = UIImage(named: data.img)
        cell.lbTittleCell.text = data.tendiadiem
        cell.lbcell.text = data.gioithieu
            return cell


    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 151
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = ViewControllerTour(nibName: "ViewControllerTour", bundle: nil)
        vc.modalPresentationStyle = .overFullScreen
        vc.nameTour = ListTourist[indexPath.row].tendiadiem
        navigationController?.pushViewController(vc, animated: true)
    }

}

