

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
         let selectedIndexPath = IndexPath(item: sTab, section: 0)
        collectionView.selectItem(at: selectedIndexPath, animated: false, scrollPosition: .centeredHorizontally)
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
//        let selectedIndexPath = IndexPath(item: selectedIndex, section: 0)
//        collectionView.selectItem(at: selectedIndexPath, animated: false, scrollPosition: .centeredHorizontally)
//        collectionView.scrollToItem(at: selectedIndexPath, at: .left, animated: true)
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
        return CGSize(width: lbl.frame.width + 10, height: 40)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        if(indexPath.row == 0){
            collectionView.scrollToItem(at: IndexPath.init(row: indexPath.row + 1, section: indexPath.section), at: .right, animated: true)
        } else if(indexPath.row == menuArray.count - 1){
            collectionView.scrollToItem(at: IndexPath.init(row: indexPath.row , section: indexPath.section), at: .right, animated: true)
        } else {
            collectionView.scrollToItem(at: IndexPath.init(row: indexPath.row - 1, section: indexPath.section), at: .centeredHorizontally, animated: true)
        }
        selectedIndex = indexPath.row
        collectionView.reloadData()
        if(delegate != nil){
            self.delegate?.tabClicked(selectedTab: indexPath.row)
        }
        
    }
}
