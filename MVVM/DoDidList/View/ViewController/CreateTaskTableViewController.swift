//
//  CreateTaskViewController.swift
//  DoDidList
//
//  Created by 강민석 on 2020/05/22.
//  Copyright © 2020 MinseokKang. All rights reserved.
//

import UIKit
import Cosmos

import RxSwift
import RxCocoa
import RealmSwift
import RxRealm

class CreateTaskTableViewController: UITableViewController {
    
    let disposeBag = DisposeBag()
    let viewModel = CreateTaskViewModel()
    
    @IBOutlet weak var iconButton: UIButton!
    @IBOutlet weak var taskTitleLabel: UITextField!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var arrowImage: UIImageView!
    @IBOutlet weak var starRatingView: CosmosView!
    @IBOutlet weak var contentTextView: UITextView!
    
    @IBOutlet weak var addButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        datePicker.isHidden = true
        bindViewModel()
    }
    
    func bindViewModel() {
        
        taskTitleLabel.rx.text.orEmpty
            .bind(to: viewModel.taskTitle)
            .disposed(by: disposeBag)
        
        contentTextView.rx.text.orEmpty
            .bind(to: viewModel.content)
            .disposed(by: disposeBag)
        
        datePicker.rx.date
            .bind(to: viewModel.taskTime)
            .disposed(by: disposeBag)
        
        addButton.rx.tap
            .subscribe { [weak self] in
                self?.viewModel.starRating = self?.starRatingView.rating as! Double
                self?.viewModel.saveTask()
            }
            .disposed(by: disposeBag)

    }
}
