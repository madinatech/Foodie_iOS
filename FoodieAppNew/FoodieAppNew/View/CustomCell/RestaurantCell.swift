

import UIKit

class RestaurantCell: UITableViewCell {

    @IBOutlet weak var innerView: UIView!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblCusines: UILabel!
    @IBOutlet weak var lblDiscount: UILabel!
    @IBOutlet weak var lblRating: UILabel!
    @IBOutlet weak var lblAmount: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
      innerView.dropShadow()
        
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

       
    }
    
}
