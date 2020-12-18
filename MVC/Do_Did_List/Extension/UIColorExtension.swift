//
//  UIColorExtension.swift
//  Do_Did_List
//
//  Created by 강민석 on 2020/04/04.
//  Copyright © 2020 MinseokKang. All rights reserved.
//

import UIKit

extension UIColor {
  class func decodeToColor(data:Data) -> UIColor? {
    return try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? UIColor
  }
  
  func encodeToData() -> Data? {
    return try? NSKeyedArchiver.archivedData(withRootObject: self, requiringSecureCoding: false)
  }
}
