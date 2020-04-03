//
//  IconViewController.swift
//  Do_Did_List
//
//  Created by 강민석 on 2020/03/25.
//  Copyright © 2020 MinseokKang. All rights reserved.
//

import UIKit

var firstColorData: Data?
var secondColorData: Data?

protocol IconViewControllerDelegate: NSObjectProtocol {
    func iconName(name: String)
}

class IconViewController: UIViewController {
    
    @IBOutlet weak var iconView: IconView!
    @IBOutlet weak var selectColorView: UIView!
    @IBOutlet weak var selectGlyphView: UIView!
    
    weak var delegate: IconViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        isModalInPresentation = true
        
        switchViews(firstView: 1.0, secondView: 0.0)
        
        setupIconView()
        
    }
    
    @IBAction func handleSelectView(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            UIView.animate(withDuration: 0.3) {
                self.switchViews(firstView: 1.0, secondView: 0.0)
            }
        case 1:
            UIView.animate(withDuration: 0.3) {
                self.switchViews(firstView: 0.0, secondView: 1.0)
            }
        default:
            break
        }
    }
    
    @IBAction func doneButton(_ sender: Any) {
        delegate?.iconName(name: "testing")
        isModalInPresentation = false
        dismiss(animated: true, completion: nil)
    }
    
    private func switchViews(firstView: CGFloat, secondView: CGFloat) {
        selectColorView.alpha = firstView
        selectGlyphView.alpha = secondView
    }
    
    @objc func handleChangeColor(notification:  Notification) {
        guard let colorDict = notification.userInfo else { return }
        guard let colors = colorDict["colorDict"] as? [UIColor] else { return }
        //        firstColorData = colors[0].encode()
        //        secondColorData = colors[1].encode()
        iconView.backgroundImage.image = nil
        iconView.topColor = colors[0]
        iconView.bottomColor = colors[1]
    }
    
    func setupIconView() {
        iconView.roundCorners(.allCorners, radius: 32)
        NotificationCenter.default.addObserver(self, selector: #selector(handleChangeColor), name: NSNotification.Name(rawValue: "colorRefersh"), object: nil)
        
        //        NotificationCenter.default.addObserver(self, selector: #selector(handleChangeIcon), name: Notification.Name(rawValue: "iconRefresh"), object: nil)
    }
    
}
