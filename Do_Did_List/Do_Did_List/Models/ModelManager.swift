//
//  ModelManager.swift
//  Do_Did_List
//
//  Created by 강민석 on 2020/03/18.
//  Copyright © 2020 MinseokKang. All rights reserved.
//

import Foundation
import RealmSwift

class ModelManager {
    
    var realm: Realm!
    
    init() {
        realm = try! Realm()
    }
    
    func add(_ item: ToDoItem) {
        do {
            try realm.write {
                realm.add(item)
            }
        } catch {
            print("Faild to add")
        }
    }
    
    func remove(_ item: ToDoItem) {
        do {
            try realm.write {
                realm.delete(item)
            }
        } catch {
            print("Faild to remove")
        }
    }
    
    func sync() {
        
    }
    
}
