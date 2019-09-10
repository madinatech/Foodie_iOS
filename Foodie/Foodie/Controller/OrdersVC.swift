//
//  OrdersVC.swift
//  Foodie
//
//  Created by CrossGrids on 03/09/19.
//  Copyright © 2019 CrossGrids. All rights reserved.
//

import UIKit

class OrdersVC: UIViewController {
    
    class func initViewController() -> OrdersVC {
        let vc = OrdersVC.init(nibName: "OrdersVC", bundle: nil)
        vc.title = "Orders"
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
