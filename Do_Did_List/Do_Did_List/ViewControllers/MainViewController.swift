//
//  MainViewController.swift
//  Do_Did_List
//
//  Created by 강민석 on 2020/02/22.
//  Copyright © 2020 MinseokKang. All rights reserved.
//

import UIKit
import SideMenu

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.setUpSideMenu()
    }
    
    // Status Bar 색상 설정
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent // white
    }
    
    @IBAction func sideMenuButton(_ sender: Any) {
        present(SideMenuManager.default.leftMenuNavigationController!, animated: true, completion: nil)
    }
}


// MARK: SideMenu Implementation
extension MainViewController {
    
    func setUpSideMenu() {
        let sideMenu = SideMenuViewController(nibName: "SideMenuViewController", bundle: nil)
        
        let leftMenuNavigationController = SideMenuNavigationController(rootViewController: sideMenu)
        SideMenuManager.default.leftMenuNavigationController = leftMenuNavigationController
        
        // status bar alpha 값
        leftMenuNavigationController.statusBarEndAlpha = 0
        
        // Side Menu presentation 방식
        leftMenuNavigationController.presentationStyle = .menuSlideIn
        
        // swipe 제스처를 사용하여 Side Menu 열기
//        SideMenuManager.default.addPanGestureToPresent(toView: self.view)
//        SideMenuManager.default.addScreenEdgePanGesturesToPresent(toView: self.view)
        
    }
}

// MARK: - UISideMenuNavigationControllerDelegate
extension MainViewController: SideMenuNavigationControllerDelegate {

    func sideMenuWillAppear(menu: SideMenuNavigationController, animated: Bool) {
        print("SideMenu Appearing! (animated: \(animated))")
    }

    func sideMenuDidAppear(menu: SideMenuNavigationController, animated: Bool) {
        print("SideMenu Appeared! (animated: \(animated))")
    }

    func sideMenuWillDisappear(menu: SideMenuNavigationController, animated: Bool) {
        print("SideMenu Disappearing! (animated: \(animated))")
    }

    func sideMenuDidDisappear(menu: SideMenuNavigationController, animated: Bool) {
        print("SideMenu Disappeared! (animated: \(animated))")
    }
}
