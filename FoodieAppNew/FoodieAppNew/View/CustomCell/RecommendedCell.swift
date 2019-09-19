

import UIKit

class RecommendedCell: UICollectionViewCell {
    
    @IBOutlet weak var innerView: UIView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lblCusines: UILabel!
    @IBOutlet weak var lblOffer: UILabel!
    @IBOutlet weak var lblRating: UILabel!
    @IBOutlet weak var lblAmount: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        innerView.dropShadow()
//        imgView.layer.cornerRadius = 10
//        imgView.clipsToBounds = true
//        imgView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    
}
