

import UIKit

class ViewOrderTopCell: UITableViewCell {

    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var lblAddress2: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblRestName: UILabel!
    @IBOutlet weak var lblDeliverTo: UILabel!
   @IBOutlet weak var btnAddAddress: UIButton!
    @IBOutlet weak var addAddressHeight: NSLayoutConstraint!
    @IBOutlet weak var addressView: UIView!
    @IBOutlet weak var btnDeliverTo: UIButton!
    @IBOutlet weak var ingDropDown: UIImageView!
    
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
            lblAddress2.text = "\(selectedAddress.town ?? "") , \(selectedAddress.city_name ?? "")"
            if(selectedAddress.entity_id == 0){
                if(UserDefaults.standard.object(forKey: Selected_Area) != nil){
                     lblDeliverTo.text = Utils.fetchString(forKey: Selected_Area)
                }
               
                if(UserDefaults.standard.object(forKey: SelectedAddress1) != nil){
                    addAddressHeight.constant = 0
                           addressView.isHidden = true
                    lblAddress.text = Utils.fetchString(forKey: SelectedAddress1)
                               lblAddress2.text = Utils.fetchString(forKey: SelectedAddress2)
                } else {
                    addAddressHeight.constant = 50
                    addressView.isHidden = false
                }
            }
            let addressArray = Address.getAll()
            ingDropDown.isHighlighted = true
            if(addressArray.count > 0){
                ingDropDown.isHidden = false
            }
    }
}
