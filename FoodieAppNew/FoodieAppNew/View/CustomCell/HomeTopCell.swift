

import UIKit

class HomeTopCell: UICollectionViewCell, UIGestureRecognizerDelegate {
    
    @IBOutlet weak var innerView: UIView!
    @IBOutlet weak var lblOptions: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var backView: UIView!
    var showingBack : Bool = true
    var selectedIndex = Int()
    override func awakeFromNib() {
        super.awakeFromNib()
        let singleTap = UITapGestureRecognizer(target: self, action:#selector(handleTap(_:)))
        singleTap.numberOfTouchesRequired = 1
        singleTap.delegate = self
        self.contentView.addGestureRecognizer(singleTap)
       
    }
    
    func setData (index : Int)  {
        backView.isHidden = true
        innerView.isHidden = false
        if(index == 0){
            innerView.backgroundColor = appThemeColor
            lblTitle.text = "Under 30 mins"
            imgView.image = UIImage.init(named: "Delivery")
        } else if(index == 1){
            innerView.backgroundColor = appPurpleColor
            lblTitle.text = "Pick up"
            imgView.image = UIImage.init(named: "pickup")
            
        } else {
            innerView.backgroundColor = appYellowColor
            lblTitle.text = "Dine in"
            lblTitle.textColor = .black
            lblOptions.textColor = .black
            imgView.image = UIImage.init(named: "DineIn")
        }
    }
    
//    func selectedIndex(index : Int)  {
//        selectedIndex = index
//    let singleTap = UITapGestureRecognizer(target: self, action:#selector(handleTap(_:)))
//    singleTap.numberOfTouchesRequired = 1
//    singleTap.delegate = self
//    self.contentView.addGestureRecognizer(singleTap)
//    }
    
    
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        let transitionOptions: UIView.AnimationOptions = [.transitionFlipFromTop, .showHideTransitionViews]
        if showingBack {
            NSLog("showBack")
            UIView.transition(from: backView, to: innerView, duration: 0.5, options: transitionOptions, completion: nil)
            showingBack = false
            backView.isHidden = false
            innerView.isHidden = true
        } else {
            UIView.transition(from: innerView, to: backView, duration: 0.5, options: transitionOptions, completion: nil)
            showingBack = true
            backView.isHidden = true
            innerView.isHidden = false
        }
    }
    
}
