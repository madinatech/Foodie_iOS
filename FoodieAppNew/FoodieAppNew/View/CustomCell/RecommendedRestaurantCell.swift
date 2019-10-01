
import UIKit

@objc protocol RecommendedDelegate {
    func navigatetoDetail()
}

class RecommendedRestaurantCell: UITableViewCell,UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var delegate :  RecommendedDelegate? = nil
    var selectedIndex = IndexPath()
    override func awakeFromNib() {
        super.awakeFromNib()
        
//        collectionView.register(UINib(nibName: "RecommendedCell", bundle: nil), forCellWithReuseIdentifier: "RecommendedCell")
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
        cell.setData(index: indexPath.row)
        if(indexPath == selectedIndex){
//            cell.selectedIndex(index: indexPath.row)
        } else{
            cell.backView.isHidden = true
            cell.innerView.isHidden = false
//             cell.setData(index: indexPath.row)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        
        return CGSize(width: 120, height: 150)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        selectedIndex = indexPath
        collectionView.reloadItems(at: [indexPath])
        
      
        
//        collectionView.reloadData()
//        if(delegate != nil){
//            self.delegate?.navigatetoDetail()
//
//        }
        
    }
    
}
