
import UIKit
import Kingfisher

class FavouriteCell: UITableViewCell {
    
    @IBOutlet weak var innerView: UIView!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblCusines: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblRating: UILabel!
    @IBOutlet weak var lblAmount: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        innerView.dropShadow()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        
    }
    
    func showData(restaurant: Restaurant)  {
        lblName.text = restaurant.name
        lblRating.text = "\(restaurant.average_rating)"
        lblAmount.text = "\(restaurant.cost_for_two ) for 2"
        lblTime.text = "\(restaurant.delivery_time) min"
        let cusines : [Cusines] = restaurant.cuisines.allObjects as! [Cusines]
        var cusinesNameArray = [String]()
        for cusine in cusines{
            cusinesNameArray.append(cusine.name ?? "")
        }
        cusinesNameArray.sort()
        let joined = cusinesNameArray.joined(separator: " • ")
        
        lblCusines.text = joined
        let url = URL(string: restaurant.images?.display ?? "")
        imgView.kf.indicatorType = .activity
        imgView.kf.setImage(with: url, placeholder: nil, options: nil, progressBlock: { (size1, size2) in
            
        }, completionHandler: { (image, error, cache, url) in
            if image != nil{
                self.imgView.image = image
            }
        })
    }
    
}
