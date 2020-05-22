//
//  DoViewModel.swift
//  DoDidList
//
//  Created by 강민석 on 2020/05/14.
//  Copyright © 2020 MinseokKang. All rights reserved.
//

import Foundation
import RealmSwift
import RxRealm

import RxCocoa
import RxSwift

enum TaskType {
    case Do
    case Did
}

class DoDidViewModel {
    
    let disposeBag = DisposeBag()
    
    let modelManager = ModelManager()
    var items: Results<ToDoItem>?

    func setItems(type: TaskType) {
        items = modelManager.searchDate(dateType: .today)
        items = items?.sorted(byKeyPath: "timestamp", ascending: true)
        
        switch type {
        case .Do:
            items = modelManager.filterDoneCondition(original: items!, isDone: false)
        case .Did:
            items = modelManager.filterDoneCondition(original: items!, isDone: true)
        }
    }
    
    
    
    
    
    //    override func viewWillAppear(_ animated: Bool) {
    //        super.viewWillAppear(animated)
    //
    //        items = modelManager.searchDate(dateType: .today, customDate: nil)
    //        items = modelManager.filterDone(original: items!, isDone: false)
    //        items = items?.sorted(byKeyPath: "timestamp", ascending: true)
    //
    //        UIView.transition(with: cardSwiper.self, duration: 0.5, options: .transitionCrossDissolve, animations: { self.cardSwiper.reloadData() })
    //
    //        setNavigationTitle()
    //    }
    //
    //    @objc func moveToCalendarView() {
    //        self.tabBarController?.selectedIndex = 3
    //    }
    //
    //    func setDate() -> String {
    //        let date = Date()
    //        let calendar = Calendar.current
    //
    //        let weekNumber = calendar.component(.weekday, from: date)
    //        let weekName = DateFormatter().weekdaySymbols[weekNumber - 1]
    //
    //        let monthNumber = calendar.component(.month, from: date)
    //        let monthName = DateFormatter().monthSymbols[monthNumber - 1]
    //
    //        let dayNumber = calendar.component(.day, from: date)
    //
    //        return "\(weekName) \(monthName) \(String(dayNumber))" // "WeekName + MonthName + DayNumber"
    //    }
    //
    //
    //
    //    func setNavigationTitle() {
    //        if ((items?.first) != nil) {
    //            self.navigationItem.title = "What To Do Today"
    //        } else {
    //            self.navigationItem.title = "Let's Do!"
    //        }
    //    }
    //
    
}
