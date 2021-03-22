//
//  TableViewCellAdmin.swift
//  Review Du Lich
//
//  Created by Apple on 9/16/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit

class TableViewCellAdmin: UITableViewCell {
    @IBOutlet weak var imgcell: UIImageView!
    @IBOutlet weak var lbTitlle: UILabel!
    @IBOutlet weak var lbCell: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
