//
//  AddToDoTableViewCell.swift
//  Do_Did_List
//
//  Created by 강민석 on 2020/03/02.
//  Copyright © 2020 MinseokKang. All rights reserved.
//

import UIKit
import Cosmos

class AddToDoTableViewCell: UITableViewCell {

    @IBOutlet weak var categoryImage: UIImageView!
    
    @IBOutlet weak var categoryTitle: UILabel!
    
    @IBOutlet weak var contentLabel: UILabel!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var starRating: CosmosView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        let image = UIImage(named: "Category")?.withRenderingMode(.alwaysTemplate)
        
        categoryImage.tintColor = UIColor(red:0.30, green:0.85, blue:0.39, alpha:1.0)
        categoryImage.image = image
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        self.selectionStyle = .none
    }
    
}
