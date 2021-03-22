//
//  ViewControllerWeather.swift
//  Review Du Lich
//
//  Created by Apple on 9/15/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit
import GoogleMaps
import Alamofire
import SwiftyJSON
import NVActivityIndicatorView
import CoreLocation
class ToaDoWeather {
    var name = ""
    var location: CLLocationCoordinate2D
    init(name: String, location: CLLocationCoordinate2D) {
        self.name = name
        self.location = location
    }
}
class ViewControllerWeather: UIViewController {
    @IBOutlet weak var lbnameTour: UILabel!
    @IBOutlet weak var lbDate: UILabel!
    @IBOutlet weak var imageWeather: UIImageView!
    @IBOutlet weak var lbWeather: UILabel!
    @IBOutlet weak var lbTemp: UILabel!
    @IBOutlet weak var ViewBackground: UIView!
    
    let arrayToado = [ToaDo(name: "Sapa", location: CLLocationCoordinate2DMake(22.349198, 103.833589)),
                    ToaDo(name: "Nha Trang", location: CLLocationCoordinate2DMake(12.310605, 109.153995)),
                    ToaDo(name: "Mộc Châu", location: CLLocationCoordinate2DMake(20.841055, 104.769124)),
                    ToaDo(name: "Vịnh Hạ Long", location: CLLocationCoordinate2DMake(20.914343, 107.183615)),
                    ToaDo(name: "Phú Quốc", location: CLLocationCoordinate2DMake(10.228111, 103.972452))]

    var nametour = ""
    let gradientLayer = CAGradientLayer()
    let apikey = "696c05d3705271fee0e5adbdfb237104"
    var lat = 12.310605
    var lon = 109.153995
    var activityIndicator: NVActivityIndicatorView!
    let locationManager = CLLocationManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        ViewBackground.layer.addSublayer(gradientLayer)
        
        let indicatorSize: CGFloat = 70
        let indicatorFrame = CGRect(x: (view.frame.width-indicatorSize)/2, y: (view.frame.height-indicatorSize)/2, width: indicatorSize, height: indicatorSize)
        activityIndicator = NVActivityIndicatorView(frame: indicatorFrame, type: .lineScale, color: UIColor.white, padding: 20.0)
        activityIndicator.backgroundColor = .black
        view.addSubview(activityIndicator)
        locationManager.requestWhenInUseAuthorization()
        activityIndicator.startAnimating()
        if CLLocationManager.locationServicesEnabled(){
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        setBlueBackground()
    }
    func setBlueBackground(){
        let topColor = UIColor(red: 95.0/255.0, green: 165.0/255.0, blue: 1.0, alpha: 1.0).cgColor
        let bottomColor = UIColor(red: 72.0/255.0, green: 114.0/255.0, blue: 184.0/255.0, alpha: 1.0).cgColor
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [topColor, bottomColor]
    }
    func setGreybackground(){
        let topColor = UIColor(red: 151.0/255.0, green: 151.0/255.0, blue: 151.0/255.0, alpha: 1.0).cgColor
        let bottomColor = UIColor(red: 72.0/255.0, green: 72.0/255.0, blue: 72.0/255.0, alpha: 1.0).cgColor
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [topColor, bottomColor]
    }

}

extension ViewControllerWeather: CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        for tour in arrayToado{
            if tour.name == nametour{
                lat = tour.location.latitude
                lon = tour.location.longitude
                Alamofire.request("http://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(lon)&appid=\(apikey)&units=metric").responseJSON { (response) in
                    self.activityIndicator.stopAnimating()
                    if let responseStr = response.result.value{
                        let jsonResponse = JSON(responseStr)
                        let jsonWeather = jsonResponse["weather"].array![0]
                        let jsonTemp = jsonResponse["main"]
                        let iconName = jsonWeather["icon"].stringValue
                        
                        self.lbnameTour.text = jsonResponse["name"].stringValue
                        self.imageWeather.image = UIImage(named: iconName)
                        self.lbWeather.text = jsonWeather["main"].stringValue
                        self.lbTemp.text = "\(Int(round(jsonTemp["temp"].doubleValue)))"
                        
                        let date = Date()
                        let dateFormatter = DateFormatter()
                        dateFormatter.dateFormat = "EEEE"
                        self.lbDate.text = dateFormatter.string(from: date)
                        
                        let suffix = iconName.suffix(1)
                        if suffix == "n"{
                            self.setGreybackground()
                        }
                        else {
                            self.setBlueBackground()
                        }
                    }
                }
            }
        }
        self.locationManager.stopUpdatingLocation()
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
    
}


//   alamorefire request http://api.openweathermap.org/data/2.5/weather?lat=22.349198&lon=103.833589&appid=696c05d3705271fee0e5adbdfb237104&units=metric
// link youtube https://www.youtube.com/watch?v=WHRntPeAOo4&pbjreload=101
// api key https://home.openweathermap.org/api_keys
