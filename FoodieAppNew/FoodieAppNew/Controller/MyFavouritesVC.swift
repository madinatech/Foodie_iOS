

import UIKit

class MyFavouritesVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var innerView: UIView!
    class func initViewController() -> MyFavouritesVC {
        let vc = MyFavouritesVC.init(nibName: "MyFavouritesVC", bundle: nil)
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        innerView.layer.cornerRadius = 20
        innerView.clipsToBounds = true
        innerView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    
    @IBAction func backClicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return  120
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: "FavouriteCell") as? FavouriteCell
        if cell == nil {
            var nib = Bundle.main.loadNibNamed("FavouriteCell", owner: self, options: nil)
            cell = nib?[0] as? FavouriteCell
        }
        cell?.selectionStyle = .none
        return cell!
        
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if(editingStyle == .delete){
            
        }
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let whitespace = Utils.whitespaceString(width: 100)
        let delete = UITableViewRowAction.init(style: .default, title: whitespace) { (action, indexPath) in
            print("delete item")
            
        }
        
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 140, height: 130))
        let innerView = UIView(frame: CGRect(x: 5, y: 5, width: 60, height: 110))
        view.backgroundColor = appLigtGrayColor
        innerView.backgroundColor = appLightThemeColor
        innerView.layer.cornerRadius = 10
        let imageView = UIImageView(frame: CGRect(x: 15, y: 40, width: 30, height: 30))
        imageView.image = UIImage(named: "deleteIcon")
        innerView.addSubview(imageView)
        view.addSubview(innerView)
        let image = view.image()
        delete.backgroundColor = UIColor.init(patternImage: image)
        return [delete]
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tblView.deselectRow(at: indexPath, animated: true)
        
    }
   
    
    
}

