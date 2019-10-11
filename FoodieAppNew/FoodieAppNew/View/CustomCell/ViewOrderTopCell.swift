

import UIKit

class ViewOrderTopCell: UITableViewCell {

    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var lblAddress2: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblRestName: UILabel!
    @IBOutlet weak var lblDeliverTo: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    func showData (cart : Cart)  {
        lblRestName.text = cart.restaurant_name
        lblTime.text = "\(cart.deliveryTime) min"
        var selectedAddress : Address = Address.getSelectedAddress()
        if(selectedAddress.entity_id != 0){
                   lblDeliverTo.text = selectedAddress.address_type
               } else {
                   selectedAddress = Address.getUserDefaultAddress(userID: Int(AccountManager.instance().activeAccount?.user_id ?? "") ?? 0)
                   if(selectedAddress.entity_id != 0){
                       lblDeliverTo.text = selectedAddress.address_type
                   }
               }
        
        lblDeliverTo.text = selectedAddress.address_type
        lblAddress.text = selectedAddress.address
        lblAddress2.text = "\(selectedAddress.town ?? "") , \(selectedAddress.city ?? "")"
    }
}
