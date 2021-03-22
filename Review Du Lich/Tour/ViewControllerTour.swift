//
//  ViewControllerTour.swift
//  Review Du Lich
//
//  Created by Apple on 9/4/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit
import ImageSlideshow
import FirebaseDatabase
class ChitietTour{
    var tittle = ""
    var text = ""
    init(tittle: String, text: String) {
        self.tittle = tittle
        self.text = text
    }
}

class ViewControllerTour: UIViewController {
    
    @IBOutlet weak var ImgSlideTour: ImageSlideshow!
    @IBOutlet weak var Tittletour: UINavigationItem!
    @IBOutlet weak var SegControl: UISegmentedControl!
    @IBOutlet weak var viewGioithieu: UIView!
    @IBOutlet weak var tvGioithieu: UITextView!
    @IBOutlet weak var viewdiemden: UIView!
    @IBOutlet weak var tvDiemden: UITextView!
    @IBOutlet weak var viewLuuy: UIView!
    @IBOutlet weak var tvLuuy: UITextView!
    @IBOutlet weak var ViewMore: UIView!
    
    @IBOutlet weak var imgThoitiet: UIImageView!
    @IBOutlet weak var btnThoitiet: UIButton!
    @IBOutlet weak var imgMap: UIImageView!
    
    var arraydata = [Data]()
    var nameTour = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        ViewMore.layer.cornerRadius = 10
        Tittletour.title = nameTour
        getdatafirebase()
        setupimgslidetour()
        //getdataTour()
        setupSegControl()
        setupTapWeather()
        setupTapMap()
//        setTapReview()
        
    }
    func getdatafirebase(){
        let dataRef = Database.database().reference()
        dataRef.child("Data").observe(.childAdded) { (data) in
            dataRef.child("Data").child(data.key).observe(.value) { (snapshot) in
                if let dict = snapshot.value as? [String: Any]{
                    let data1 = Data(dict: dict)
                    self.arraydata.append(data1)
                    self.getdataTour()

                }
            }
        }
            }
    func getdataTour(){
        for id in arraydata{
            if id.tendiadiem == nameTour {
                tvGioithieu.text = id.gioithieu
                tvDiemden.text = id.diadiem
                tvLuuy.text = id.chuy
            }
        }
    }
    func setupimgslidetour(){
        ImgSlideTour.contentScaleMode = .scaleAspectFill
        let img1 = nameTour + "1"
        let img2 = nameTour + "2"
        let input: [InputSource] = [ImageSource(image: UIImage(named: img1)!),
                                    ImageSource(image: UIImage(named: img2)!)]
        ImgSlideTour.setImageInputs(input)
        ImgSlideTour.slideshowInterval = 3
    }
    func setupSegControl(){
        SegControl.backgroundColor = .green
        SegControl.selectedSegmentIndex = 0
        viewGioithieu.isHidden = false
    }
    @IBAction func TaponSegControl(_ sender: Any) {
        if SegControl.selectedSegmentIndex == 0{
//            for id in arraydata{
//                if nameTour == id.tendiadiem{
//                    tvGioithieu.text = id.gioithieu
//                }
//            }
            viewGioithieu.isHidden = false
            viewdiemden.isHidden = true
            viewLuuy.isHidden = true
            
        }
        else if SegControl.selectedSegmentIndex == 1{
            viewGioithieu.isHidden = true
            viewdiemden.isHidden = false
            viewLuuy.isHidden = true
//            for id in arraydata{
//                if nameTour == id.tendiadiem{
//                    tvDiemden.text = id.diadiem
//                }
//            }
        }
        else if SegControl.selectedSegmentIndex == 2 {
            viewGioithieu.isHidden = true
            viewdiemden.isHidden = true
            viewLuuy.isHidden = false
//            for id in arraydata{
//                if nameTour == id.tendiadiem{
//                    tvLuuy.text = id.chuy
//                }
//            }
        }
    }
    
    
    func setupTapWeather(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(TapOnWeather))
        imgThoitiet.isUserInteractionEnabled = true
        imgThoitiet.addGestureRecognizer(tap)
    }
    @objc func TapOnWeather(){
        let vc = ViewControllerWeather(nibName: "ViewControllerWeather", bundle: nil)
        vc.modalPresentationStyle = .overFullScreen
        vc.nametour = nameTour
        navigationController?.pushViewController(vc, animated: true)
        
    }
    func setupTapMap(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(TapOnMap))
        imgMap.isUserInteractionEnabled = true
        imgMap.addGestureRecognizer(tap)
        
    }
    @objc func TapOnMap(){
        let vc = ViewControllerMap(nibName: "ViewControllerMap", bundle: nil)
        vc.modalPresentationStyle = .overFullScreen
        vc.tendiadiem = nameTour
        navigationController?.pushViewController(vc, animated: true)
    }
//    func setTapReview(){
//        let tap = UITapGestureRecognizer(target: self, action: #selector(TapOnComment))
//        imgReview.isUserInteractionEnabled = true
//        imgReview.addGestureRecognizer(tap)
//    }
//    @objc func TapOnComment(){
//        let vc = ViewControllerComment(nibName: "ViewControllerComment", bundle: nil)
//        vc.modalPresentationStyle = .overFullScreen
//        navigationController?.pushViewController(vc, animated: true)
//    }
    @IBAction func TaponWeather(_ sender: Any) {
        let vc = ViewControllerWeather(nibName: "ViewControllerWeather", bundle: nil)
        vc.modalPresentationStyle = .overFullScreen
        vc.nametour = nameTour
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func TaponMap(_ sender: Any) {
        let vc = ViewControllerMap(nibName: "ViewControllerMap", bundle: nil)
        vc.modalPresentationStyle = .overFullScreen
        vc.tendiadiem = nameTour
        navigationController?.pushViewController(vc, animated: true)
    }
    
//    @IBAction func TaponReview(_ sender: Any) {
//        let vc = ViewControllerComment(nibName: "ViewControllerComment", bundle: nil)
//        vc.modalPresentationStyle = .overFullScreen
//        navigationController?.pushViewController(vc, animated: true)
//    }
}

