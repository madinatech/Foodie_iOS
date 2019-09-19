

import UIKit

class RestaurantDetailCell: UITableViewCell {

   
    
    @IBOutlet weak var innerView: UIView!
    @IBOutlet weak var lblAmount: UILabel!
    @IBOutlet weak var lblDesc: UILabel!
    @IBOutlet weak var lbItem: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
   
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    

}
