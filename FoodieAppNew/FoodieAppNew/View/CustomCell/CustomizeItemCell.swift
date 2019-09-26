

import UIKit

class CustomizeItemCell: UITableViewCell {

    @IBOutlet weak var btnCose: UIButton!
    @IBOutlet weak var lblItemName: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(item : Items)  {
       lblItemName.text = item.name
        let priceArray : [Price] = item.price.allObjects as! [Price]
        if(priceArray.count > 0){
            let price : Price = priceArray[0]
            lblPrice.text = "TZS \(price.price)"
        }
    }
    
}
