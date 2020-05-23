//
//  TodayTaskTableViewCell.swift
//  DoDidList
//
//  Created by 강민석 on 2020/05/23.
//  Copyright © 2020 MinseokKang. All rights reserved.
//

import UIKit
import Cosmos

class TodayTaskTableViewCell: UITableViewCell {
    
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var taskTitleLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var starRatingView: CosmosView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        starRatingView.settings.fillMode = .half
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
}
