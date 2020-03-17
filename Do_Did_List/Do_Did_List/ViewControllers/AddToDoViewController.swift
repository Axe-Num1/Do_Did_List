//
//  AddToDoViewController.swift
//  Do_Did_List
//
//  Created by 강민석 on 2020/03/01.
//  Copyright © 2020 MinseokKang. All rights reserved.
//

import UIKit
import SOPullUpView

class AddToDoViewController: UIViewController {
    
    @IBOutlet weak var addToDoTableView: UITableView!
    
    let pullUpController = SOPullUpControl()
    
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
        
        pullUpController.dataSource = self
        pullUpController.setupCard(from: view)
        
        addToDoTableView.delegate = self
        addToDoTableView.dataSource = self
        
        addToDoTableView.backgroundColor = UIColor(red:0.90, green:0.90, blue:0.90, alpha:0.0)
        
        navigationBarSet()
    }
    
    @IBAction func cancelItem(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func navigationBarSet() {
        navigationController?.navigationBar.barTintColor = UIColor(red:0.90, green:0.90, blue:0.90, alpha:1.0)
        
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
    }
    
}

// MARK: - SOPullUpViewDataSource

extension AddToDoViewController: SOPullUpViewDataSource {
    func pullUpViewCollapsedViewHeight() -> CGFloat {
        return bottomPadding + 90
    }
    
    func pullUpViewController() -> UIViewController {
        guard let vc = UIStoryboard(name: "AddToDoPullUp", bundle: nil).instantiateInitialViewController() as? AddToDoPullUpViewController else {
            return UIViewController()
        }
        
        vc.pullUpControl = self.pullUpController
        return vc
    }
    
    func pullUpViewExpandedViewHeight() -> CGFloat {
        return 770
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
