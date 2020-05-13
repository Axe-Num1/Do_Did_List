//
//  ToDoItem.swift
//  DoDidList
//
//  Created by 강민석 on 2020/05/13.
//  Copyright © 2020 MinseokKang. All rights reserved.
//

import Foundation
import RealmSwift

class ToDoItem: Object {
    
    @objc dynamic var id: String = UUID().uuidString // 고유 아이디
    
    @objc dynamic var title: String = ""
    
    // icon 관련 데이터
    @objc dynamic var firstColor: Data = Data()
    @objc dynamic var secondColor: Data = Data()
    @objc dynamic var iconImageData: Data = Data()
    
    @objc dynamic var timestamp: Date = Date()
    @objc dynamic var importance: Double = 0.0
    @objc dynamic var content: String = ""
    
    @objc dynamic var isDone: Bool = false
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    convenience init(title: String, firstColor: Data, secondColor: Data, imageData: Data, timestamp: Date, importance: Double, content: String, isDone: Bool) {
        self.init()
        
        self.title = title
        
        self.firstColor = firstColor
        self.secondColor = secondColor
        self.iconImageData = imageData
        
        self.timestamp = timestamp
        self.importance = importance
        self.content = content
        
        self.isDone = isDone
    }
}
