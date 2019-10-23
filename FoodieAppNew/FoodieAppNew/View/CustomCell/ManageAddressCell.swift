

import UIKit

class ManageAddressCell: UITableViewCell {

   
    @IBOutlet weak var lblType: UILabel!
    @IBOutlet weak var innerView: UIView!
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var lblAddress2: UILabel!
    @IBOutlet weak var btnRadio: KGRadioButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
      innerView.dropShadow()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

      
    }
    
    func setData (address : Address)  {
        lblType.text = address.address_type
        lblAddress.text = address.address
        lblAddress2.text = "\(address.town ?? "") , \(address.city_name ?? "")"
    }
    
}
