//
//  DidViewController.swift
//  Do_Did_List
//
//  Created by 강민석 on 2020/04/26.
//  Copyright © 2020 MinseokKang. All rights reserved.
//

import UIKit
import RealmSwift
import VerticalCardSwiper

class DidViewController: UIViewController {

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
        items = modelManger.filterDone(original: items!, isDone: true)
        items = items?.sorted(byKeyPath: "timestamp", ascending: true)
        
        UIView.transition(with: cardSwiper.self, duration: 0.5, options: .transitionCrossDissolve, animations: { self.cardSwiper.reloadData() })
    }
}

extension DidViewController: VerticalCardSwiperDatasource {
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

extension DidViewController: VerticalCardSwiperDelegate {
    func willSwipeCardAway(card: CardCell, index: Int, swipeDirection: SwipeDirection) {
        let item = items?[index]
        
        switch swipeDirection {
        case .Left:
            modelManger.changeDoneCondition(item: item!, condition: false)
        case .Right:
            print("Right Direction")
            break
        case .None:
            break
        }
        
    }
}
