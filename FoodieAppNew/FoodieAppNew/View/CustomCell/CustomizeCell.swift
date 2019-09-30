

import UIKit

class CustomizeCell: UITableViewCell {

    @IBOutlet weak var btnCheck: UIButton!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
   
    
    override func awakeFromNib() {
        super.awakeFromNib()
     
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    
    }
    
    func setData(value : GroupValues)  {
        
        lblTitle.text = value.item_name
        lblPrice.text = "TZS \(value.item_price)"
    }
}
