//
//  MainViewController.swift
//  Do_Did_List
//
//  Created by 강민석 on 2020/02/22.
//  Copyright © 2020 MinseokKang. All rights reserved.
//

import UIKit
import Foundation
import SideMenu

class MainViewController: UIViewController {
    
    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var category: UIImageView!
    @IBOutlet weak var checkmark: UIImageView!
    
    @IBOutlet weak var categoryTitle: UILabel!
    @IBOutlet weak var content: UITextView!
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var toDoTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        toDoTableView.delegate = self
        toDoTableView.dataSource = self
        
        toDoTableView.backgroundColor = UIColor(red:0.23, green:0.42, blue:0.92, alpha:0) // hex: 3B6CEB
        
        let cellNib = UINib(nibName: "ToDoTableViewCell", bundle: nil)
        toDoTableView.register(cellNib, forCellReuseIdentifier: "toDoCell")

        dateLabel.text = getDate()
        
        self.setUpSideMenu()
    }
    
    // Status Bar 색상 설정
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent // white
    }
    
    func getDate() -> String {
        let date = Date()
        let calendar = Calendar.current
        
        let monthNumber = calendar.component(.month, from: date)
        let monthName = DateFormatter().monthSymbols[monthNumber - 1]
        
        let dayNumber = calendar.component(.day, from: date)
        
        let result = "\(monthName) \(String(dayNumber))"
        
        return result
    }
    
    @IBAction func sideMenuButton(_ sender: Any) {
        present(SideMenuManager.default.leftMenuNavigationController!, animated: true, completion: nil)
    }
}


// MARK: - TableView
extension MainViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "toDoCell")
        
        return cell!
    }
}

// MARK: - SideMenu Implementation
extension MainViewController {
    
    func setUpSideMenu() {
        let sideMenu = SideMenuViewController(nibName: "SideMenuViewController", bundle: nil)
        
        let leftMenuNavigationController = SideMenuNavigationController(rootViewController: sideMenu)
        SideMenuManager.default.leftMenuNavigationController = leftMenuNavigationController
        
        // status bar alpha 값
        leftMenuNavigationController.statusBarEndAlpha = 0
        
        // Side Menu presentation 방식
        leftMenuNavigationController.presentationStyle = .menuSlideIn
        
        // swipe 제스처를 사용하여 Side Menu 열기
//        SideMenuManager.default.addPanGestureToPresent(toView: self.view)
//        SideMenuManager.default.addScreenEdgePanGesturesToPresent(toView: self.view)
        
    }
}

// MARK: - UISideMenuNavigationControllerDelegate
extension MainViewController: SideMenuNavigationControllerDelegate {

    func sideMenuWillAppear(menu: SideMenuNavigationController, animated: Bool) {
        print("SideMenu Appearing! (animated: \(animated))")
    }

    func sideMenuDidAppear(menu: SideMenuNavigationController, animated: Bool) {
        print("SideMenu Appeared! (animated: \(animated))")
    }

    func sideMenuWillDisappear(menu: SideMenuNavigationController, animated: Bool) {
        print("SideMenu Disappearing! (animated: \(animated))")
    }

    func sideMenuDidDisappear(menu: SideMenuNavigationController, animated: Bool) {
        print("SideMenu Disappeared! (animated: \(animated))")
    }
}
