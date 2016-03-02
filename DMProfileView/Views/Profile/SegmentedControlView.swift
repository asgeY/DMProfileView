//
//  SegmentedControlView.swift
//  DMProfileView
//
//  Created by Dana Majid on 14/10/15.
//  Copyright © 2015 Dana Majid. All rights reserved.
//

import UIKit
import Cartography

class SegmentedControlView: UIView {
    internal var segmentedControl: UISegmentedControl?
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        self.backgroundColor = UIColor.whiteColor()
        
        let items = ["About", "Profile"]
        segmentedControl = UISegmentedControl(items: items)
        segmentedControl!.backgroundColor = UIColor.whiteColor()
        segmentedControl!.tintColor = UIColor.whiteColor()
        
        let segmentedControlAttributesNormal = [
            NSForegroundColorAttributeName: UIColor(red: 150/255, green: 150/255, blue: 150/255, alpha: 1),
            NSFontAttributeName: UIFont.boldSystemFontOfSize(15)
        ]
        
        let segmentedControlAttributesHighlighted = [
            NSForegroundColorAttributeName: UIColor.grayColor(),
            NSFontAttributeName: UIFont.boldSystemFontOfSize(15)
        ]
        let segmentedControlAttributesSelected = [
            NSForegroundColorAttributeName: UIColor(red: 40/255, green: 145/255, blue: 247/255, alpha: 1),
            NSFontAttributeName: UIFont.boldSystemFontOfSize(15)
        ]
        
        segmentedControl!.setTitleTextAttributes(segmentedControlAttributesNormal, forState: UIControlState.Normal)
        segmentedControl!.setTitleTextAttributes(segmentedControlAttributesSelected, forState: UIControlState.Selected)
        segmentedControl!.setTitleTextAttributes(segmentedControlAttributesHighlighted, forState: UIControlState.Highlighted)

        segmentedControl!.removeBorders()

        segmentedControl!.selectedSegmentIndex = 0
        self.addSubview(segmentedControl!)
        
        constrain(segmentedControl!) {segmentedControl in
            //segmentedControl.centerX == segmentedControl.superview!.centerX
            segmentedControl.top == segmentedControl.superview!.top + 6
//            segmentedControl.left == segmentedControl.superview!.left + 6
//            segmentedControl.right == segmentedControl.superview!.right - 6

            segmentedControl.centerX == segmentedControl.superview!.centerX
            segmentedControl.bottom == segmentedControl.superview!.bottom - 6
        }
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension UISegmentedControl {
    func removeBorders() {
        setBackgroundImage(imageWithColor(backgroundColor!), forState: .Normal, barMetrics: .Default)
        setBackgroundImage(imageWithColor(tintColor!), forState: .Selected, barMetrics: .Default)
        setBackgroundImage(imageWithColor(backgroundColor!), forState: .Highlighted, barMetrics: .Default)
        setDividerImage(imageWithColor(UIColor.clearColor()), forLeftSegmentState: .Normal, rightSegmentState: .Normal, barMetrics: .Default)
    }
    
    // create a 1x1 image with this color
    private func imageWithColor(color: UIColor) -> UIImage {
        let rect = CGRectMake(0.0, 0.0, 1.0, 1.0)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        CGContextSetFillColorWithColor(context, color.CGColor);
        CGContextFillRect(context, rect);
        let image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return image
    }
}