
import UIKit
@objc protocol categoryCellDelegate {
    func updateHeight(height: CGFloat)
    func selectedCusines(cusinesArray : [String])
}

class CategoryCell: UITableViewCell  , UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionHeight: NSLayoutConstraint!
    var selectedCusines = NSMutableArray()
    var cusinesArray = [Cusines]()
      var delegate :  categoryCellDelegate? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.register(UINib(nibName: "CusinesCell", bundle: nil), forCellWithReuseIdentifier: "CusinesCell")
        collectionView.reloadData()
    }
    
    func setData (selectedCusines: [String])  {
        for cusinesName in selectedCusines{
            let cusines : Cusines = Cusines.getByName(name: cusinesName)
            if(cusines.name != nil){
                self.selectedCusines.add(cusines)
            }
        }
        cusinesArray = Cusines.getAll()
        collectionView.reloadData()
        collectionHeight.constant = collectionView.contentSize.height
       
        if(delegate != nil){
            self.delegate?.updateHeight(height: CGFloat(collectionView.numberOfItems(inSection: 0)))
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cusinesArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell : CusinesCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CusinesCell", for: indexPath) as! CusinesCell
        let cusine : Cusines = cusinesArray[indexPath.row]
        cell.lblTag.text = cusine.name
        
        cell.contentView.backgroundColor = appLigtGrayColor
        cell.lblTag.textColor = UIColor.lightGray
        if(selectedCusines.contains(cusine)){
            cell.lblTag.textColor = appThemeColor
            cell.contentView.backgroundColor = UIColor.init(red: 244.0/255.0, green: 200.0/255.0, blue: 203.0/255.0, alpha: 1.0)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        print("Niki")
          let cusine : Cusines = cusinesArray[indexPath.row]
        if(selectedCusines.contains(cusine)){
            selectedCusines.remove(cusine)
        } else {
            selectedCusines.add(cusine)
        }
        collectionView.reloadData()
        
        if(delegate != nil){
            var nameArray = [String]()
            for cusines in selectedCusines{
                let cusi : Cusines = cusines as! Cusines
                nameArray.append(cusi.name ?? "")
            }
            self.delegate?.selectedCusines(cusinesArray: nameArray)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
         let cusine : Cusines = cusinesArray[indexPath.row]
        let lbl = UILabel()
        lbl.text = cusine.name
        lbl.sizeToFit()
        return CGSize(width: lbl.frame.width + 20, height: 30)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        
    }
    
}
