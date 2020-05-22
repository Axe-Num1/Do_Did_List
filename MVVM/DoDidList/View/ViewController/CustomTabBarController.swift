//
//  CustomTabBarController.swift
//  DoDidList
//
//  Created by 강민석 on 2020/05/22.
//  Copyright © 2020 MinseokKang. All rights reserved.
//

import UIKit

class CustomTabBarController:  UITabBarController {
    
    override func viewDidLoad(){
        super.viewDidLoad()
        self.delegate = self
    }
    
}

// MARK: - UITabBarControllerDelegate
extension CustomTabBarController: UITabBarControllerDelegate {
    
    // MARK: ModalPresent
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        if !(viewController is UINavigationController) {
            if let newVC = tabBarController.storyboard?.instantiateViewController(withIdentifier: "AddNav") {
                newVC.modalPresentationStyle = .fullScreen
                tabBarController.present(newVC, animated: true)
                return false
            }
        }
        return true
    }
}

