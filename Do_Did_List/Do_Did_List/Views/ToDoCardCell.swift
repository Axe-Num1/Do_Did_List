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
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    @IBOutlet weak var starRatingView: CosmosView!
    @IBOutlet weak var navigationItem: UINavigationItem!
    
    @IBOutlet weak var colorView: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        starRatingView.settings.fillMode = .half
        setNavigationBar()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = 15
    }
    
    func setNavigationBar() {
        let appearance = UINavigationBarAppearance()
        
        appearance.configureWithDefaultBackground()
        appearance.titleTextAttributes = [.foregroundColor: UIColor.black]
                        
        UINavigationBar.appearance().tintColor = .white
        self.navigationItem.standardAppearance = appearance
        self.navigationItem.compactAppearance = appearance
        self.navigationItem.scrollEdgeAppearance = appearance
    }
    
    func setBackgroundColor(_ firstColor: Data?, _ secondColor: Data?) {
        guard let colorOne = UIColor.decodeToColor(data: firstColor!) else { return }
        
        colorView.backgroundColor = colorOne
    }
    
    func setIconImage(_ iconImageData: Data) {
        guard let iconImage = UIImage(data: iconImageData) else { return }
        
        let button = UIButton(type: .custom)
        button.setImage(iconImage, for: .normal)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.widthAnchor.constraint(equalToConstant: 35).isActive = true
        button.heightAnchor.constraint(equalToConstant: 35).isActive = true
        
        let barButton = UIBarButtonItem(customView: button)
        
        self.navigationItem.rightBarButtonItem = barButton
    }
    
    func setDate(date: Date) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm a"
        
        let selectDate = dateFormatter.string(from: date)
        
        navigationItem.title = selectDate
    }
    
    func setTitleLabel(title: String) {
        titleLabel.text = title
    }
    
    func setImportance(ratingCount: Double) {
        starRatingView.rating = ratingCount
    }
    
    func setDescriptionTextView(text: String) {
        descriptionTextView.text = text
    }
    
}
