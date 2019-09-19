//
//  SearchCollCell.swift
//  FoodieAppNew
//
//  Created by CrossGrids on 19/09/19.
//  Copyright © 2019 CrossGrids. All rights reserved.
//

import UIKit

class SearchCollCell: UICollectionViewCell {

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lblItem: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
       imgView.layer.cornerRadius = 15
    }

}
