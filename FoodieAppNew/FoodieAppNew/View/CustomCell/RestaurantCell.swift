

import UIKit
import AMShimmer
import Kingfisher

class RestaurantCell: UITableViewCell {
    
    @IBOutlet weak var innerView: UIView!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblCusines: UILabel!
    @IBOutlet weak var lblRating: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblAmount: UILabel!
    @IBOutlet weak var imgBag: UIImageView!
    @IBOutlet weak var imgTable: UIImageView!
    @IBOutlet weak var timeView: UIView!
    @IBOutlet weak var imgScooter: UIImageView!
    @IBOutlet weak var imgStar: UIImageView!
    @IBOutlet weak var lblClosedRest: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        innerView.dropShadow()
        lblClosedRest.isHidden = true
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        
    }
    func hideLoader ()  {
         timeView.backgroundColor = appBlackColor
            AMShimmer.stop(for:  self.imgView)
            AMShimmer.stop(for:  self.lblName)
            AMShimmer.stop(for: self.lblCusines)
            AMShimmer.stop(for:  self.lblRating)
            AMShimmer.stop(for:  self.lblTime)
            AMShimmer.stop(for:  self.lblAmount)
            AMShimmer.stop(for:  self.imgBag)
            AMShimmer.stop(for:  self.imgTable)
            AMShimmer.stop(for:  self.timeView)
            AMShimmer.stop(for:  self.imgScooter)
            AMShimmer.stop(for:  self.imgStar)
        
    }
    
    func showLoader ()  {
        timeView.backgroundColor = .clear
        AMShimmer.start(for: imgView)
        AMShimmer.start(for: lblName)
        AMShimmer.start(for: lblCusines)
        AMShimmer.start(for: lblRating)
        AMShimmer.start(for: lblTime)
        AMShimmer.start(for: lblAmount)
        AMShimmer.start(for: imgBag)
        AMShimmer.start(for: imgTable)
        AMShimmer.start(for: timeView)
        AMShimmer.start(for: imgScooter)
        AMShimmer.start(for: imgStar)
    }
    
    func showData(restaurant: Restaurant, offerIndex : Int)  {
        lblName.text = restaurant.name
        lblRating.text = "\(restaurant.average_rating)"
        lblAmount.text = "\(restaurant.cost_for_two ) for 2"
        lblTime.text = "\(restaurant.delivery_time) min"
        let cusines : [Cusines] = restaurant.cuisines.allObjects as! [Cusines]
        var cusinesNameArray = [String]()
        for cusine in cusines{
            if(!cusinesNameArray.contains(cusine.name ?? "")){
            cusinesNameArray.append(cusine.name ?? "")
            }
        }
        cusinesNameArray.sort()
        let joined = cusinesNameArray.joined(separator: " • ")
    
        lblCusines.text = joined
        let url = URL(string: restaurant.images?.display ?? "")
//        imgView.kf.indicatorType = .none
         AMShimmer.start(for: imgView)
        imgView.kf.setImage(with: url, placeholder: nil, options: nil, progressBlock: { (size1, size2) in
            
        }, completionHandler: { (image, error, cache, url) in
            if image != nil{
                  AMShimmer.stop(for:  self.imgView)
                self.imgView.image = image
                if(restaurant.is_closed == true){
                    Utils.grayScaleEffect(originalImage: self.imgView)
                    Utils.grayScaleEffect(originalImage: self.imgStar)
                    self.imageView?.layer.cornerRadius = 10
                }
            }
        })
        
        timeView.isHidden = false
        lblClosedRest.isHidden = true
        if(restaurant.is_closed == true){
            timeView.isHidden = true
            lblClosedRest.isHidden = false
            let openingTimes  : [OpeningTimes] = restaurant.opening_times.allObjects as! [OpeningTimes]
            for openTime in openingTimes{
                if(DateUtils.getNextDayOfTodayWeekDay() == openTime.day){
                    lblClosedRest.text = "Closed - Opens next at \(DateUtils.getStringFormat(str: openTime.opening_time ?? "")) tomorrow"
                }
            }
        }
        
        if(offerIndex == 0){
            imgScooter.image = UIImage.init(named: "scooter")
            lblTime.text = "\(restaurant.delivery_time) min"
        } else if(offerIndex == 1){
            imgScooter.image = UIImage.init(named: "pickup")
            lblTime.text = "\(restaurant.preparation_time) min"
        } else if(offerIndex == 2){
            imgScooter.image = UIImage.init(named: "DineIn")
            lblTime.text = "\(restaurant.preparation_time) min"
        }
    }
    
    
}
