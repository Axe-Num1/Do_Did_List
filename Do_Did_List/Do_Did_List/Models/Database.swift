//
//  DB.swift
//  Do_Did_List
//
//  Created by 강민석 on 2020/02/27.
//  Copyright © 2020 MinseokKang. All rights reserved.
//

import Foundation
import RealmSwift

class Database: Object {
    @objc dynamic var category = ""
    @objc dynamic var content = ""
    @objc dynamic var importance = 0 // 0 ~ 3
    @objc dynamic var time = ""
    @objc dynamic var complete = false
}
