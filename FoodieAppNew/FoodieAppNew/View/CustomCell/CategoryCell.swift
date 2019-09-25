
import UIKit

class CategoryCell: UITableViewCell  , UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionHeight: NSLayoutConstraint!
    var selectedCusines = NSMutableArray()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.register(UINib(nibName: "CusinesCell", bundle: nil), forCellWithReuseIdentifier: "CusinesCell")
        collectionView.reloadData()
    }
    
    func setData ()  {
        collectionView.reloadData()
        collectionHeight.constant = collectionView.contentSize.height
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell : CusinesCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CusinesCell", for: indexPath) as! CusinesCell
        cell.contentView.backgroundColor = appLigtGrayColor
        cell.lblTag.textColor = UIColor.lightGray
        if(selectedCusines.contains(indexPath.row)){
            cell.lblTag.textColor = appThemeColor
            cell.contentView.backgroundColor = UIColor.init(red: 244.0/255.0, green: 200.0/255.0, blue: 203.0/255.0, alpha: 1.0)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        print("Niki")
        if(selectedCusines.contains(indexPath.row)){
            selectedCusines.remove(indexPath.row)
        } else {
            selectedCusines.add(indexPath.row)
        }
        collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let lbl = UILabel()
        lbl.text = "Fast Food"
        lbl.sizeToFit()
        return CGSize(width: lbl.frame.width + 5, height: 25)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        
    }
    
}
