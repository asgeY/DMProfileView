//
//  AppTabBarController.swift
//  DMProfileView
//
//  Created by Dana Majid on 07/10/15.
//  Copyright © 2015 Dana Majid. All rights reserved.
//

import Foundation
import UIKit

class AppTabBarController: UITabBarController, UITabBarControllerDelegate {
    var middleNavController: UINavigationController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set UI TabBarControllerDelegate so we can customize tap on items
        self.delegate = self;
        
        //self.modalPresentationStyle = .FullScreen
                
        // Initialize navigation controllers
        let profileNavController = UINavigationController()
        
        let profileViewController: ProfileViewController = ProfileViewController()
        
        // Set view controllers for each navigation controller
        profileNavController.viewControllers = [profileViewController]
        
        // Set each navigation tab bar item
        profileViewController.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(named: "profile")!.imageWithRenderingMode(.AlwaysOriginal), selectedImage: UIImage(named: "profile"))
        
        // Store which navigation controller is the middle one; so we can perform a modal transition for that one
        middleNavController = nil;
        self.tabBar.translucent = false
        profileNavController.navigationBar.translucent = false
        self.tabBar.barTintColor = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0)


        
        self.viewControllers = [profileNavController];
    }
    
    func tabBarController(tabBarController: UITabBarController, shouldSelectViewController viewController: UIViewController) -> Bool {

        return true;
    }

    

}