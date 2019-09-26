

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
    func setData(item : Items)  {
    
        let priceArray : [Price] = item.price.allObjects as! [Price]
        if(priceArray.count > 0){
            let price : Price = priceArray[0]
            lblTotal.text = "TZS \(price.price)"
        }
    }
}
