
import UIKit

@objc protocol RecommendedDelegate {
    func showOfferingData(index: Int, isInnerViewHidden: Bool)
}

class RecommendedRestaurantCell: UITableViewCell,UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout, HomeTopCellDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var delegate :  RecommendedDelegate? = nil
    var selectedIndex : Int = -1
    var selectedIndexes = NSMutableArray()
    var newAddedIndex : Int = -1
    var deliveryUnderArray = [Restaurant]()
    var dineInArray = [Restaurant]()
    var pickupArray = [Restaurant]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        deliveryUnderArray = Restaurant.getDeliveryUnder()
        dineInArray = Restaurant.getDineInRestaurants()
        pickupArray = Restaurant.getPickupRestaurants()
        collectionView.register(UINib(nibName: "HomeTopCell", bundle: nil), forCellWithReuseIdentifier: "HomeTopCell")
    }
   
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell : HomeTopCell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeTopCell", for: indexPath) as! HomeTopCell
        cell.delegate = self
//        if(isReloadData == false){
            cell.setData(index: indexPath.row)
//        }
        if(indexPath.row == 0){
            if(deliveryUnderArray.count <= 0){
                cell.lblOptions.text = "No options"
            } else if(deliveryUnderArray.count == 1){
                cell.lblOptions.text = "1 option"
            } else {
                cell.lblOptions.text = "\(deliveryUnderArray.count) options"
            }
        } else if(indexPath.row == 1){
            if(pickupArray.count <= 0){
                cell.lblOptions.text = "No options"
            } else if(pickupArray.count == 1){
                cell.lblOptions.text = "1 option"
            } else {
                cell.lblOptions.text = "\(pickupArray.count) options"
            }
        } else {
            if(dineInArray.count <= 0){
                cell.lblOptions.text = "No options"
            }else if(dineInArray.count == 1){
                cell.lblOptions.text = "1 option"
            } else {
                cell.lblOptions.text = "\(dineInArray.count) options"
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 120, height: 150)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
       
        
    }
    
    func optionClicked(selectedIndex: Int) {
        print("Niki")
        let indexPath = IndexPath.init(row: selectedIndex, section: 0)
        let cell : HomeTopCell = collectionView.cellForItem(at: indexPath) as! HomeTopCell
        
        if(cell.innerView.isHidden == true){
            let transitionOptions: UIView.AnimationOptions = [.transitionFlipFromBottom, .showHideTransitionViews]
            UIView.transition(from: cell.backView, to: cell.innerView, duration: 0.5, options: transitionOptions, completion: nil)
            cell.backView.isHidden = true
            cell.innerView.isHidden = false
        } else {
            let transitionOptions: UIView.AnimationOptions = [.transitionFlipFromTop, .showHideTransitionViews]
            UIView.transition(from: cell.innerView, to: cell.backView, duration: 0.5, options: transitionOptions, completion: nil)
            cell.backView.isHidden = false
            cell.innerView.isHidden = true
        }
        
        if(selectedIndex == 0){
            let indexPath1 = IndexPath.init(row: 1, section: 0)
            let cell1 : HomeTopCell = collectionView.cellForItem(at: indexPath1) as! HomeTopCell
            if(cell1.innerView.isHidden == true){
                let transitionOptions: UIView.AnimationOptions = [.transitionFlipFromBottom, .showHideTransitionViews]
                UIView.transition(from: cell1.backView, to: cell1.innerView, duration: 0.5, options: transitionOptions, completion: nil)
                cell1.backView.isHidden = true
                cell1.innerView.isHidden = false
            }
            let indexPath2 = IndexPath.init(row: 2, section: 0)
            let cell2 : HomeTopCell = collectionView.cellForItem(at: indexPath2) as! HomeTopCell
            if(cell2.innerView.isHidden == true){
                let transitionOptions: UIView.AnimationOptions = [.transitionFlipFromBottom, .showHideTransitionViews]
                UIView.transition(from: cell2.backView, to: cell2.innerView, duration: 0.5, options: transitionOptions, completion: nil)
                cell2.backView.isHidden = true
                cell2.innerView.isHidden = false
            }
        } else if(selectedIndex == 1){
            let indexPath1 = IndexPath.init(row: 0, section: 0)
            let cell1 : HomeTopCell = collectionView.cellForItem(at: indexPath1) as! HomeTopCell
            if(cell1.innerView.isHidden == true){
                let transitionOptions: UIView.AnimationOptions = [.transitionFlipFromBottom, .showHideTransitionViews]
                UIView.transition(from: cell1.backView, to: cell1.innerView, duration: 0.5, options: transitionOptions, completion: nil)
                cell1.backView.isHidden = true
                cell1.innerView.isHidden = false
            }
            let indexPath2 = IndexPath.init(row: 2, section: 0)
            let cell2 : HomeTopCell = collectionView.cellForItem(at: indexPath2) as! HomeTopCell
            if(cell2.innerView.isHidden == true){
                let transitionOptions: UIView.AnimationOptions = [.transitionFlipFromBottom, .showHideTransitionViews]
                UIView.transition(from: cell2.backView, to: cell2.innerView, duration: 0.5, options: transitionOptions, completion: nil)
                cell2.backView.isHidden = true
                cell2.innerView.isHidden = false
            }
        } else {
            let indexPath1 = IndexPath.init(row: 0, section: 0)
            let cell1 : HomeTopCell = collectionView.cellForItem(at: indexPath1) as! HomeTopCell
            if(cell1.innerView.isHidden == true){
                let transitionOptions: UIView.AnimationOptions = [.transitionFlipFromBottom, .showHideTransitionViews]
                UIView.transition(from: cell1.backView, to: cell1.innerView, duration: 0.5, options: transitionOptions, completion: nil)
                cell1.backView.isHidden = true
                cell1.innerView.isHidden = false
            }
            let indexPath2 = IndexPath.init(row: 1, section: 0)
            let cell2 : HomeTopCell = collectionView.cellForItem(at: indexPath2) as! HomeTopCell
            if(cell2.innerView.isHidden == true){
                let transitionOptions: UIView.AnimationOptions = [.transitionFlipFromBottom, .showHideTransitionViews]
                UIView.transition(from: cell2.backView, to: cell2.innerView, duration: 0.5, options: transitionOptions, completion: nil)
                cell2.backView.isHidden = true
                cell2.innerView.isHidden = false
            }
        }
        
        if(delegate != nil){
            let indexPath1 = IndexPath.init(row: selectedIndex, section: 0)
            let cell : HomeTopCell = collectionView.cellForItem(at: indexPath1) as! HomeTopCell
            self.delegate?.showOfferingData(index: selectedIndex, isInnerViewHidden: cell.innerView.isHidden)
        }
    }
    
}
