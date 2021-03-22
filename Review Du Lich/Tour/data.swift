//
//  data.swift
//  Review Du Lich
//
//  Created by Apple on 9/7/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import Foundation
class Data {
    var tendiadiem = ""
    var gioithieu = ""
    var diadiem = ""
    var chuy = ""
    var img = ""
    var id = ""
    init(tendiadiem: String ,gioithieu: String, diadiem: String, chuy: String, img:String, id: String) {
        self.tendiadiem = tendiadiem
        self.gioithieu = gioithieu
        self.diadiem = diadiem
        self.chuy = chuy
        self.img = img
        
        self.id = id
    }
    init(dict: [String: Any]){
        self.tendiadiem = dict["tendiadiem"] as? String ?? ""
        self.gioithieu = dict["gioithieu"] as? String ?? ""
        self.diadiem = dict["diadiem"] as? String ?? ""
        self.chuy = dict["chuy"] as? String ?? ""
        self.img = dict["img"] as? String ?? ""
        self.id = dict["id"] as? String ?? ""
    }
}
