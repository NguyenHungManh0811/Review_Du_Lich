//
//  TableViewCellText.swift
//  Review Du Lich
//
//  Created by Apple on 9/14/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit

class TableViewCellText: UITableViewCell {

    @IBOutlet weak var titleCell: UINavigationItem!
    @IBOutlet weak var textview: UITextView!
    
    @IBOutlet weak var HeightViewcell: NSLayoutConstraint!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
