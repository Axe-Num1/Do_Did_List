//
//  SideMenuViewController.swift
//  Do_Did_List
//
//  Created by 강민석 on 2020/02/22.
//  Copyright © 2020 MinseokKang. All rights reserved.
//

import UIKit

class SideMenuViewController: UIViewController {
    
    @IBOutlet weak var sideMenuView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sideMenuView.roundCorners([.topRight, .bottomRight], radius: 40)
    }

    // Navigation Bar dismiss
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        super.viewWillAppear(animated)
    }
    
    @IBAction func addToDo_BT(_ sender: Any) {
    }
    
    @IBAction func calendar_BT(_ sender: Any) {
    }
    
    @IBAction func bookmark_BT(_ sender: Any) {
    }
    
    @IBAction func settings_BT(_ sender: Any) {
    }
    
}

