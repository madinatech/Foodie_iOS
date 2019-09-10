

import UIKit

class WelcomeVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var pageView: UIPageControl!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var timer = Timer()
    
    class func initViewController() -> WelcomeVC {
        let vc = WelcomeVC.init(nibName: "WelcomeVC", bundle: nil)
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        collectionView.register(UINib(nibName: "WelcomeCell", bundle: nil), forCellWithReuseIdentifier: "WelcomeCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
         UIApplication.shared.statusbarView?.backgroundColor = .clear
        startTimer()
    }
    
    func startTimer() {
        timer =  Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(self.scrollAutomatically), userInfo: nil, repeats: true)
    }
    
    @objc func scrollAutomatically(_ timer1: Timer) {
        if let coll  = collectionView {
            for cell in coll.visibleCells {
                let indexPath: IndexPath? = coll.indexPath(for: cell)
                if ((indexPath?.row)! < 2){
                    let indexPath1: IndexPath?
                    indexPath1 = IndexPath.init(row: (indexPath?.row)! + 1, section: (indexPath?.section)!)
                    coll.scrollToItem(at: indexPath1!, at: .right, animated: true)
                } else{
                    let indexPath1: IndexPath?
                    indexPath1 = IndexPath.init(row: 0, section: (indexPath?.section)!)
                    coll.scrollToItem(at: indexPath1!, at: .left, animated: true)
                }
            }
        }
    }

    @IBAction func setDeliveryClicked(_ sender: Any) {
        timer.invalidate()
        let vc = DeliveryLoactionVC.initViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func loginClicked(_ sender: Any) {
        timer.invalidate()
        let vc = LoginVc.initViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell : WelcomeCell = collectionView.dequeueReusableCell(withReuseIdentifier: "WelcomeCell", for: indexPath) as! WelcomeCell
        if(indexPath.row == 0){
            cell.imgView.image = UIImage.init(named: "111")
        } else if(indexPath.row == 1){
            cell.imgView.image = UIImage.init(named: "222")
        } else {
            cell.imgView.image = UIImage.init(named: "333")
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        pageView.currentPage = indexPath.row
    }
}
