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
import RealmSwift

class MainViewController: UIViewController {
    
    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var category: UIImageView!
    @IBOutlet weak var checkmark: UIImageView!
    
    @IBOutlet weak var categoryTitle: UILabel!
    @IBOutlet weak var content: UITextView!
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var toDoTableView: UITableView!
    
    var modelManger: ModelManager?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSideMenu()
        
        toDoTableView.delegate = self
        toDoTableView.dataSource = self
        toDoTableView.showsVerticalScrollIndicator = false
        
        toDoTableView.backgroundColor = UIColor(red:0.23, green:0.42, blue:0.92, alpha:0) // hex: 3B6CEB

        setDate()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
    }
    
    // Status Bar 색상 설정
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent // white
    }
    
    func setDate() {
        let date = Date()
        let calendar = Calendar.current
        
        let monthNumber = calendar.component(.month, from: date)
        let monthName = DateFormatter().monthSymbols[monthNumber - 1]
        
        let dayNumber = calendar.component(.day, from: date)
        
        dateLabel.text = "\(monthName) \(String(dayNumber))" // "MonthName + DayNumber"
    }
}


// MARK: - UITableViewDataSource
extension MainViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "toDoCell", for: indexPath) as! ToDoTableViewCell
        
        return cell
    }
}


// MARK: - SideMenu Implementation
extension MainViewController {
    
    func makeSettings() -> SideMenuSettings {
        var settings = SideMenuSettings()
        settings.presentationStyle = .menuSlideIn
        settings.presentationStyle.menuStartAlpha = 0.8
        settings.presentationStyle.presentingEndAlpha = 0.6
        settings.presentationStyle.onTopShadowOpacity = 0.5
        settings.usingSpringWithDamping = 0.8
        settings.statusBarEndAlpha = 0
        
        return settings
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let sideMenuNavigationController = segue.destination as? SideMenuNavigationController else { return }
        sideMenuNavigationController.settings = makeSettings()
    }
    
    func setupSideMenu() {
        SideMenuManager.default.leftMenuNavigationController = storyboard?.instantiateViewController(withIdentifier: "LeftMenuNavigationController") as? SideMenuNavigationController
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
