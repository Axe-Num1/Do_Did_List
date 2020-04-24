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
import VerticalCardSwiper

class MainViewController: UIViewController {
    
    @IBOutlet weak var cardSwiper: VerticalCardSwiper!
    
    let modelManger = ModelManager()
    var items: Results<ToDoItem>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cardSwiper.delegate = self
        cardSwiper.datasource = self
        
        setDate()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        items = modelManger.searchDate(dateType: .today, date: Date())
        items = items?.sorted(byKeyPath: "timestamp", ascending: true)
        //        UIView.transition(with: toDoTableView.self, duration: 0.4, options: .transitionCrossDissolve, animations: { self.toDoTableView.reloadData() })
        
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
        
        //        dateLabel.text = "\(monthName) \(String(dayNumber))" // "MonthName + DayNumber"
    }
}

extension MainViewController: VerticalCardSwiperDelegate, VerticalCardSwiperDatasource {
    func numberOfCards(verticalCardSwiperView: VerticalCardSwiperView) -> Int {
        return 10
    }
    
    func cardForItemAt(verticalCardSwiperView: VerticalCardSwiperView, cardForItemAt index: Int) -> CardCell {
        if let cardCell = verticalCardSwiperView.dequeueReusableCell(withReuseIdentifier: "ExampleCell", for: index) as? ExampleCardCell {
            
//            let contact = contactsDemoData[index]
//            cardCell.setRandomBackgroundColor()
//            cardCell.nameLbl.text = "Name: " + contact.name
//            cardCell.ageLbl.text = "Age: \(contact.age ?? 0)"
            return cardCell
        }
        
        return CardCell()
    }
    
    
}
