
import UIKit

class CategoryCell: UITableViewCell  , UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var collectionHeight: NSLayoutConstraint!
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
        return cell
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
