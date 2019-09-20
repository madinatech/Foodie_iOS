
import UIKit

class ProfileCell: UITableViewCell {

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

       
    }
    
    func setData (index : Int, section : Int)  {
        if(section == 0 && index == 0){
            lblTitle.text = "Manage Addresses"
            imgView.image = UIImage.init(named: "Home_red")
        } else if(section == 0 && index == 1){
            lblTitle.text = "My Favourites"
             imgView.image = UIImage.init(named: "Fav")
        } else if(section == 1 && index == 0){
            lblTitle.text = "Settings"
             imgView.image = UIImage.init(named: "Setting")
        }else if(section == 1 && index == 1){
            lblTitle.text = "Invite a Friend"
             imgView.image = UIImage.init(named: "Invite")
        }else if(section == 1 && index == 2){
            lblTitle.text = "Help"
             imgView.image = UIImage.init(named: "Help")
        }
    }
    
}
