//
//  tabMainViewController.swift
//  iostodolistapp
//
//  Created by adriansalim on 02/06/20.
//  Copyright © 2020 adriansalim. All rights reserved.
//

import UIKit

class TabMainViewController: UITabBarController, UITabBarControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.showTitleTabBar()
        self.delegate = self
        
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        print(item)
        if(item.tag == 3) {
            let vc = HistoryViewController()
            self.navigationController?.pushViewController(vc, animated:true)
        }
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
    }
    
    func showTitleTabBar() {
        let appearance = UITabBarItem.appearance()
        let attributes = [NSAttributedString.Key.font:UIFont.systemFont(ofSize: 20.0)]
        appearance.setTitleTextAttributes(attributes as [NSAttributedString.Key : Any], for: .normal)
        
        let tabHome = HomeViewController()
        let tabHomeBarItem = UITabBarItem(title: "Home", image: nil, selectedImage: nil)
        tabHomeBarItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -16)
        tabHomeBarItem.tag = 0
        tabHome.tabBarItem = tabHomeBarItem
        
        let tabFeed = HomeViewController()
        let tabFeedBarItem = UITabBarItem(title: "Feed", image: nil, selectedImage: nil)
        tabFeedBarItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -16)
        tabFeedBarItem.tag = 1
        tabFeed.tabBarItem = tabFeedBarItem
        
        let tabCart = HomeViewController()
        let tabCartBarItem = UITabBarItem(title: "Cart", image: nil, selectedImage: nil)
        tabCartBarItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -16)
        tabCartBarItem.tag = 2
        tabCart.tabBarItem = tabCartBarItem
        
        let tabProfile = HomeViewController()
        let tabProfileBarItem = UITabBarItem(title: "Profile", image: nil, selectedImage: nil)
        tabProfileBarItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -16)
        tabProfileBarItem.tag = 3
        tabProfile.tabBarItem = tabProfileBarItem
        
        self.viewControllers = [tabHome, tabFeed, tabCart, tabProfile]
    }
    
    @objc func leftBarButtonItemAction_Cross(sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        get {
            return .default
        }
    }
    
}
