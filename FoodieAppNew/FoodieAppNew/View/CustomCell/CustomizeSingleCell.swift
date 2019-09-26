//
//  CustomizeSingleCell.swift
//  FoodieAppNew
//
//  Created by CrossGrids on 26/09/19.
//  Copyright © 2019 CrossGrids. All rights reserved.
//

import UIKit

class CustomizeSingleCell: UITableViewCell {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var btnRedio: KGRadioButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(value : GroupValues)  {
        
        lblTitle.text = value.item_name
        lblPrice.text = "\(value.item_price)"
    }
    
}
