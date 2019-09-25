

import UIKit

class RestaurantDetailCell: UITableViewCell {
    @IBOutlet weak var imgType: UIImageView!
    @IBOutlet weak var innerView: UIView!
    @IBOutlet weak var lblAmount: UILabel!
    @IBOutlet weak var lblDesc: UILabel!
    @IBOutlet weak var lbItem: UILabel!
    @IBOutlet weak var btnAdd: UIButton!
    @IBOutlet weak var btnDelete: UIButton!
    @IBOutlet weak var btnPlus: UIButton!
    @IBOutlet weak var lblQuantity: UILabel!
    @IBOutlet weak var addView: UIView!
    @IBOutlet weak var lblCustomizable: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    
    func showData (item : Items)  {
        lbItem.text = item.name
        lblDesc.text = item.desc
        let priceArray : [Price] = item.price.allObjects as! [Price]
        if(priceArray.count > 0){
            let price : Price = priceArray[0]
            lblAmount.text = "TZS \(price.price)"
        }
        
        if(item.item_type_code == "1"){
            imgType.image = UIImage.init(named: "Veg")
        } else {
            imgType.image = UIImage.init(named: "Nonveg")
        }
        
        if(item.customization_groups.allObjects.count == 0){
            lblCustomizable.isHidden = true
        }
    }
}
