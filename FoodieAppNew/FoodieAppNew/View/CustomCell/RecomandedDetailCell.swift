

import UIKit

@objc protocol RecommendedHeightDelegate {
    func updateHeight(height: CGFloat)
    func reloadCollectionData (addArray : NSMutableArray,  minusArray : NSMutableArray , plusArray : NSMutableArray)
     func reloadCollectionData ()
}

class RecomandedDetailCell: UITableViewCell,UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var collectionHeight: NSLayoutConstraint!
    @IBOutlet weak var collectionView: UICollectionView!
    var delegate :  RecommendedHeightDelegate? = nil
    var addItemssArray = NSMutableArray()
    var plusItemssArray = NSMutableArray()
    var minusItemssArray = NSMutableArray()
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.register(UINib(nibName: "RestaurnatRecommendedCell", bundle: nil), forCellWithReuseIdentifier: "RestaurnatRecommendedCell")
        setHeight()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

       
    }
    
    func setHeight ()  {
        collectionView.reloadData()
        collectionHeight.constant = collectionView.contentSize.height
        self.collectionView.layoutIfNeeded()
        self.contentView.layoutIfNeeded()
        if(collectionView.contentSize.height > 165){
            if(delegate != nil){
                self.delegate?.updateHeight(height: collectionHeight.constant)
            }
        }
    }
    func setData(addArray : NSMutableArray,  minusArray : NSMutableArray , plusArray : NSMutableArray) {
        addItemssArray = addArray
        minusItemssArray = minusArray
        plusItemssArray = plusArray
        collectionView.reloadData()
        if(delegate != nil){
            self.delegate?.reloadCollectionData()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell : RestaurnatRecommendedCell = collectionView.dequeueReusableCell(withReuseIdentifier: "RestaurnatRecommendedCell", for: indexPath) as! RestaurnatRecommendedCell
        cell.btnAdd.tag = indexPath.row
        cell.btnPlus.tag = indexPath.row
        cell.btnMinus.tag = indexPath.row
        cell.btnAdd.addTarget(self, action: #selector(addClicked(_:)), for: .touchUpInside)
        cell.btnPlus.addTarget(self, action: #selector(plusClicked(_:)), for: .touchUpInside)
        cell.btnMinus.addTarget(self, action: #selector(minusClicked(_:)), for: .touchUpInside)
        cell.addView.isHidden = true
        cell.btnAdd.isHidden = false
        
        if(addItemssArray.contains(indexPath.row)){
            cell.btnAdd.isHidden = true
            cell.addView.isHidden = false
            cell.lblItemCount.text = "0"
        }
        
        for index in plusItemssArray{
            let i : Int = index as! Int
            if(indexPath.row == i){
                var a : Int = Int((cell.lblItemCount.text)!)!
                a = a + 1
                cell.lblItemCount.text = "\(a)"
            }
        }
        for index in minusItemssArray{
            let i : Int = index as! Int
            if(indexPath.row == i){
                var a : Int = Int((cell.lblItemCount.text)!)!
                a = a - 1
                if(a == 0){
                    cell.addView.isHidden = true
                    cell.btnAdd.isHidden = false
                    addItemssArray.remove(indexPath.row)
                    minusItemssArray.remove(indexPath.row)
                    plusItemssArray.remove(indexPath.row)
                }
                cell.lblItemCount.text = "\(a)"
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let size  = collectionView.frame.width - 20
        return CGSize(width: size / 2, height: 200)
        
    }
    
    @IBAction func addClicked(_ sender: UIButton) {
        addItemssArray.add(sender.tag)
        plusItemssArray.add(sender.tag)
//        UIView.setAnimationsEnabled(false)
        collectionView.reloadData()
        if(delegate != nil){
            self.delegate?.reloadCollectionData(addArray: addItemssArray, minusArray: minusItemssArray, plusArray: plusItemssArray)
        }
    }
    
    @IBAction func plusClicked(_ sender: UIButton) {
        plusItemssArray.add(sender.tag)
//        UIView.setAnimationsEnabled(false)
        collectionView.reloadData()
        if(delegate != nil){
          self.delegate?.reloadCollectionData(addArray: addItemssArray, minusArray: minusItemssArray, plusArray: plusItemssArray)
        }
    }
    
    @IBAction func minusClicked(_ sender: UIButton) {
        minusItemssArray.add(sender.tag)
//        UIView.setAnimationsEnabled(false)
        collectionView.reloadData()
        if(delegate != nil){
           self.delegate?.reloadCollectionData(addArray: addItemssArray, minusArray: minusItemssArray, plusArray: plusItemssArray)
        }
    }
}
