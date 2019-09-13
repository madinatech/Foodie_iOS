

import UIKit

class RestaurantInfoVC: BaseViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var restaurantName: UILabel!
    @IBOutlet weak var lblRating: UILabel!
    @IBOutlet weak var lblAmount: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet var headerView: UIView!
    @IBOutlet weak var lblCusines: UILabel!
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var tblViewTop: NSLayoutConstraint!
    class func initViewController() -> RestaurantInfoVC {
        let vc = RestaurantInfoVC.init(nibName: "RestaurantInfoVC", bundle: nil)
        vc.title = "Farm House Europe"
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.isHidden = false
        self.tabBarController?.tabBar.isHidden = true
        addBlackGradientLayerInForeground()
          tblView.tableHeaderView = headerView
        tblView.tableFooterView = UIView()
        tblView.rowHeight = UITableView.automaticDimension
        tblView.estimatedRowHeight = 90
    }
    
    @IBAction func backClicked(_ sender: Any) {
         self.navigationController?.popViewController(animated: true)
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
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        UIApplication.shared.statusbarView?.backgroundColor = .clear
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
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return 3
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
        var cell = tableView.dequeueReusableCell(withIdentifier: "InfoCell") as? InfoCell
        if cell == nil {
            var nib = Bundle.main.loadNibNamed("InfoCell", owner: self, options: nil)
            cell = nib?[0] as? InfoCell
        }
        cell?.setdata(index: indexPath.row)
        return cell!
    }
    
    
}
