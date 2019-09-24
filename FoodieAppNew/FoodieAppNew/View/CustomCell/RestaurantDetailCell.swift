

import UIKit

class RestaurantDetailCell: UITableViewCell {

   
    
    @IBOutlet weak var innerView: UIView!
    @IBOutlet weak var lblAmount: UILabel!
    @IBOutlet weak var lblDesc: UILabel!
    @IBOutlet weak var lbItem: UILabel!
  
    
    override func awakeFromNib() {
        super.awakeFromNib()
   
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    
    func showData (item : Items)  {
        lbItem.text = item.name
        lblDesc.text = item.desc
    }

}
