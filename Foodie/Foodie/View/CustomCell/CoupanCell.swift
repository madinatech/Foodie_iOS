//
//  CoupanCell.swift
//  Foodie
//
//  Created by CrossGrids on 06/09/19.
//  Copyright © 2019 CrossGrids. All rights reserved.
//

import UIKit

class CoupanCell: UITableViewCell {
    @IBOutlet weak var imgView: UIImageView!
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var btnGetSuper: UIButton!
    @IBOutlet weak var lblDesc: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    func setData (index : Int) {
        if(index == 0){
            lblTitle.text = "Apply Coupon"
            lblDesc.isHidden = true
        } else {
            lblTitle.text = "Don't pay delivery fee"
            lblDesc.isHidden = false
            btnGetSuper.setImage(nil, for: .normal)
            btnGetSuper.setTitle("Get Super", for: .normal)
        }
    }
}
