//
//  ProfileViewController.swift
//  DMProfileView
//
//  Created by Dana Majid on 07/10/15.
//  Copyright © 2015 Dana Majid. All rights reserved.
//

import UIKit
import Cartography

class ProfileViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.title = "Profile"
        self.navigationController?.navigationBarHidden = true
        
        let profileTableView = ProfileTableView()
        
        self.view.addSubview(profileTableView)
        
        
        constrain(profileTableView) { profileTableView in
            profileTableView.width == profileTableView.superview!.width
            profileTableView.height == profileTableView.superview!.height
            profileTableView.left == profileTableView.superview!.left
            profileTableView.top == profileTableView.superview!.top
        }
        
        //profileTableView.updateHeaderView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    func buttonAction(sender:UIButton!) {
        print("Button tapped", terminator: "")
    }
    
}
