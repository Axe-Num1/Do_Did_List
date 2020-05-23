//
//  TodayTaskViewController.swift
//  DoDidList
//
//  Created by 강민석 on 2020/05/22.
//  Copyright © 2020 MinseokKang. All rights reserved.
//

import UIKit
import RealmSwift
import RxRealm

import RxSwift
import RxCocoa

class TodayTaskViewController: UIViewController {
    
    let disposeBag = DisposeBag()
    let viewModel = DoDidViewModel(type: .All)

    @IBOutlet weak var todayTaskTableView: UITableView!
    @IBOutlet weak var doneButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        doneButton.rx.tap
            .subscribe { self.navigationController?.popViewController(animated: true) }
            .disposed(by: disposeBag)

        bindViewModel()
    }
    
    func bindViewModel() {
        Observable.from(optional: viewModel.items)
            .bind(to: todayTaskTableView.rx.items(cellIdentifier: "TodayTaskCell", cellType: TodayTaskTableViewCell.self)) { row, element, cell in
                let iconImage = UIImage(data: element.iconImageData)
                cell.iconImage.image = iconImage
                cell.taskTitleLabel.text = element.title
                cell.contentLabel.text = element.content
                cell.starRatingView.rating = element.importance
            }
            .disposed(by: disposeBag)
        
    }
    
}
