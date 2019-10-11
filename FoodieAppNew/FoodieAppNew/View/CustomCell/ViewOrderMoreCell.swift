//
//  ViewOrderMoreCell.swift
//  FoodieAppNew
//
//  Created by CrossGrids on 19/09/19.
//  Copyright © 2019 CrossGrids. All rights reserved.
//

import UIKit

class ViewOrderMoreCell: UITableViewCell {

    @IBOutlet weak var lblTotal: UILabel!
    @IBOutlet weak var btnAddDishes: UIButton!
    @IBOutlet weak var innerView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        innerView.layer.cornerRadius = 20
        innerView.clipsToBounds = true
        innerView.layer.maskedCorners = [ .layerMinXMaxYCorner, .layerMaxXMaxYCorner]
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

