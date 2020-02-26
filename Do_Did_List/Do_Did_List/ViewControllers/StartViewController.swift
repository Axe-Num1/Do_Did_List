//
//  ViewController.swift
//  Do_Did_List
//
//  Created by 강민석 on 2020/02/09.
//  Copyright © 2020 MinseokKang. All rights reserved.
//

import UIKit

class StartViewController: UIViewController {

    @IBOutlet weak var dateButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.setNeedsStatusBarAppearanceUpdate()
        
        let stringDate = getDate()
        dateButton.setTitle(stringDate, for: .normal)
    }
    
    func getDate() -> String {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd" // "yyyy-MM-dd"
        return dateFormatter.string(from: date)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
}

