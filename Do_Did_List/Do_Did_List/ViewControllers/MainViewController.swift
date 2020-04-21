//
//  MainViewController.swift
//  Do_Did_List
//
//  Created by 강민석 on 2020/02/22.
//  Copyright © 2020 MinseokKang. All rights reserved.
//

import UIKit
import Foundation
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
    var items: Results<ToDoItem>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        toDoTableView.delegate = self
        toDoTableView.dataSource = self
        toDoTableView.showsVerticalScrollIndicator = false
        
        toDoTableView.backgroundColor = UIColor(red:0.23, green:0.42, blue:0.92, alpha:0) // hex: 3B6CEB

        setDate()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        print("viewwillappear")
        
        items = modelManger?.searchDate(dateType: .today, date: Date())
        items = items?.sorted(byKeyPath: "timestamp", ascending: true)
        
        UIView.transition(with: toDoTableView.self, duration: 0.4, options: .transitionCrossDissolve, animations: { self.toDoTableView.reloadData() })
        
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
extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "toDoCell", for: indexPath) as! ToDoTableViewCell
        
        let item = items?[indexPath.row]
        cell.contentLabel.text = item?.content
//        cell.importance.rating = item!.importance
//        cell.item
        
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension MainViewController: UITableViewDelegate {
    
}
