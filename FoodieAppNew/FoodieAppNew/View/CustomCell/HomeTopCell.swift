

import UIKit

class HomeTopCell: UICollectionViewCell {

    @IBOutlet weak var innerView: UIView!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setData (index : Int)  {
        if(index == 0){
            innerView.backgroundColor = appThemeColor
            lblTitle.text = "Delivers under 30 mins"
            imgView.image = UIImage.init(named: "Delivery")
        } else if(index == 1){
            innerView.backgroundColor = appPurpleColor
              lblTitle.text = "Restaurants offering pick up"
            imgView.image = UIImage.init(named: "pickup")
            
        } else {
            innerView.backgroundColor = appYellowColor
              lblTitle.text = "Restaurants offering dine in"
            lblTitle.textColor = .black
            imgView.image = UIImage.init(named: "DineIn")
        }
    }

}
