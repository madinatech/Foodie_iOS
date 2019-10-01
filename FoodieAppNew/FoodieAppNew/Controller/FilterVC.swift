

import UIKit
@objc protocol filterDelegate {
   
    func applyFilter(cusinesName : [String])
    func resetFilter(cusinesName : [String])
}
class FilterVC: UIViewController, UITableViewDataSource, UITableViewDelegate, UIGestureRecognizerDelegate, categoryCellDelegate {

    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var innerView: UIView!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var btnReset: UIButton!
    var selectedSection = Int()
    var selectedIndex = Int()
    var cusinesHeight = Int()
    var delegate :  filterDelegate? = nil
    var selectdCusinesArray = [String]()
    
    class func initViewController(selectdCusines : [String]) -> FilterVC {
        let vc = FilterVC.init(nibName: "FilterVC", bundle: nil)
        vc.selectdCusinesArray = selectdCusines
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        innerView.layer.cornerRadius = 20
        innerView.clipsToBounds = true
        innerView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        btnReset.layer.borderColor = appPurpleColor.cgColor
        btnReset.layer.borderWidth = 1
        tblView.tableFooterView = UIView()
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        tap.delegate = self
        topView.addGestureRecognizer(tap)
    }

    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func resetClicked(_ sender: Any) {
        if(delegate != nil){
            self.dismiss(animated: true) {
                self.selectdCusinesArray = [String]()
                self.delegate?.resetFilter(cusinesName: self.selectdCusinesArray)
            }
        }
    }
    
    @IBAction func applyFilterClicked(_ sender: Any) {
        if(delegate != nil){
             self.dismiss(animated: true) {
                self.delegate?.applyFilter(cusinesName: self.selectdCusinesArray)
            }
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(section == 0){
            return 4
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tblView.frame.width, height: 50))
        headerView.backgroundColor = UIColor.white
        let lblTitle = UILabel.init(frame: CGRect.init(x: 15, y: 0, width: tblView.frame.width - 10, height: 50))
        lblTitle.font = UIFont.init(name: "Calibri-Bold", size: 20)
        if(section == 0){
            lblTitle.text = "Sort by"
        } else {
            lblTitle.text = "Filter by cuisines"
        }
        headerView.addSubview(lblTitle)
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if(indexPath.section == 0){
            return  50
        }
        return CGFloat(cusinesHeight)
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(indexPath.section == 0){
            var cell = tableView.dequeueReusableCell(withIdentifier: "SortingCell") as? SortingCell
            if cell == nil {
                var nib = Bundle.main.loadNibNamed("SortingCell", owner: self, options: nil)
                cell = nib?[0] as? SortingCell
            }
            cell?.selectionStyle = .none
            cell?.setData(index: indexPath.row)
            cell?.setSelecteddData(selectdIndex: selectedIndex, selectedSection: selectedSection, indePath: indexPath)
            return cell!
        } else {
            var cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell") as? CategoryCell
            if cell == nil {
                var nib = Bundle.main.loadNibNamed("CategoryCell", owner: self, options: nil)
                cell = nib?[0] as? CategoryCell
            }
            cell?.selectionStyle = .none
            cell?.delegate = self
            cell?.setData(selectedCusines: selectdCusinesArray)
            return cell!
            
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tblView.deselectRow(at: indexPath, animated: true)
        selectedIndex = indexPath.row
        selectedSection = indexPath.section
        tblView.reloadData()
    }
    
    func updateHeight(height: CGFloat) {
        cusinesHeight = Int(height * 25)
        tblView.beginUpdates()
        let indexPath = IndexPath(item: 1, section: 1)
        tblView.reloadRows(at: [indexPath], with: .automatic)
        tblView.endUpdates()
//        tblView.reloadData()
    }
    
    func selectedCusines(cusinesArray: [String]) {
        selectdCusinesArray = cusinesArray
    }
}
