//
//  LoaderView.swift
//  FoodieAppNew
//
//  Created by CrossGrids on 03/10/19.
//  Copyright © 2019 CrossGrids. All rights reserved.
//

import UIKit

class LoaderView: UIView {

    @IBOutlet weak var imgView: UIImageView!
    class func instanceFromNib() -> UIView {
        return UINib(nibName: "LoaderView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! UIView
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let noDelivery = UIImage.gifImageWithName("ANimated_preview")
        imgView.image = noDelivery
    }

}
