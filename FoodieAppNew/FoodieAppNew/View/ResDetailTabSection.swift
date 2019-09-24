

import UIKit

@objc protocol ResDetailTabSectionDelegate {
    func tabClicked(selectedTab : Int)
}
class ResDetailTabSection: UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var conainView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    var delegate :  ResDetailTabSectionDelegate? = nil
    var selectedIndex = Int()
    var swipeType = String()
    var menuArray  = [Menu]()
    
    class func instanceFromNib() -> UIView {
        return UINib(nibName: "ResDetailTabSection", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! UIView
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func setData (sTab : Int, swipeType: String, restaurant : Restaurant)  {
        menuArray = restaurant.menus.allObjects as! [Menu]
        menuArray = menuArray.sorted(by: {
            ($0.name!.localizedLowercase) <
                ($1.name!.localizedLowercase)
        } )
        
        selectedIndex = sTab
        self.swipeType = swipeType
        conainView.layer.cornerRadius = 20
        conainView.clipsToBounds = true
        conainView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "TabCell", bundle: nil), forCellWithReuseIdentifier: "TabCell")
        collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        //        if(swipeType == "Right"){
        //            if (selectedIndex  < 10){
        //                var indexPath1 = IndexPath.init(row: selectedIndex , section: 0)
        //                if(selectedIndex == 9){
        //                    indexPath1 = IndexPath.init(row: selectedIndex, section: 0)
        //                }
        //                collectionView.scrollToItem(at: indexPath1, at: .right, animated: true)
        //            }
        //        } else {
        //            if (selectedIndex  > 0){
        //                var indexPath1 = IndexPath.init(row: selectedIndex , section: 0)
        //                if(selectedIndex == 0){
        //                    indexPath1 = IndexPath.init(row: selectedIndex, section: 0)
        //                }
        //                collectionView.scrollToItem(at: indexPath1, at: .left, animated: true)
        //            }
        //        }
        //
        let indexPath1 = IndexPath.init(row: selectedIndex , section: 0)
        collectionView.scrollToItem(at: indexPath1, at: .left, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return menuArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell : TabCell = collectionView.dequeueReusableCell(withReuseIdentifier: "TabCell", for: indexPath) as! TabCell
        cell.lblItem.textColor = .lightGray
        cell.lineView.backgroundColor = .clear
        if(indexPath.row == selectedIndex){
            cell.lineView.backgroundColor = appPurpleColor
            cell.lblItem.textColor = appPurpleColor
        }
        let menu : Menu = menuArray[indexPath.row]
        cell.lblItem.text = menu.name
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let menu : Menu = menuArray[indexPath.row]
        let lbl = UILabel()
        lbl.text = menu.name
        lbl.sizeToFit()
        return CGSize(width: lbl.frame.width + 5, height: 40)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        selectedIndex = indexPath.row
        collectionView.reloadData()
        if(delegate != nil){
            self.delegate?.tabClicked(selectedTab: indexPath.row)
        }
        
    }
}
