//
//  CalendarViewController.swift
//  Do_Did_List
//
//  Created by 강민석 on 2020/05/01.
//  Copyright © 2020 MinseokKang. All rights reserved.
//

import UIKit
import RealmSwift
import FSCalendar

class CalendarViewController: UIViewController {
    
    let modelManager = ModelManager()
    var items: Results<ToDoItem>?
    
    @IBOutlet weak var calendarView: FSCalendar!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        calendarView.delegate = self
        calendarView.dataSource = self
        
        tableView.delegate = self
        tableView.dataSource = self
    }

}

extension CalendarViewController: UITableViewDelegate {
    
}

extension CalendarViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "")
        
        
        
        
        return cell
    }
    
    
}

extension CalendarViewController: FSCalendarDelegate {
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        
        items = modelManager.searchDate(dateType: .customDate, date: <#T##Date#>)
        
        
    }
}

extension CalendarViewController: FSCalendarDataSource {
    
}
