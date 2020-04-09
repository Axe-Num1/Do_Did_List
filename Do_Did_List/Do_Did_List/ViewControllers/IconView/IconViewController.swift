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
var imageData: Data?

class IconViewController: UIViewController {
    
    @IBOutlet weak var iconView: IconView!
    @IBOutlet weak var selectColorView: UIView!
    @IBOutlet weak var selectGlyphView: UIView!
    
    
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
        let renderer = UIGraphicsImageRenderer(size: iconView.bounds.size)
        let image = renderer.image { ctx in
            iconView.drawHierarchy(in: iconView.bounds, afterScreenUpdates: true)
        }
        let finalIconDict: [String: UIImage] = ["finalIcon": image]
        NotificationCenter.default.post(name: NSNotification.Name("finalIcon"), object: nil, userInfo: finalIconDict)
        
        imageData = image.pngData()
        
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
        firstColorData = colors[0].encodeToData()
        secondColorData = colors[1].encodeToData()
        iconView.backgroundImage.image = nil
        iconView.topColor = colors[0]
        iconView.bottomColor = colors[1]
    }
    
    @objc private func handleChangeIcon(notification: Notification) {
        guard let iconDict = notification.userInfo else { return }
        guard let image = iconDict["iconDict"] as? UIImage else { return }
        iconView.backgroundImage.image = nil
        iconView.image.image = image
        iconView.image.image = iconView.image.image?.withRenderingMode(.alwaysTemplate)
        iconView.image.tintColor = .white
        iconView.contentMode = .scaleAspectFit
    }
    
    func setupIconView() {
        iconView.roundCorners(.allCorners, radius: 32)
        NotificationCenter.default.addObserver(self, selector: #selector(handleChangeColor), name: NSNotification.Name(rawValue: "colorRefersh"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleChangeIcon), name: Notification.Name(rawValue: "iconRefresh"), object: nil)
    }
    
}
