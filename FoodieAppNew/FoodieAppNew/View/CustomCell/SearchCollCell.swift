//
//  SearchCollCell.swift
//  FoodieAppNew
//
//  Created by CrossGrids on 19/09/19.
//  Copyright © 2019 CrossGrids. All rights reserved.
//

import UIKit
import Kingfisher

class SearchCollCell: UICollectionViewCell {

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lblItem: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
       imgView.layer.cornerRadius = 15
    }

    func setData(cusines: Cusines){
           lblItem.text = cusines.name
         imgView.kf.indicatorType = .activity
        let url = URL(string: cusines.image ?? "")
                imgView.kf.setImage(with: url, placeholder: nil, options: nil, progressBlock: { (size1, size2) in
                    
                }, completionHandler: { (image, error, cache, url) in
                    if image != nil{
                        self.imgView.image = image
                    }
                })
    }
}
