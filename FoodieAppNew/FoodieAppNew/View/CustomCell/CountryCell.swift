

import UIKit

class CountryCell: UITableViewCell {

    @IBOutlet weak var btnView: KGRadioButton!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var lblCountryName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

       
    }
    
}
