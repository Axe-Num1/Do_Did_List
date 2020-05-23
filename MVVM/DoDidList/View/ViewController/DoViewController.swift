//
//  ViewController.swift
//  DoDidList
//
//  Created by 강민석 on 2020/05/10.
//  Copyright © 2020 MinseokKang. All rights reserved.
//

import UIKit
import RealmSwift
import RxRealm

import RxSwift
import RxCocoa

class DoViewController: UIViewController {
    
    var disposeBag = DisposeBag()
    
    let viewModel = DoDidViewModel(type: .Do)
    let modelManager = ModelManager()
    
    @IBOutlet weak var doTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIApplication.shared.applicationIconBadgeNumber = 0
        
        doTableView.register(UINib(nibName: "TaskTableViewCell", bundle: nil), forCellReuseIdentifier: "TaskCell")
        
        bindViewModel()
    }
    
    func bindViewModel() {
        
        Observable.from(optional: viewModel.items)
            .bind(to: doTableView.rx.items(cellIdentifier: "TaskCell", cellType: TaskTableViewCell.self)) { row, element, cell in
                let iconImage = UIImage(data: element.iconImageData)
                cell.titleLabel.text = element.title
                cell.imageView?.image = iconImage
            }
            .disposed(by: disposeBag)
        
        
                

        
    }
    
    
//    func setNavigationBar() {
//        let textColor = UIColor(red: 0.23, green: 0.42, blue: 0.92, alpha: 1.00)
//
//        let appearance = UINavigationBarAppearance()
//        appearance.configureWithDefaultBackground()
//
//        appearance.largeTitleTextAttributes = [
//            .foregroundColor: textColor,
//            .font: UIFont(name: "Fivo Sans", size: 35)!
//        ]
//
//        appearance.buttonAppearance.normal.titleTextAttributes = [
//            .foregroundColor: textColor,
//            .font: UIFont(name: "Fivo Sans", size: 18)!
//        ]
//
//        self.navigationItem.standardAppearance = appearance
//        self.navigationItem.compactAppearance = appearance
//        self.navigationItem.scrollEdgeAppearance = appearance
//
//        navigationController?.navigationBar.prefersLargeTitles = true
//
//        let leftButton = UIBarButtonItem(
//            title: setDate(),
//            style: .plain,
//            target: self,
//            action: #selector(moveToCalendarView)
//        )
//
//        navigationItem.setLeftBarButton(leftButton, animated: true)
//    }
    
    
    
    
    
    
    

}

//extension DoViewController: VerticalCardSwiperDatasource {
//    func numberOfCards(verticalCardSwiperView: VerticalCardSwiperView) -> Int {
//        return items?.count ?? 0
//    }
//
//    func cardForItemAt(verticalCardSwiperView: VerticalCardSwiperView, cardForItemAt index: Int) -> CardCell {
//        if let cardCell = verticalCardSwiperView.dequeueReusableCell(withReuseIdentifier: "ToDoCell", for: index) as? ToDoCardCell {
//            let item = items?[index]
//
//            cardCell.setBackgroundColor(item?.firstColor, item?.secondColor)
//            cardCell.setImportance(ratingCount: item?.importance ?? 0)
//            cardCell.setDate(date: item?.timestamp ?? Date())
//            cardCell.setDescriptionTextView(text: item?.content ?? "")
//            cardCell.setTitleLabel(title: item?.title ?? "")
//            cardCell.setIconImage(item!.imageData)
//
//            return cardCell
//        }
//        return CardCell()
//    }
//}
//
//extension DoViewController: VerticalCardSwiperDelegate {
//    func willSwipeCardAway(card: CardCell, index: Int, swipeDirection: SwipeDirection) {
//        let item = items?[index]
//
//        switch swipeDirection {
//        case .Left:
//            modelManager.remove(item!)
//        case .Right:
//            modelManager.changeDoneCondition(item: item!, condition: true)
//        case .None:
//            break
//        }
//    }
//
//    func didSwipeCardAway(card: CardCell, index: Int, swipeDirection: SwipeDirection) {
//        setNavigationTitle()
//    }
//
//    func didTapCard(verticalCardSwiperView: VerticalCardSwiperView, index: Int) {
//        print("Tapped")
//    }
//}
