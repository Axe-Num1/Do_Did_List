//
//  AddToDoViewController.swift
//  Do_Did_List
//
//  Created by 강민석 on 2020/03/01.
//  Copyright © 2020 MinseokKang. All rights reserved.
//

import UIKit
import RealmSwift

class AddToDoViewController: UIViewController {
    
    @IBOutlet weak var addToDoTableView: UITableView!
    
    let modelManager = ModelManager()
    var items: Results<ToDoItem>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addToDoTableView.delegate = self
        addToDoTableView.dataSource = self
        
        navigationBarSet()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        items = modelManager.searchDate(dateType: .today, date: Date())
        items = items?.sorted(byKeyPath: "timestamp", ascending: true)
    
        UIView.transition(with: addToDoTableView.self, duration: 0.4, options: .transitionCrossDissolve, animations: { self.addToDoTableView.reloadData() })
    }
    
    @IBAction func doneButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func navigationBarSet() {

        if #available(iOS 13.0, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithTransparentBackground()
            appearance.titleTextAttributes = [.foregroundColor: UIColor.black]
            appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.black]

            UINavigationBar.appearance().tintColor = .white
            UINavigationBar.appearance().standardAppearance = appearance
            UINavigationBar.appearance().compactAppearance = appearance
            UINavigationBar.appearance().scrollEdgeAppearance = appearance
        } else {
            UINavigationBar.appearance().tintColor = .white
            UINavigationBar.appearance().barTintColor = .clear
            UINavigationBar.appearance().isTranslucent = false
        }
    }
    
}

// MARK: - UITableViewDataSource
extension AddToDoViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        if items?.count == 0 {
            tableView.setEmptyView(title: "Today ToDo is Empty", message: "Add ToDo", subImage: UIImage(named: "Arrow"))
        } else {
            tableView.restore()
        }
        
        return items?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "addToDoCell", for: indexPath) as! AddToDoTableViewCell
        
        let item = items?[indexPath.section]
        cell.setIcon(imageData: item!.imageData, firstColor: item!.firstColor, secondColor: item!.secondColor)
        cell.setTime(date: item!.timestamp)
        cell.titleLabel.text = item?.title
        cell.contentLabel.text = item?.content
        cell.starRating.rating = item!.importance
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        
        if let item = items?[indexPath.section] {
            modelManager.remove(item)
            tableView.deleteSections(IndexSet(arrayLiteral: indexPath.section), with: .fade)
        }
    }
}

// MARK: - UITableViewDelegate
extension AddToDoViewController: UITableViewDelegate {
    
}
