

import UIKit
@objc protocol SearchCategoryCellDelegate {
    func updateHeight(height: CGFloat)
}


class SearchCategoryCell: UITableViewCell,UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var collectionView: UICollectionView!
    var delegate :  SearchCategoryCellDelegate? = nil
     var cusinesArray = [Cusines]()
    
     @IBOutlet weak var collectionHeight: NSLayoutConstraint!
    override func awakeFromNib() {
        super.awakeFromNib()
         collectionView.register(UINib(nibName: "SearchCollCell", bundle: nil), forCellWithReuseIdentifier: "SearchCollCell")
        cusinesArray = Cusines.getAll()
        collectionView.reloadData()
        setHeight()
    }
    func setHeight ()  {
        collectionView.reloadData()
        collectionHeight.constant = collectionView.contentSize.height
        self.collectionView.layoutIfNeeded()
        self.contentView.layoutIfNeeded()
        if(collectionView.contentSize.height > 130){
            if(delegate != nil){
                self.delegate?.updateHeight(height: collectionHeight.constant)
            }
        }
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cusinesArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell : SearchCollCell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchCollCell", for: indexPath) as! SearchCollCell
        cell.contentView.layer.cornerRadius = 20
        let cusine = cusinesArray[indexPath.row]
        cell.setData(cusines: cusine)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        collectionView.frame.width / 2 - 5
        
        return CGSize(width: 160, height: 90)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        
    }
    
}
