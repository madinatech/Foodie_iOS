
import UIKit
import Kingfisher
import SkeletonView

class FavouriteCell: UITableViewCell {
    
    @IBOutlet weak var innerView: UIView!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblCusines: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblRating: UILabel!
    @IBOutlet weak var lblAmount: UILabel!
    @IBOutlet weak var timeView: UIView!
    @IBOutlet weak var imgScooter: UIImageView!
    @IBOutlet weak var imgStar: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        innerView.dropShadow()
       
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func hideLoader(){
         timeView.backgroundColor = appBlackColor
//        lblName.hideSkeleton()
//        lblCusines.hideSkeleton()
//        lblTime.hideSkeleton()
//        lblRating.hideSkeleton()
//        lblAmount.hideSkeleton()
//        timeView.hideSkeleton()
//        imgScooter.hideSkeleton()
//        imgStar.hideSkeleton()
    }
    
    func showLoader ()  {
            timeView.backgroundColor = .clear
        imgView.showAnimatedGradientSkeleton()
               lblName.showAnimatedGradientSkeleton()
               lblCusines.showAnimatedGradientSkeleton()
               lblTime.showAnimatedGradientSkeleton()
               lblRating.showAnimatedGradientSkeleton()
               lblAmount.showAnimatedGradientSkeleton()
               timeView.showAnimatedGradientSkeleton()
               imgScooter.showAnimatedGradientSkeleton()
               imgStar.showAnimatedGradientSkeleton()
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
                self.imgView.hideSkeleton()
                self.imgView.image = image
            }
        })
//        removeSkleton()
    }
    
}
