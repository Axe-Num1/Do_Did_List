//
//  NewToDoTableViewController.swift
//  Do_Did_List
//
//  Created by 강민석 on 2020/03/08.
//  Copyright © 2020 MinseokKang. All rights reserved.
//

import UIKit
import Cosmos
import RealmSwift

class NewToDoTableViewController: UITableViewController {
    
    let realm = try! Realm()
    
//    let items: Results<ToDoItem>
    
    @IBOutlet weak var categoryName: UITextField!
    
    @IBOutlet weak var categoryIcon: UIButton!
    
    @IBOutlet weak var timePicker: UIDatePicker!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var arrowImage: UIImageView!
    
    @IBOutlet weak var starRating: CosmosView!
    
    @IBOutlet weak var contentTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        contentTextView.delegate = self
        textViewSetupView()
        
        onDidChangeDate(timePicker)
        
        timePicker.isHidden = true
        arrowDirection()
        
//        print(Realm.Configuration.defaultConfiguration.fileURL!)
    }
    
    func arrowDirection() {
        let imageName = timePicker.isHidden ? "Popover Arrow Down" : "Popover Arrow Up"
        arrowImage.image = UIImage(named: imageName)
    }
    
    func add() {
        let item = ToDoItem()
        
        guard let text = self.categoryName.text else {
            print("none")
            return
        }
        item.categoryName = text
        
        try! realm.write {
            self.realm.add(item)
        }
    }
    
    @IBAction func onDidChangeDate(_ sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd-hh:mm a"
        
        let selectDate = dateFormatter.string(from: sender.date)
        
        timeLabel.text = selectDate
    }
}


 // MARK: - UITableViewDelegate
extension NewToDoTableViewController {
   
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 1 && indexPath.row == 1 {
            let height: CGFloat = timePicker.isHidden ? 0.0 : 216.0
            return height
        }
        
        return super.tableView(tableView, heightForRowAt: indexPath)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let timeIndexPath1 = NSIndexPath(row: 0, section: 1) as IndexPath
        let timeIndexPath2 = NSIndexPath(row: 2, section: 1) as IndexPath
        
        if timeIndexPath1 == indexPath || timeIndexPath2 == indexPath {
            
            timePicker.isHidden = !timePicker.isHidden
            
            UIView.animate(withDuration: 0.25) {
                self.tableView.beginUpdates()
                // apple bug fix - some TV lines hide after animation
                self.tableView.deselectRow(at: indexPath, animated: true)
                self.tableView.endUpdates()
            }
            
            arrowDirection()
        }
        
        let cell = tableView.cellForRow(at: indexPath)
        cell?.selectionStyle = .none
    }
}


// MARK: - UITextView Custom Placeholder
extension NewToDoTableViewController: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        textViewSetupView()
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        textViewSetupView()
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            contentTextView.resignFirstResponder()
        }
        return true
    }
    
    func textViewSetupView() {
        if contentTextView.text == "To Do:" {
            contentTextView.text = ""
            contentTextView.textColor = UIColor.black
        } else if contentTextView.text == "" {
            contentTextView.text = "To Do:"
            contentTextView.textColor = UIColor.lightGray
        }
    }
}
