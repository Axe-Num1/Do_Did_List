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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        items = modelManger.searchDate(dateType: .today, date: Date())
        items = items?.sorted(byKeyPath: "timestamp", ascending: true)
        UIView.transition(with: cardSwiper.self, duration: 0.5, options: .transitionCrossDissolve, animations: { self.cardSwiper.reloadData() })
        
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

extension MainViewController: VerticalCardSwiperDatasource {
    func numberOfCards(verticalCardSwiperView: VerticalCardSwiperView) -> Int {
        return items?.count ?? 0
    }
    
    func cardForItemAt(verticalCardSwiperView: VerticalCardSwiperView, cardForItemAt index: Int) -> CardCell {
        if let cardCell = verticalCardSwiperView.dequeueReusableCell(withReuseIdentifier: "ToDoCell", for: index) as? ToDoCardCell {
            let item = items?[index]
            
            
            cardCell.setBackgroundColor(item?.firstColor, item?.secondColor)
            cardCell.setImportance(ratingCount: item!.importance)
            //            cardCell.setNavigationBar(timestamp: item?.timestamp)
            cardCell.setDescriptionTextView(text: item?.content ?? description)
            cardCell.setTitleLabel(title: item?.title ?? "title")
            
            //            cardCell.setIconImage(image: <#T##UIImage#>)
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
            
        case .Right:
            item?.isDone = true
            
        case .None:
            break
        }
        
    }
}
