//
//  ProfileHeaderView.swift
//  DMProfileView
//
//  Created by Dana Majid on 15/10/15.
//  Copyright © 2015 Dana Majid. All rights reserved.
//

import UIKit
import Cartography

class ProfileHeaderView: UIView {
    var backgroundImage: UIImageView?
    var userNameLabel: UILabel?
    var userBioLabel: UILabel?
    var userAvatar: UIImageView?
    var userPointsLabel: UILabel?
    //class func viewDidResizePercentage(percent: CGFloat!)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor(red: 40/255, green: 145/255, blue: 247/255, alpha: 1);

        //self.layer.masksToBounds = true
        self.layer.shadowOffset = CGSize(width: 0.2, height: 0.2)
        self.layer.shadowRadius = 1
        self.layer.shadowColor = UIColor.blackColor().CGColor
        self.layer.shadowOpacity = 0.25
        
        backgroundImage = UIImageView()
        backgroundImage?.layer.masksToBounds = true
        backgroundImage!.contentMode = .ScaleAspectFill
        backgroundImage!.alpha = 0.2;
        backgroundImage!.image = UIImage(named: "Couples")
        

        let blurView = UIVisualEffectView(effect: UIBlurEffect(style: .Light))
        blurView.alpha = 0.7
        backgroundImage!.addSubview(blurView)
        
        self.addSubview(backgroundImage!)
        
        
        userNameLabel = UILabel()
        userNameLabel!.font = UIFont.boldSystemFontOfSize(17)
        userNameLabel!.textColor = UIColor.whiteColor()
        userNameLabel!.text = "Dana Majid"
        self.addSubview(userNameLabel!)
        
        userBioLabel = UILabel()
        userBioLabel!.font = UIFont.boldSystemFontOfSize(15)
        userBioLabel!.textColor = UIColor.whiteColor()
        userBioLabel!.text = "Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum"
        userBioLabel!.numberOfLines = 0
        userBioLabel!.textAlignment = .Center
        self.addSubview(userBioLabel!)

        
        userAvatar = UIImageView()
        
        userAvatar!.image = UIImage(named: "Dana")
        userAvatar!.contentMode = .ScaleAspectFill
        userAvatar!.layer.cornerRadius = 30
        userAvatar!.layer.masksToBounds = true
        self.addSubview(userAvatar!)
        
        constrain(backgroundImage!, userAvatar!, userNameLabel!, userBioLabel!, blurView) { background, avatar, name, bio, blur in
            background.width == background.superview!.width
            background.height == background.superview!.height
            background.left == background.superview!.left
            background.centerY == background.superview!.centerY
            
            blur.width == background.width
            blur.height == background.height
            blur.left == background.left
            blur.centerY == background.centerY
            
            avatar.centerX == avatar.superview!.centerX
            avatar.centerY == avatar.superview!.centerY - 66
            avatar.height == 60
            avatar.width == 60
            
            name.centerX == name.superview!.centerX
            name.top == avatar.bottom + 12
            name.height == 20
            
            bio.centerX == bio.superview!.centerX
            bio.top == name.bottom + 3
            bio.height == 60
            bio.left == bio.superview!.left + 40
            bio.right == bio.superview!.right - 40
        }
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ProfileHeaderView {
    func updateSubviewsForPercent(percent: CGFloat, minimum: CGFloat) {
        let resizePercent: CGFloat = round(percent * 1000) / 1000
        let resizePercentMin: CGFloat = round(minimum * 1000) / 1000
        
        let finalPercent = (resizePercent/resizePercentMin) - 1;
        
        if (finalPercent <= 0) {
            self.userBioLabel?.alpha = 0
            self.userAvatar?.alpha = 0
        } else if (finalPercent >= 1) {
            self.userBioLabel?.alpha = 1
            self.userAvatar?.alpha = 1
        } else {
            self.userBioLabel?.alpha = finalPercent
            self.userAvatar?.alpha = finalPercent
        }
    }
}