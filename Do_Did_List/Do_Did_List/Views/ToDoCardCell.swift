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
    
    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var importance: CosmosView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    override func awakeFromNib() {
        navBar.tintColor = UIColor.lightGray
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = 15
    }
    
    func setBackgroundColor(_ firstColor: Data?, _ secondColor: Data?) {
        
        guard let colorOne = UIColor.decodeToColor(data: firstColor!) else { return }
        guard let colorTwo = UIColor.decodeToColor(data: secondColor!) else { return }
        
        self.setGradientBackgroundColor(colorOne: colorOne, colorTow: colorTwo)
    }
    
    func setIconImage(image: UIImage) {
        
    }
    
    func setNavigationBar(timestamp: Date) {
        
    }
    
    func setTitleLabel(title: String) {
        titleLabel.text = title
    }
    
    func setImportance(ratingCount: Double) {
        importance.rating = ratingCount
    }
    
    func setDescriptionTextView(text: String) {
        descriptionTextView.text = text
    }
    
}
