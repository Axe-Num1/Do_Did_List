//
//  NewToDoTableViewController.swift
//  Do_Did_List
//
//  Created by 강민석 on 2020/03/08.
//  Copyright © 2020 MinseokKang. All rights reserved.
//

import UIKit
import Cosmos

class NewToDoTableViewController: UITableViewController {
    
    @IBOutlet weak var categoryName: UITextField!
    
    @IBOutlet weak var categoryIcon: UIButton!
    
    @IBOutlet weak var timePicker: UIDatePicker!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var arrowImage: UIImageView!
    
    @IBOutlet weak var starRating: CosmosView!
    
    @IBOutlet weak var contentTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let formatterTime = DateFormatter()
        formatterTime.dateFormat = "HH:mm"
        timeLabel.text = "\(formatterTime.string(from: Date()))"
        
        timePicker.isHidden = true
        arrowImage.image = UIImage(named: "Popover Arrow Down")
        format()
    }
    
    func format() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .full
        dateFormatter.timeStyle = .short
        
        let str = dateFormatter.string(from: Date())
        
        let date = dateFormatter.date(from: str)
        
        timePicker.date = date!
    }
    
    @IBAction func setTime(_ sender: UIDatePicker) {
        timeLabel.text = "\(sender.date)"
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 1 && indexPath.row == 1 {
            let height: CGFloat = timePicker.isHidden ? 0.0 : 216.0
            return height
        }
        
        return super.tableView(tableView, heightForRowAt: indexPath)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let timeIndexPath = NSIndexPath(row: 0, section: 1) as IndexPath
        
        if timeIndexPath == indexPath {
            
            timePicker.isHidden = !timePicker.isHidden
            
            UIView.animate(withDuration: 0.25) {
                self.tableView.beginUpdates()
                // apple bug fix - some TV lines hide after animation
                self.tableView.deselectRow(at: indexPath, animated: true)
                self.tableView.endUpdates()
            }
            
            let imageName = timePicker.isHidden ? "Popover Arrow Down" : "Popover Arrow Up"
            arrowImage.image = UIImage(named: imageName)
        }
        
        let cell = tableView.cellForRow(at: indexPath)
        cell?.selectionStyle = .none
    }
    
}
