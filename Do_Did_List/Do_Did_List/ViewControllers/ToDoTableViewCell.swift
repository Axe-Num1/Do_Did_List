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

class ToDoTableViewCell: UITableViewCell {
    
    @IBOutlet weak var contentTextView: UITextView!
    
    @IBOutlet weak var importance: CosmosView!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var checkbox: M13Checkbox!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
