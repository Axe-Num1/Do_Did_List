//
//  AddToDoViewController.swift
//  Do_Did_List
//
//  Created by 강민석 on 2020/03/01.
//  Copyright © 2020 MinseokKang. All rights reserved.
//

import UIKit

class AddToDoViewController: UIViewController {
    
    @IBOutlet weak var addToDoTableView: UITableView!
    
    var bottomPadding: CGFloat {
        let bottomSafeArea: CGFloat

        if #available(iOS 11.0, *) {
            bottomSafeArea = view.safeAreaInsets.bottom
        } else {
            bottomSafeArea = bottomLayoutGuide.length
        }
        
        return bottomSafeArea
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addToDoTableView.delegate = self
        addToDoTableView.dataSource = self
        
        addToDoTableView.backgroundColor = UIColor(red:0.90, green:0.90, blue:0.90, alpha:0.0)
        
        navigationBarSet()
    }
    
    func navigationBarSet() {
        navigationController?.navigationBar.barTintColor = UIColor(red:0.90, green:0.90, blue:0.90, alpha:1.0)
        
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
    }
    
}

// MARK: - TableView
extension AddToDoViewController : UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "addToDoCell", for: indexPath) as! AddToDoTableViewCell
        
        return cell
    }
}
