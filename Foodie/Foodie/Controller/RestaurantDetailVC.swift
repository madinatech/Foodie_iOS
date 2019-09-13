

import UIKit
import SnapKit
import AMShimmer

class RestaurantDetailVC: BaseViewController,UITableViewDelegate, UITableViewDataSource, RecommendedHeightDelegate, RestaurantSearchDelegate {
    
    @IBOutlet weak var cartView: UIView!
    @IBOutlet weak var tblViewTop: NSLayoutConstraint!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet var headerView: UIView!
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var lblRestaurantName: UILabel!
    @IBOutlet weak var blurView: UIView!
    var cellHeight = CGFloat()
    var isLoded = Bool()
    var addItemssArray = NSMutableArray()
    var plusItemssArray = NSMutableArray()
    var minusItemssArray = NSMutableArray()
    
    var addCollectionArray = NSMutableArray()
    var plusCollectionArray = NSMutableArray()
    var minusCollectionArray = NSMutableArray()
    var isReloadCollectionData = Bool()
    
    class func initViewController() -> RestaurantDetailVC {
        let vc = RestaurantDetailVC.init(nibName: "RestaurantDetailVC", bundle: nil)
        vc.title = "Farm House Europe"
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = false
        self.tabBarController?.tabBar.isHidden = true
        addBlackGradientLayerInForeground()
        tblView.tableHeaderView = headerView
        cellHeight = 165
        isLoded = false
        isReloadCollectionData = true
        cartView.isHidden = true
        
    }
    
    func addBlackGradientLayerInForeground(){
        let layer = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 60))
        layer.alpha = 0.5
        let gradient = CAGradientLayer()
        gradient.frame = CGRect(x: 0, y: 0, width: imgView.frame.width, height: 60)
        gradient.colors = [ UIColor.lightGray.cgColor, UIColor.clear.cgColor]
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 0, y: 1)
        layer.layer.addSublayer(gradient)
        imgView.layer.addSublayer(gradient)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        blurView.isHidden = true
        navigationSetup()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        UIApplication.shared.statusbarView?.backgroundColor = .clear
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        blurView.isHidden = true
        tblView.reloadData()
        AMShimmer.start(for: tblView)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            AMShimmer.stop(for: self.tblView)
        }
    }
    func navigationSetup (){
        let button1 = UIButton.init(type: .infoDark)
        button1.tintColor = .white
        button1.frame = CGRect.init(x: 0, y: 0, width: 30, height: 30)
        button1.addTarget(self, action: #selector(infoClicked(_:)), for: .touchUpInside)
        let barButton = UIBarButtonItem.init(customView: button1)
        self.navigationItem.rightBarButtonItem = barButton
    }
    
    @IBAction func infoClicked(_ sender: Any) {
        let vc = RestaurantInfoVC.initViewController()
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
    @IBAction func searchClicked(_ sender: Any) {
        blurView.isHidden = false
        blurView.backgroundColor = UIColor.black.withAlphaComponent(0.2)
        let vc = RestaurantSearchVC.initViewController()
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .custom
        vc.delegate = self
        present(vc, animated: true, completion: nil)
    }
    func cancleClicked() {
        blurView.isHidden = true
    }
    @IBAction func favouriteClicked(_ sender: UIButton) {
        if(sender.isSelected == true){
            sender.isSelected = false
        } else {
            sender.isSelected = true
        }
        sender.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        
        UIView.animate(withDuration: 2.0, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 6.0, options: .allowUserInteraction, animations: {
            sender.transform = .identity
        }, completion: nil)
    }
    
    @IBAction func backClicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print(tblView.contentOffset.y)
        var offset = scrollView.contentOffset.y / 150
        if(offset > 1){
            offset = 1
            self.navigationController?.navigationBar.backgroundColor = UIColor.init(red: 217.0/255.0, green: 37.0/255.0, blue: 45.0/255.0, alpha: offset)
            UIApplication.shared.statusbarView?.backgroundColor = UIColor.init(red: 217.0/255.0, green: 37.0/255.0, blue: 45.0/255.0, alpha: offset)
        } else {
            self.navigationController?.navigationBar.backgroundColor = UIColor.init(red: 217.0/255.0, green: 37.0/255.0, blue: 45.0/255.0, alpha: offset)
            UIApplication.shared.statusbarView?.backgroundColor = UIColor.init(red: 217.0/255.0, green: 37.0/255.0, blue: 45.0/255.0, alpha: offset)
        }
        
        if(tblView.contentOffset.y > 0){
            self.navigationController?.navigationBar.isHidden = false
        } else {
            self.navigationController?.navigationBar.isHidden = true
        }
        
        if(tblView.contentOffset.y < 0){
            tblViewTop.constant = 0
            self.view.layoutIfNeeded()
        }
    }
    
    @IBAction func viewCartClicked(_ sender: Any) {
        self.tabBarController?.tabBar.isHidden = true
        self.tabBarController?.selectedIndex = 2
        //        let vc = CartVC.initViewController()
        //        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tblView.frame.width, height: 50))
        headerView.backgroundColor = UIColor.white
        let lblTitle = UILabel.init(frame: CGRect.init(x: 10, y: 0, width: tblView.frame.width - 10, height: 50))
        lblTitle.font = UIFont.init(name: "Helvetica Bold", size: 15)
        if(section == 0){
            lblTitle.text = "Recommended"
        } else {
            lblTitle.text = "Main Course"
        }
        
        headerView.addSubview(lblTitle)
        return headerView
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(section == 0){
            return 1
        }
        return 10
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if(indexPath.section == 0){
            return cellHeight//165//UITableView.automaticDimension
        }
        return 85
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(indexPath.section == 0){
            var cell = tableView.dequeueReusableCell(withIdentifier: "RecomandedDetailCell") as? RecomandedDetailCell
            if cell == nil {
                var nib = Bundle.main.loadNibNamed("RecomandedDetailCell", owner: self, options: nil)
                cell = nib?[0] as? RecomandedDetailCell
            }
            cell?.selectionStyle = .none
            cell?.delegate = self
            if(isLoded == false){
                cell?.setHeight()
            }
            //            if(isReloadCollectionData == true){
            cell?.setData(addArray: addCollectionArray, minusArray: minusCollectionArray, plusArray: plusCollectionArray)
            //            }
            
            return cell!
        }
        var cell = tableView.dequeueReusableCell(withIdentifier: "RestaurantDetailCell") as? RestaurantDetailCell
        if cell == nil {
            var nib = Bundle.main.loadNibNamed("RestaurantDetailCell", owner: self, options: nil)
            cell = nib?[0] as? RestaurantDetailCell
        }
        cell?.selectionStyle = .none
        cell?.btnAdd.tag = indexPath.row
        cell?.btnPlus.tag = indexPath.row
        cell?.btnMinus.tag = indexPath.row
        cell?.btnAdd.addTarget(self, action: #selector(addClicked(_:)), for: .touchUpInside)
        cell?.btnPlus.addTarget(self, action: #selector(plusClicked(_:)), for: .touchUpInside)
        cell?.btnMinus.addTarget(self, action: #selector(minusClicked(_:)), for: .touchUpInside)
        cell?.addView.isHidden = true
        cell?.btnAdd.isHidden = false
        
        if(addItemssArray.contains(indexPath.row)){
            cell?.btnAdd.isHidden = true
            cell?.addView.isHidden = false
            cell?.lblItemCount.text = "0"
        }
        
        for index in plusItemssArray{
            let i : Int = index as! Int
            if(indexPath.row == i){
                var a : Int = Int((cell?.lblItemCount.text)!)!
                a = a + 1
                cell?.lblItemCount.text = "\(a)"
            }
        }
        for index in minusItemssArray{
            let i : Int = index as! Int
            if(indexPath.row == i){
                var a : Int = Int((cell?.lblItemCount.text)!)!
                a = a - 1
                if(a == 0){
                    cell?.addView.isHidden = true
                    cell?.btnAdd.isHidden = false
                    addItemssArray.remove(indexPath.row)
                    minusItemssArray.remove(indexPath.row)
                    plusItemssArray.remove(indexPath.row)
                    showCartView()
                }
                cell?.lblItemCount.text = "\(a)"
            }
        }
        return cell!
    }
    
    func updateHeight(height: CGFloat) {
        print("UUUUU \(height)")
        isLoded = true
        cellHeight = 600//height
        tblView.reloadData()
        
    }
    func reloadCollectionData() {
        //        isReloadCollectionData = false
        //        tblView.reloadData()
    }
    
    func reloadCollectionData(addArray: NSMutableArray, minusArray: NSMutableArray, plusArray: NSMutableArray) {
        isReloadCollectionData = true
        addCollectionArray = addArray
        minusCollectionArray = minusArray
        plusCollectionArray = plusArray
        UIView.setAnimationsEnabled(false)
        tblView.beginUpdates()
        let indexPath = IndexPath(item: 0, section: 0)
        tblView.reloadRows(at: [indexPath], with: .automatic)
        tblView.endUpdates()
        showCartView()
    }
    
    func showCartView ()  {
        if(addItemssArray.count > 0 || addCollectionArray.count > 0){
            cartView.isHidden = false
        } else {
            cartView.isHidden = true
        }
    }
    
    @IBAction func addClicked(_ sender: UIButton) {
        addItemssArray.add(sender.tag)
        plusItemssArray.add(sender.tag)
        UIView.setAnimationsEnabled(false)
        tblView.beginUpdates()
        let indexPath = IndexPath(item: sender.tag, section: 1)
        tblView.reloadRows(at: [indexPath], with: .automatic)
        tblView.endUpdates()
        showCartView()
        
    }
    
    @IBAction func plusClicked(_ sender: UIButton) {
        plusItemssArray.add(sender.tag)
        UIView.setAnimationsEnabled(false)
        tblView.beginUpdates()
        let indexPath = IndexPath(item: sender.tag, section: 1)
        tblView.reloadRows(at: [indexPath], with: .none)
        tblView.endUpdates()
    }
    
    @IBAction func minusClicked(_ sender: UIButton) {
        minusItemssArray.add(sender.tag)
        UIView.setAnimationsEnabled(false)
        tblView.beginUpdates()
        let indexPath = IndexPath(item: sender.tag, section: 1)
        tblView.reloadRows(at: [indexPath], with: .none)
        tblView.endUpdates()
    }
    
}
