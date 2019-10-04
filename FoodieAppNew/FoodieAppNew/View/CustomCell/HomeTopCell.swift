

import UIKit

@objc protocol HomeTopCellDelegate {
    func optionClicked(selectedIndex : Int)
}

class HomeTopCell: UICollectionViewCell, UIGestureRecognizerDelegate {
    
    @IBOutlet weak var innerView: UIView!
    @IBOutlet weak var lblOptions: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var backView: UIView!
    var showingBack : Bool = true
    var selectedIndex = Int()
     var delegate :  HomeTopCellDelegate? = nil
    
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
        lblTitle.textColor = .white
        lblOptions.textColor = .white
        if(index == 0){
            self.contentView.tag = index
            innerView.backgroundColor = appThemeColor
            lblTitle.text = "Under 30 mins"
            imgView.image = UIImage.init(named: "Delivery")
        } else if(index == 1){
             self.contentView.tag = index
            innerView.backgroundColor = appPurpleColor
            lblTitle.text = "Pick up"
            imgView.image = UIImage.init(named: "pickup")
            
        } else {
             self.contentView.tag = index
            innerView.backgroundColor = appYellowColor
            lblTitle.text = "Dine in"
            lblTitle.textColor = .black
            lblOptions.textColor = .black
            imgView.image = UIImage.init(named: "DineIn")
        }
    }
    
    func showSelectedData (index : Int)  {
         let transitionOptions: UIView.AnimationOptions = [.transitionFlipFromTop, .showHideTransitionViews]
        if(self.contentView.tag == index){
            UIView.transition(from: backView, to: innerView, duration: 0.5, options: transitionOptions, completion: nil)
            backView.isHidden = false
            innerView.isHidden = true
        } else {
            backView.isHidden = true
            innerView.isHidden = false
            lblTitle.textColor = .white
            lblOptions.textColor = .white
            if(contentView.tag == 2){
                lblTitle.textColor = .black
                lblOptions.textColor = .black
            }
        }
    }
    
    
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        let transitionOptions: UIView.AnimationOptions = [.transitionFlipFromTop, .showHideTransitionViews]
        print("ViewTap: \(contentView.tag)")
//        if showingBack {
//            NSLog("showBack")
//            UIView.transition(from: backView, to: innerView, duration: 0.5, options: transitionOptions, completion: nil)
//            showingBack = false
//            backView.isHidden = false
//            innerView.isHidden = true
//        } else {
//            UIView.transition(from: innerView, to: backView, duration: 0.5, options: transitionOptions, completion: nil)
//            showingBack = true
//            backView.isHidden = true
//            innerView.isHidden = false
//        }
    
//        selectedIndex = contentView.tag
        
        
        if(delegate != nil){
           self.delegate?.optionClicked(selectedIndex: contentView.tag)
        }
    }
    
}
