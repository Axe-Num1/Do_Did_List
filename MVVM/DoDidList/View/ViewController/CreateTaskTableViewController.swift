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
    @IBOutlet weak var starRatingView: CosmosView!
    @IBOutlet weak var contentTextView: UITextView!
    
    @IBOutlet weak var addButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        bindViewModel()
    }
    
    func bindViewModel() {
        
        taskTitleLabel.rx.text.orEmpty
            .bind(to: viewModel.taskTitle)
            .disposed(by: disposeBag)
        
        contentTextView.rx.text.orEmpty
            .bind(to: viewModel.content)
            .disposed(by: disposeBag)
        
//        datePicker.rx.date
//            .bind(to: viewModel.taskTime)
//            .disposed(by: disposeBag)
        
        addButton.rx.tap
            .subscribe { [weak self] in
                self?.viewModel.starRating = self?.starRatingView.rating as! Double
                self?.viewModel.saveTask()
            }
            .disposed(by: disposeBag)

        self.tableView.rx.itemSelected
            .subscribe { [weak self] in
                self?.createDatePicker(label: (self?.timeLabel)!)
            }
            .disposed(by: disposeBag)
        
    }
    
    
    func createDatePicker(label: UILabel) {
        let picker = UIDatePicker()
        
        print("dsfasdfasdf")
        
        picker.datePickerMode = .time

        picker.rx.date.subscribe(onNext: { element in
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd-hh:mm a"
            
            label.text = dateFormatter.string(from: picker.date)
        }).disposed(by: disposeBag)

        self.view.addSubview(picker)
    }
}
