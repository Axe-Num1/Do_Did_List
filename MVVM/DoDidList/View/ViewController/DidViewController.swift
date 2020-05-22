//
//  DidViewController.swift
//  DoDidList
//
//  Created by 강민석 on 2020/05/21.
//  Copyright © 2020 MinseokKang. All rights reserved.
//

import UIKit
import RealmSwift
import RxRealm

import RxSwift
import RxCocoa

class DidViewController: UIViewController {

    var disposeBag = DisposeBag()
    
    let viewModel = DoDidViewModel()
    let modelManager = ModelManager()
    
    @IBOutlet weak var didTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIApplication.shared.applicationIconBadgeNumber = 0
        
        didTableView.register(UINib(nibName: "TaskTableViewCell", bundle: nil), forCellReuseIdentifier: "TaskCell")
        
        bindViewModel()
    }
    
    func bindViewModel() {
        viewModel.setItems(type: .Did)
        
        Observable.from(optional: viewModel.items)
            .bind(to: didTableView.rx.items(cellIdentifier: "TaskCell", cellType: TaskTableViewCell.self)) { row, element, cell in
                let iconImage = UIImage(data: element.iconImageData)
                cell.titleLabel.text = element.title
                cell.imageView?.image = iconImage
            }
            .disposed(by: disposeBag)
                

        
    }
    



}
