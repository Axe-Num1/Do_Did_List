//
//  DB.swift
//  Do_Did_List
//
//  Created by 강민석 on 2020/02/27.
//  Copyright © 2020 MinseokKang. All rights reserved.
//

import Foundation
import RealmSwift

class ToDoItem: Object {
    
    @objc dynamic var id: String = UUID().uuidString
    
    @objc dynamic var content: String = ""
    @objc dynamic var importance: Int = 0 // 0 ~ 3
    @objc dynamic var timestamp: Date = Date()
    @objc dynamic var isDone: Bool = false
    
    @objc dynamic var imageTag: Int = 0
    @objc dynamic var categoryName: String = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    init(categoryName: String, imageTag: Int, timestamp: Date, importance: Int, content: String, isDone: Bool) {
        self.categoryName = categoryName
        self.imageTag = imageTag
        self.timestamp = timestamp
        self.importance = importance
        self.content = content
        self.isDone = isDone
    }
    
    required init() {
//        fatalError("init() has not been implemented")
    }
    
}
