//
//  ViewControllerMap.swift
//  Review Du Lich
//
//  Created by Apple on 9/15/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit
import GoogleMaps
class ToaDo {
    var name = ""
    var location: CLLocationCoordinate2D
    init(name: String, location: CLLocationCoordinate2D) {
        self.name = name
        self.location = location
    }
}
class ViewControllerMap: UIViewController {

    @IBOutlet weak var mapview: GMSMapView!
    let arraymap = [ToaDo(name: "Sapa", location: CLLocationCoordinate2DMake(22.349198, 103.833589)),
                    ToaDo(name: "Nha Trang", location: CLLocationCoordinate2DMake(12.310605, 109.153995)),
                    ToaDo(name: "Mộc Châu", location: CLLocationCoordinate2DMake(20.841055, 104.769124)),
                    ToaDo(name: "Vịnh Hạ Long", location: CLLocationCoordinate2DMake(20.914343, 107.183615)),
                    ToaDo(name: "Phú Quốc", location: CLLocationCoordinate2DMake(10.228111, 103.972452))]
    var tendiadiem = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMap()        
    }
    // https://www.youtube.com/watch?v=8wPjCdDn2wo
    private func setupMap(){
        for map in arraymap{
            if map.name == tendiadiem{
                let camera = GMSCameraPosition.camera(withLatitude: map.location.latitude, longitude: map.location.longitude, zoom: 10)
                mapview.camera = camera
                let currenlocation = CLLocationCoordinate2DMake(map.location.latitude, map.location.longitude)
                let market = GMSMarker(position: currenlocation)
                market.title = map.name
                market.map = mapview
            }
        }
    }

    

}
