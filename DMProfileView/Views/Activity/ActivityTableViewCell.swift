//
//  ActivityTableView.swift
//  DMProfileView
//
//  Created by Dana Majid on 12/10/15.
//  Copyright © 2015 Dana Majid. All rights reserved.
//

import Foundation
import UIKit
import ActiveLabel
import Cartography

class ActivityTableViewCell: UITableViewCell {
    internal var label:ActiveLabel!
    internal var timeLabel:UILabel!
    internal var avatarImageView: UIImageView!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .None
        self.separatorInset = UIEdgeInsetsZero
        self.preservesSuperviewLayoutMargins = false
        self.layoutMargins = UIEdgeInsetsZero
        
        // Create text label
        label = ActiveLabel()
        label.hashtagColor = UIColor(red: 40/255, green: 145/255, blue: 247/255, alpha: 1)
        label.URLColor = UIColor(red: 40/255, green: 145/255, blue: 247/255, alpha: 1)
        label.mentionColor = UIColor(red: 40/255, green: 145/255, blue: 247/255, alpha: 1)
        label!.numberOfLines = 0
        label!.text = ""
        label.font = UIFont.systemFontOfSize(14)
        label!.textColor = .blackColor()
        label!.handleHashtagTap { hashtag in
            print("Success. You just tapped the \(hashtag) hashtag")
        }
        
        self.addSubview(label)
        
        constrain(self, label) { cell, label in           
            label.right == cell.rightMargin - 20
            label.top == cell.topMargin
            label.bottom == cell.bottomMargin
            label.left == cell.leftMargin + 20
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}