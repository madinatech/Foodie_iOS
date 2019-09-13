
import UIKit

class AccountCell: UITableViewCell {

    @IBOutlet weak var imgImage: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setData (index : Int)  {
        if(index == 0){
            lblTitle.text = "Manage Address"
        } else if(index == 1){
            lblTitle.text = "Payment"
        } else if(index == 2){
            lblTitle.text = "Favourites"
        } else if(index == 3){
            lblTitle.text = "Refferals"
        }
//        else if(index == 4){
//            lblTitle.text = "Offers"
//        }
    }
    
}
