//
//  ToDoTableViewCell.swift
//  Do_Did_List
//
//  Created by 강민석 on 2020/02/24.
//  Copyright © 2020 MinseokKang. All rights reserved.
//

import UIKit
import Cosmos
import M13Checkbox
import VerticalCardSwiper

class ToDoCardCell: CardCell {
    
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var importance: CosmosView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var checkbox: M13Checkbox!
    

    
}
