//
//  CustomTabBarController.swift
//  Do_Did_List
//
//  Created by 강민석 on 2020/04/22.
//  Copyright © 2020 MinseokKang. All rights reserved.
//

import UIKit

class CustomTabBarController:  UITabBarController, UITabBarControllerDelegate {
    
    override func viewDidLoad(){
        super.viewDidLoad()
        self.delegate = self
    }
    
    //MARK: UITabbar Delegate
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        if viewController.isKind(of: AddToDoViewController.self) {
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            
            guard let nav = storyboard.instantiateViewController(withIdentifier: "AddNav") as? UINavigationController else { return false }
            
            nav.modalPresentationStyle = .fullScreen
            self.present(nav, animated: true, completion: nil)
            return false
        }
        return true
    }
}
