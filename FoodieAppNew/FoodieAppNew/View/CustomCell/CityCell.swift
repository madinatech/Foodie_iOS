//
//  CityCell.swift
//  Foodie
//
//  Created by CrossGrids on 03/09/19.
//  Copyright © 2019 CrossGrids. All rights reserved.
//

import UIKit

class CityCell: UITableViewCell {

    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var imagWidth: NSLayoutConstraint!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
