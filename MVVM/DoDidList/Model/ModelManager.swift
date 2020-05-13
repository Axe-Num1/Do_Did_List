//
//  ModelManager.swift
//  DoDidList
//
//  Created by 강민석 on 2020/05/13.
//  Copyright © 2020 MinseokKang. All rights reserved.
//

import Foundation
import RealmSwift

enum DateType {
    case today
    case thisMonth
    case allDate
    case customDate
}

class ModelManager {
    
    var realm: Realm!
    
    init() {
        realm = try! Realm()
    }
    
    /**
     realm 로컬 DB로 Item 추가(쓰기) 기능을 수행합니다.
     
     - parameters:
        - item: DB에 추가할 아이템
     */
    func add(_ item: ToDoItem) {
        do {
            try realm.write {
                realm.add(item)
            }
        } catch {
            print("Faild to add!")
        }
    }
    
    /**
     realm 로컬 DB로 Item 삭제(쓰기) 기능을 수행합니다.
     
     - parameters:
        - item: DB에서 삭제할 아이템
     */
    func remove(_ item: ToDoItem) {
        do {
            try realm.write {
                realm.delete(item)
            }
        } catch {
            print("Faild to remove")
        }
    }
    
    /**
     원하는 날짜 범위의 아이템을 반환합니다.
     
     - parameters:
         - dateType: 검색할 날짜 범위
         - customDate: 검색할 지정 날짜
     */
    func searchDate(dateType: DateType, customDate: Date = Date()) -> Results<ToDoItem> {
        let result: Results<ToDoItem>
        let date = Date()
        
        switch dateType {
        case .today:
            result = realm.objects(ToDoItem.self).filter(NSPredicate(format: "timestamp >= %@ && timestamp <= %@", date.startOfDay as NSDate, date.endOfDay as NSDate))
        case .thisMonth:
            result = realm.objects(ToDoItem.self).filter(NSPredicate(format: "timestamp >= %@ && timestamp <= %@", date.startOfMonth as NSDate, date.endOfMonth as NSDate))
        case .allDate:
            result = realm.objects(ToDoItem.self)
        case .customDate:
            result = realm.objects(ToDoItem.self).filter(NSPredicate(format: "timestamp >= %@ && timestamp <= %@", customDate.startOfDay as NSDate, customDate.endOfDay as NSDate))
        }
        
        return result
    }
    
    /**
     입력한 Done 여부를 가지고 있는 ToDoItem을 필터링하여 반환합니다.
     
     - parameters:
         - original: 기존 ToDoItem 배열
         - isDone: 필터링할 done 여부
     */
    func filterDoneCondition(original: Results<ToDoItem>, isDone: Bool) -> Results<ToDoItem> {
        let result: Results<ToDoItem>
        
        switch isDone {
        case true:
            result = original.filter(NSPredicate(format: "isDone == true"))
        case false:
            result = original.filter(NSPredicate(format: "isDone == false"))
        }
        
        return result
    }
    
    /**
     ToDoItem의 done컨디션을 변경합니다.
     
     - parameters:
         - item: done 컨디션을 변경할 아이템
         - condition: 변경할 컨디션
     */
    func changeDoneCondition(item: ToDoItem, condition: Bool) {
        do {
            try realm.write {
                item.isDone = condition
            }
        } catch {
            print("Faild to change condition")
        }
    }
    
}
