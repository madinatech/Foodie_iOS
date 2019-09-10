
import UIKit
import AMShimmer

class SearchVC: BaseViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    @IBOutlet weak var search: UISearchBar!
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var segment: UISegmentedControl!
    @IBOutlet weak var cartView: UIView!
    
    var addItemssArray = NSMutableArray()
    var plusItemssArray = NSMutableArray()
    var minusItemssArray = NSMutableArray()
    var selectedSection = Int()
    
    class func initViewController() -> SearchVC {
        let vc = SearchVC.init(nibName: "SearchVC", bundle: nil)
        vc.title = "Search"
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tblView.tableFooterView = UIView()
        tblView.rowHeight = 110
        tblView.estimatedRowHeight = UITableView.automaticDimension
        tblView.sectionHeaderHeight = UITableView.automaticDimension
        tblView.estimatedSectionHeaderHeight = 85
        cartView.isHidden = true
        self.isBackButtonHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.isHidden = false
        self.tabBarController?.tabBar.isHidden = false
        selectedSection = -1
        segment.setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "Helvetica Bold", size: 15)!], for: .normal)
        search.endEditing(true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tblView.reloadData()
        AMShimmer.start(for: tblView)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            AMShimmer.stop(for: self.tblView)
        }
    }
    
    @IBAction func segmentClicked(_ sender: UISegmentedControl) {
        if(sender.selectedSegmentIndex == 0){
            segment.selectedSegmentIndex = 0
        } else {
            segment.selectedSegmentIndex = 1
        }
        tblView.reloadData()
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        if(segment.selectedSegmentIndex == 1){
            return 2
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if(segment.selectedSegmentIndex == 0){
            return 110//UITableView.automaticDimension
        } else {
            return 85
        }
        
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view : SearchHeader = SearchHeader.instanceFromNib() as! SearchHeader
        view.btnViewMenu.tag = section
        view.btnViewMenu.addTarget(self, action: #selector(viewMenuClicked(_:)), for: .touchUpInside)
        return view
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if(segment.selectedSegmentIndex == 0){
            return 0
        }
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(segment.selectedSegmentIndex == 0){
            var cell = tableView.dequeueReusableCell(withIdentifier: "RestaurantCell") as? RestaurantCell
            if cell == nil {
                var nib = Bundle.main.loadNibNamed("RestaurantCell", owner: self, options: nil)
                cell = nib?[0] as? RestaurantCell
            }
            cell?.selectionStyle = .none
            
            return cell!
        } else {
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
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tblView.deselectRow(at: indexPath, animated: true)
        if(segment.selectedSegmentIndex == 0){
            let vc = RestaurantDetailVC.initViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func showCartView ()  {
        if(addItemssArray.count > 0){
            cartView.isHidden = false
        } else {
            cartView.isHidden = true
        }
    }
    
    @IBAction func viewMenuClicked(_ sender: UIButton) {
        let vc = RestaurantDetailVC.initViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func addClicked(_ sender: UIButton) {
        addItemssArray.add(sender.tag)
        plusItemssArray.add(sender.tag)
        UIView.setAnimationsEnabled(false)
        tblView.beginUpdates()
        let indexPath = IndexPath(item: sender.tag, section: 0)
        tblView.reloadRows(at: [indexPath], with: .automatic)
        tblView.endUpdates()
        showCartView()
    }
    
    @IBAction func plusClicked(_ sender: UIButton) {
        plusItemssArray.add(sender.tag)
        UIView.setAnimationsEnabled(false)
        tblView.beginUpdates()
        let indexPath = IndexPath(item: sender.tag, section: 0)
        tblView.reloadRows(at: [indexPath], with: .none)
        tblView.endUpdates()
    }
    
    @IBAction func minusClicked(_ sender: UIButton) {
        minusItemssArray.add(sender.tag)
        UIView.setAnimationsEnabled(false)
        tblView.beginUpdates()
        let indexPath = IndexPath(item: sender.tag, section: 0)
        tblView.reloadRows(at: [indexPath], with: .none)
        tblView.endUpdates()
    }
    
//    UISearchBarDelegate
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        search.endEditing(true)
    }
    
    
}
