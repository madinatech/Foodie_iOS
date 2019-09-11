

import UIKit
import AMShimmer

class FavouritesVC: BaseViewController,  UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tblView: UITableView!
    class func initViewController() -> FavouritesVC {
        let vc = FavouritesVC.init(nibName: "FavouritesVC", bundle: nil)
        vc.title = "Favourites"
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.shared.statusbarView?.backgroundColor = appThemeColor
        self.navigationController?.navigationBar.isHidden = false
        self.tabBarController?.tabBar.isHidden = true
        tblView.tableFooterView = UIView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tblView.reloadData()
        AMShimmer.start(for: tblView)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            AMShimmer.stop(for: self.tblView)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110//UITableView.automaticDimension
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "RestaurantCell") as? RestaurantCell
        if cell == nil {
            var nib = Bundle.main.loadNibNamed("RestaurantCell", owner: self, options: nil)
            cell = nib?[0] as? RestaurantCell
        }
        cell?.selectionStyle = .none
        
        return cell!
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tblView.deselectRow(at: indexPath, animated: true)
        let vc = RestaurantDetailVC.initViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
