

import UIKit
import Kingfisher
import AMShimmer
@objc protocol ResDetailHeaderDelegate {
    func backClicked()
    func infoClicked()
    func showLoginView()
}
class RestaurantDetailHeader: UIView , UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lblResName: UILabel!
    @IBOutlet weak var lblCost: UILabel!
    @IBOutlet weak var lblRating: UILabel!
    @IBOutlet weak var contaainerView: UIView!
    @IBOutlet weak var lblOpen: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var imgScooter: UIImageView!
    @IBOutlet weak var btnFav: UIButton!
    
    var delegate :  ResDetailHeaderDelegate? = nil
    var rest = Restaurant()
    var cusinesArray = [Cusines]()
    var openingTimes = [OpeningTimes]()
    
    class func instanceFromNib() -> UIView {
        return UINib(nibName: "RestaurantDetailHeader", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! UIView
    }
    
    func setData (restaurat : Restaurant, offerIndex : Int)  {
        rest = restaurat
        showData(offerIndex: offerIndex)
        contaainerView.layer.cornerRadius = 20
        contaainerView.clipsToBounds = true
        contaainerView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        collectionView.register(UINib(nibName: "CusinesCell", bundle: nil), forCellWithReuseIdentifier: "CusinesCell")
        collectionView.reloadData()
    }
    func showData (offerIndex : Int) {
        cusinesArray = rest.cuisines.allObjects as! [Cusines]
        cusinesArray = cusinesArray.sorted(by: {
            ($0.name!.localizedLowercase) <
                ($1.name!.localizedLowercase)
        } )
        openingTimes = rest.opening_times.allObjects as! [OpeningTimes]
//        collectionView.reloadData()
        lblResName.text = rest.name
        lblRating.text = "\(rest.average_rating)"
        lblCost.text = "\(rest.cost_for_two ) for 2"
        
        if(offerIndex == 0){
            imgScooter.image = UIImage.init(named: "scooter")
            lblTime.text = "\(rest.delivery_time) min"
        } else if(offerIndex == 1){
            imgScooter.image = UIImage.init(named: "pickup")
            lblTime.text = "\(rest.preparation_time) min"
        } else if(offerIndex == 2){
            imgScooter.image = UIImage.init(named: "DineIn")
            lblTime.text = "\(rest.preparation_time) min"
        } else {
            imgScooter.image = UIImage.init(named: "scooter")
            lblTime.text = "\(rest.delivery_time) min"
        }

//        if(rest.isFavorite == true){
//            btnFav.isSelected = true
//        } else {
//            btnFav.isSelected = false
//        }
        
        lblTime.text = "\(rest.delivery_time) min"
        let url = URL(string: rest.images?.banner ?? "")
//        imgView.kf.indicatorType = .activity
//        AMShimmer.start(for: imgView)
        imgView.kf.setImage(with: url, placeholder: nil, options: nil, progressBlock: { (size1, size2) in
            
        }, completionHandler: { (image, error, cache, url) in
            if image != nil{
                AMShimmer.stop(for: self.imgView)
                self.imgView.image = image
            }
        })
        
        if(rest.is_closed == true){
             lblOpen.text = "Closed"
        } else {
            for openTime in openingTimes{
                if(DateUtils.getTodayWeekDay() == openTime.day){
                    lblOpen.text = "Open until \(DateUtils.getStringFormat(str: openTime.closing_time ?? ""))"
                }
            }
        }
       
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cusinesArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell : CusinesCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CusinesCell", for: indexPath) as! CusinesCell
        let cusines = cusinesArray[indexPath.row]
        cell.lblTag.text = cusines.name
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cusines = cusinesArray[indexPath.row]
        let lbl = UILabel()
        lbl.text = cusines.name
        lbl.sizeToFit()
        return CGSize(width: lbl.frame.width + 20, height: 25)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func infoClicked(_ sender: Any) {
        if(delegate != nil){
            self.delegate?.infoClicked()
        }
    }
    
    @IBAction func favouriteClicked(_ sender: UIButton) {
        if(sender.isSelected == true){
            sender.isSelected = false
//            rest.isFavorite = false
//            removeFavourite()
        } else {
            sender.isSelected = true
//            rest.isFavorite = true
            addFavourite()
        }
        
    }
    
    func addFavourite () {
        if(AccountManager.instance().activeAccount != nil){
            rest.addFavouriteResTaurant { (response, errorMessage) -> (Void) in
                if(errorMessage.count > 0){
                    Utils.showAlert(withMessage: errorMessage)
                }
            }
        } else {
            if(delegate != nil){
                self.delegate?.showLoginView()
            }
        }
    }
    
  
    
    @IBAction func bckClicked(_ sender: Any) {
        if(delegate != nil){
            self.delegate?.backClicked()
        }
    }
}
