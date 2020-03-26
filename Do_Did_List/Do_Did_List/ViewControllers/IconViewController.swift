//
//  IconViewController.swift
//  Do_Did_List
//
//  Created by 강민석 on 2020/03/25.
//  Copyright © 2020 MinseokKang. All rights reserved.
//

import UIKit

class IconViewController: UIViewController {
    
    @IBOutlet weak var iconImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        isModalInPresentation = true
    }
    
    @IBAction func doneButton(_ sender: Any) {
        
    }
    
}
