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
        
        cardSwiper.register(nib: UINib(nibName: "ToDoCardCell", bundle: nil), forCellWithReuseIdentifier: "ToDoCell")
        
        setNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        items = modelManger.searchDate(dateType: .today, date: Date())
        items = modelManger.filterDone(original: items!, isDone: false)
        items = items?.sorted(byKeyPath: "timestamp", ascending: true)
        
        UIView.transition(with: cardSwiper.self, duration: 0.5, options: .transitionCrossDissolve, animations: { self.cardSwiper.reloadData() })
        
        self.title = items?.first?.title
    }
    
    // Status Bar 색상 설정
//    override var preferredStatusBarStyle: UIStatusBarStyle {
//        return .lightContent // white
//    }
    
    
    @objc func moveToCalendarView() {
        print("move to calendar view")
    }
    
    func setNavigationBar() {
        let textColor = UIColor(red: 0.23, green: 0.42, blue: 0.92, alpha: 1.00)
        
        navigationController?.navigationBar.prefersLargeTitles = true
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            title: setDate(),
            style: .plain,
            target: self,
            action: #selector(moveToCalendarView)
        )
        
        let leftBarButtonTextAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: textColor,
            .font: UIFont(name: "Fivo Sans", size: 18)!
        ]
        
        let leftButton = self.navigationItem.leftBarButtonItem
        leftButton?.setTitleTextAttributes(leftBarButtonTextAttributes, for: .normal)
        
        navigationController?.navigationBar.largeTitleTextAttributes = [
            .foregroundColor: textColor,
            .font: UIFont(name: "Fivo Sans", size: 35)!
        ]
        
        
    }
    
    
    func setDate() -> String {
        let date = Date()
        let calendar = Calendar.current
        
        let monthNumber = calendar.component(.month, from: date)
        let monthName = DateFormatter().monthSymbols[monthNumber - 1]
        
        let dayNumber = calendar.component(.day, from: date)
        
        let weekNumber = calendar.component(.weekday, from: date)
        let weekName = DateFormatter().weekdaySymbols[weekNumber - 1]
        
        return "\(weekName) \(monthName) \(String(dayNumber))" // "MonthName + DayNumber"
    }
}

extension MainViewController: VerticalCardSwiperDatasource {
    func numberOfCards(verticalCardSwiperView: VerticalCardSwiperView) -> Int {
        return items?.count ?? 0
    }
    
    func cardForItemAt(verticalCardSwiperView: VerticalCardSwiperView, cardForItemAt index: Int) -> CardCell {
        if let cardCell = verticalCardSwiperView.dequeueReusableCell(withReuseIdentifier: "ToDoCell", for: index) as? ToDoCardCell {
            let item = items?[index]
            
            
            cardCell.setBackgroundColor(item?.firstColor, item?.secondColor)
            cardCell.setImportance(ratingCount: item!.importance)
            cardCell.setDate(date: item!.timestamp)
            cardCell.setDescriptionTextView(text: item?.content ?? description)
            cardCell.setTitleLabel(title: item?.title ?? "title")
            cardCell.setIconImage(item!.imageData)
            
            return cardCell
        }
        
        return CardCell()
    }
    
    
}

extension MainViewController: VerticalCardSwiperDelegate {
    func willSwipeCardAway(card: CardCell, index: Int, swipeDirection: SwipeDirection) {
        let item = items?[index]
        
        switch swipeDirection {
        case .Left:
            print("Left Direction")
            break
        case .Right:
            modelManger.changeDoneCondition(item: item!, condition: true)
            
        case .None:
            break
        }
        
    }
}
