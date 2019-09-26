//
//  CustomizationVC.swift
//  FoodieAppNew
//
//  Created by CrossGrids on 26/09/19.
//  Copyright © 2019 CrossGrids. All rights reserved.
//

import UIKit

@objc protocol CustomizeDelegate {
    func closeCustomizeView()
    func updateClicked()
}

class CustomizationVC: UIViewController , UITableViewDelegate, UITableViewDataSource, UIGestureRecognizerDelegate{
    
    @IBOutlet weak var tapView: UIView!
    @IBOutlet weak var innerView: UIView!
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var viewHeight: NSLayoutConstraint!
    
    var delegate :  CustomizeDelegate? = nil
    var checkedArray = NSMutableArray()
    var item = Items()
    var customizationGroupArray = [CustomizationGroup]()
    var groupValueArray = [GroupValues]()
    var selectedGroupValue = GroupValues()
    
    class func initViewController(item : Items) -> CustomizationVC {
        let vc = CustomizationVC.init(nibName: "CustomizationVC", bundle: nil)
        vc.item = item
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        innerView.layer.cornerRadius = 20
        innerView.clipsToBounds = true
        innerView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        tblView.tableFooterView = UIView()
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        tap.delegate = self
        tapView.addGestureRecognizer(tap)
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        if(delegate != nil){
            self.dismiss(animated: true) {
                self.delegate?.closeCustomizeView()
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        customizationGroupArray = item.customization_groups.allObjects as! [CustomizationGroup]
        tblView.reloadData()
        viewHeight.constant = tblView.contentSize.height
        self.view.layoutIfNeeded()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            if(self.tblView.contentSize.height < self.view.frame.height - 100){
                 self.viewHeight.constant = self.tblView.contentSize.height
            } else {
                 self.viewHeight.constant = self.view.frame.height - 100
            }
           
            self.view.layoutIfNeeded()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tblView.reloadData()
        viewHeight.constant = tblView.contentSize.height
        self.view.layoutIfNeeded()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return customizationGroupArray.count + 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(section == 0){
            return 1
        } else if(section == customizationGroupArray.count + 1){
           return 1
        } else {
            groupValueArray = customizationGroupArray[section - 1].group_values.allObjects as! [GroupValues]
            return groupValueArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if(indexPath.section == 0){
            return UITableView.automaticDimension
        } else if(indexPath.section == customizationGroupArray.count + 1){
            return 100
        } else {
            return 40
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if(section == 0){
          return 0
        } else if(section == customizationGroupArray.count + 1){
            return 0
        } else {
            return 50
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if(section == 0){
            return ""
        } else if(section == customizationGroupArray.count + 1){
             return ""
        } else {
            return customizationGroupArray[section - 1].group_name
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(indexPath.section == 0){
            var cell = tableView.dequeueReusableCell(withIdentifier: "CustomizeItemCell") as? CustomizeItemCell
            if cell == nil {
                var nib = Bundle.main.loadNibNamed("CustomizeItemCell", owner: self, options: nil)
                cell = nib?[0] as? CustomizeItemCell
            }
            cell?.selectionStyle = .none
            cell?.setData(item: item)
            cell?.btnCose.addTarget(self, action: #selector(closeClicked(_:)), for: .touchUpInside)
            return cell!
            
        } else if(indexPath.section == customizationGroupArray.count + 1){
            var cell = tableView.dequeueReusableCell(withIdentifier: "CustomizeTotalCell") as? CustomizeTotalCell
            if cell == nil {
                var nib = Bundle.main.loadNibNamed("CustomizeTotalCell", owner: self, options: nil)
                cell = nib?[0] as? CustomizeTotalCell
            }
            cell?.selectionStyle = .none
            cell?.lblItems.text = ""
            cell?.setData(item: item)
            cell?.btnUpdateItem.addTarget(self, action: #selector(updateClicked(_:)), for: .touchUpInside)
            return cell!
        } else{
            let customize : CustomizationGroup = customizationGroupArray[indexPath.section - 1]
            if(customize.group_type_code == "2") {
                var cell = tableView.dequeueReusableCell(withIdentifier: "CustomizeSingleCell") as? CustomizeSingleCell
                if cell == nil {
                    var nib = Bundle.main.loadNibNamed("CustomizeSingleCell", owner: self, options: nil)
                    cell = nib?[0] as? CustomizeSingleCell
                }
                cell?.selectionStyle = .none
                cell?.btnRedio.tag = indexPath.row
                cell?.btnRedio.addTarget(self, action: #selector(radioClicked(_:)), for: .touchUpInside)
                cell?.btnRedio.isSelected = false
                
                groupValueArray = customizationGroupArray[indexPath.section - 1].group_values.allObjects as! [GroupValues]
                let groupValue = groupValueArray[indexPath.row]
                cell?.setData(value: groupValue)
                if(groupValue == selectedGroupValue){
                    cell?.btnRedio.isSelected = true
                }
                 return cell!
            } else {
                var cell = tableView.dequeueReusableCell(withIdentifier: "CustomizeCell") as? CustomizeCell
                if cell == nil {
                var nib = Bundle.main.loadNibNamed("CustomizeCell", owner: self, options: nil)
                cell = nib?[0] as? CustomizeCell
                }
                cell?.selectionStyle = .none
                cell?.btnCheck.tag = indexPath.row
                cell?.btnCheck.addTarget(self, action: #selector(optionClicked(_:)), for: .touchUpInside)
               
                
                groupValueArray = customizationGroupArray[indexPath.section - 1].group_values.allObjects as! [GroupValues]
                let groupValue = groupValueArray[indexPath.row]
                cell?.setData(value: groupValue)
                
                 cell?.btnCheck.isSelected = false
                if(checkedArray.contains(groupValue)){
                cell?.btnCheck.isSelected = true
                }
                 return cell!
            }
        }
    }
    
    @objc func optionClicked(_ sender: UIButton) {
       let groupValue =  groupValueArray[sender.tag]
        if(checkedArray.contains(groupValue)){
            checkedArray.remove(groupValue)
        } else {
            checkedArray.add(groupValue)
        }
        tblView.reloadData()
    }
    
      @objc func radioClicked(_ sender: UIButton) {
        selectedGroupValue = groupValueArray[sender.tag]
        tblView.reloadData()
    }
    
    @IBAction func closeClicked(_ sender: UIButton) {
        
        if(delegate != nil){
            self.dismiss(animated: true) {
                self.delegate?.closeCustomizeView()
            }
        }
    }
    
    @IBAction func updateClicked(_ sender: UIButton) {
        if(delegate != nil){
            self.dismiss(animated: true) {
                self.delegate?.closeCustomizeView()
            }
        }
    }
}
