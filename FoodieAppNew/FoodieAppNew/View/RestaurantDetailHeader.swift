

import UIKit
@objc protocol ResDetailHeaderDelegate {
    func backClicked()
    func infoClicked()
    
}
class RestaurantDetailHeader: UIView , UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var lblResName: UILabel!
    @IBOutlet weak var lblCost: UILabel!
    @IBOutlet weak var lblCusines: UILabel!
    @IBOutlet weak var lblRating: UILabel!
    @IBOutlet weak var contaainerView: UIView!
    
    var delegate :  ResDetailHeaderDelegate? = nil
    
    class func instanceFromNib() -> UIView {
        return UINib(nibName: "RestaurantDetailHeader", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! UIView
    }
    
    func setData ()  {
        contaainerView.layer.cornerRadius = 20
        contaainerView.clipsToBounds = true
        contaainerView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        collectionView.register(UINib(nibName: "CusinesCell", bundle: nil), forCellWithReuseIdentifier: "CusinesCell")
        collectionView.reloadData()
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell : CusinesCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CusinesCell", for: indexPath) as! CusinesCell
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let lbl = UILabel()
        lbl.text = "Burger"
        lbl.sizeToFit()
        return CGSize(width: lbl.frame.width + 5, height: 25)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func infoClicked(_ sender: Any) {
        if(delegate != nil){
            self.delegate?.infoClicked()
        }
    }
    @IBAction func favouriteClicked(_ sender: Any) {
    }
    @IBAction func bckClicked(_ sender: Any) {
        if(delegate != nil){
            self.delegate?.backClicked()
        }
    }
}
