//
//  TableViewCellHome.swift
//  Review Du Lich
//
//  Created by Apple on 9/4/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit

class TableViewCellHome: UITableViewCell {

    @IBOutlet weak var imgcell: UIImageView!
    @IBOutlet weak var lbTittleCell: UILabel!
    @IBOutlet weak var lbcell: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
