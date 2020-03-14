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
    
    @IBOutlet weak var categoryName: UITextField!
    
    @IBOutlet weak var categoryIcon: UIButton!
    
    @IBOutlet weak var timePicker: UIDatePicker!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var arrowImage: UIImageView!
    
    @IBOutlet weak var starRating: CosmosView!
    
    @IBOutlet weak var contentTextView: UITextView!

    let item = ToDoItem()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        contentTextView.delegate = self
        textViewSetupView()
        
        onDidChangeDate(timePicker)
        
        timePicker.isHidden = true
        arrowDirection()
    }
    
    func arrowDirection() {
        let imageName = timePicker.isHidden ? "Popover Arrow Down" : "Popover Arrow Up"
        arrowImage.image = UIImage(named: imageName)
    }
    
    func add() {
        if let text = self.categoryName.text {
            item.categoryName = text
        }
        
        let realm = try! Realm()
        
        //write 트랜젝션
        try! realm.write {
            //객체 복사 및 업데이트
            //해당 객체가 있으면 업데이트를 하고 아니면 새로 생성한다.
            //companyInfo의 값이 복사되어 새로운 객체가 생성된다.
            //새로 생성된 객체는 관리객체, 원본은 비관리객체로 남게된다.
            let newToDo = realm.create(ToDoItem.self, value: item, update: .all)
            
            //object add and update
            //객체 add 및 업데이트
            //companyInfo가 관리객체로 변경이 된다.
            //add함수 이후 companyInfo를 수정하면 realm에도 반영이 된다.
            realm.add(item, update: .all)
        }
        
        // Realm파일이 생성되는 위치 출력
//        print(Realm.Configuration.defaultConfiguration.fileURL!)
        
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
