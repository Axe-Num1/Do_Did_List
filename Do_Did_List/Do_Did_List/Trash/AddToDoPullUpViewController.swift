//
//  AddToDoPullUpViewController.swift
//  Do_Did_List
//
//  Created by 강민석 on 2020/03/02.
//  Copyright © 2020 MinseokKang. All rights reserved.
//

import UIKit
import SOPullUpView

class AddToDoPullUpViewController: UIViewController {
    
    @IBOutlet weak var handleArea: UIView!
    @IBOutlet weak var topLine: UIImageView!
    @IBOutlet weak var navigationBar: UINavigationBar!
    
    var pullUpControl: SOPullUpControl? {
        didSet {
            pullUpControl?.delegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        topLine.alpha = 0
        navigationBar.isUserInteractionEnabled = false
        
    }
    
    @IBAction func addToDo(_ sender: UIBarButtonItem) {
        var managed: NewToDoTableViewController? {
            return self.children.last as! NewToDoTableViewController?
        }
//        managed?.passToManager(sender: self)
    }
    
}

// MARK: - SOPullUpViewDelegate

extension AddToDoPullUpViewController: SOPullUpViewDelegate {

    func pullUpViewStatus(_ sender: UIViewController, didChangeTo status: PullUpStatus) {
        switch status {
        case .collapsed:
            UIView.animate(withDuration: 0.7) { [weak self] in
                self?.topLine.alpha = 0
            }
            navigationBar.isUserInteractionEnabled = false
        case .expanded:
            UIView.animate(withDuration: 0.7) { [weak self] in
                self?.topLine.alpha = 1
            }
            navigationBar.isUserInteractionEnabled = true
        }
    }
    
    func pullUpHandleArea(_ sender: UIViewController) -> UIView {
        return handleArea
    }
}
