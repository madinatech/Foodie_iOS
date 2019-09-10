//
//  RecentOrderCell.swift
//  Foodie
//
//  Created by CrossGrids on 05/09/19.
//  Copyright © 2019 CrossGrids. All rights reserved.
//

import UIKit

class RecentOrderCell: UITableViewCell {
    @IBOutlet weak var lblResName: UILabel!
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var lblAmount: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblItem: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
