

import UIKit

class CustomizeTotalCell: UITableViewCell {

    @IBOutlet weak var lblItems: UILabel!
    @IBOutlet weak var lblTotal: UILabel!
    @IBOutlet weak var btnUpdateItem: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
}
