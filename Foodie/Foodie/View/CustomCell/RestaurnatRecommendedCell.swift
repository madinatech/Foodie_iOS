

import UIKit

class RestaurnatRecommendedCell: UICollectionViewCell {

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblAmount: UILabel!
    @IBOutlet weak var btnAdd: UIButton!
    @IBOutlet weak var btnPlus: UIButton!
    @IBOutlet weak var btnMinus: UIButton!
    @IBOutlet weak var addView: UIView!
    @IBOutlet weak var lblItemCount: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        btnAdd.layer.borderWidth = 1
        btnAdd.layer.borderColor = appLigtGrayColor.cgColor
        addView.layer.borderWidth = 1
        addView.layer.borderColor = appLigtGrayColor.cgColor
        self.contentView.dropShadow()
//        innerView.dropShadow()
        imgView.layer.cornerRadius = 10
        imgView.clipsToBounds = true
        imgView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
}
