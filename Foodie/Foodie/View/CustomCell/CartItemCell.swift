

import UIKit

class CartItemCell: UITableViewCell {
  @IBOutlet weak var lblItemName: UILabel!
     @IBOutlet weak var lblItemCount: UILabel!
     @IBOutlet weak var addView: UIView!
    @IBOutlet weak var btnMinus: UIButton!
    @IBOutlet weak var btnPlus: UIButton!
    @IBOutlet weak var lblDesc: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var btnCustomize: UIButton!
    @IBOutlet weak var img: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        addView.layer.borderWidth = 1
        addView.layer.borderColor = appLigtGrayColor.cgColor
        
    }
    
}
