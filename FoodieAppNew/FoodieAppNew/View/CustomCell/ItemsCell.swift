
import UIKit

class ItemsCell: UITableViewCell {

    @IBOutlet weak var lblItem: UILabel!
    @IBOutlet weak var lblAmount: UILabel!
    @IBOutlet weak var lblItemCount: UILabel!
    @IBOutlet weak var btnDelete: UIButton!
    @IBOutlet weak var btnPlus: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    
    func showData (item : LocalCart){
        lblItem.text = item.item_name
        lblAmount.text = "Tzs \(item.item_price * item.item_quantity)"
        lblItemCount.text = "\(item.item_quantity)"
    }
}
