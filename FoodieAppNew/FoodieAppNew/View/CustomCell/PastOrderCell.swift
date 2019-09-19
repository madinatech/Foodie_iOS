

import UIKit

class PastOrderCell: UITableViewCell {

    @IBOutlet weak var lblResName: UILabel!
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var lblAmount: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblItem: UILabel!
    @IBOutlet weak var btnReOrder: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
        btnReOrder.layer.borderWidth = 1
        btnReOrder.layer.borderColor = appThemeColor.cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
