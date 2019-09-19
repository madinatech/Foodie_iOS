
import UIKit

class BillDetailCell: UITableViewCell {

    @IBOutlet weak var lblItemTotal: UILabel!
    @IBOutlet weak var lblResCharge: UILabel!
    @IBOutlet weak var lblTotalDescount: UILabel!
    @IBOutlet weak var lblDeliveryFee: UILabel!
    @IBOutlet weak var lblTotalPay: UILabel!
    @IBOutlet weak var lblSaved: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
