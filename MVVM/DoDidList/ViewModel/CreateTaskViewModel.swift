//
//  CreateTaskViewModel.swift
//  DoDidList
//
//  Created by 강민석 on 2020/05/23.
//  Copyright © 2020 MinseokKang. All rights reserved.
//

import Foundation
import RealmSwift
import RxRealm

import RxCocoa
import RxSwift

class CreateTaskViewModel {
    
    let modelManager = ModelManager()
    
    let taskTitle = BehaviorRelay(value: "")
    let content = BehaviorRelay(value: "")
    let taskTime = BehaviorRelay(value: Date())
    let iconImage = BehaviorRelay(value: UIImage())
    
    var starRating = 0.0
    
    func saveTask() {
        
        let iconImageData = iconImage.value.pngData()
        
        let item = ToDoItem(title: taskTitle.value,
                            imageData: iconImageData!,
                            timestamp: taskTime.value,
                            importance: starRating,
                            content: content.value,
                            isDone: false)
        
        modelManager.add(item)
    }
    
    
}
