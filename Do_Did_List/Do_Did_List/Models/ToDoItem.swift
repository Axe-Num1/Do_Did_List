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
    
    
}
