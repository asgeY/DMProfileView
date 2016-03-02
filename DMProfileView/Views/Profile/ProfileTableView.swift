//
//  ProfileTableView.swift
//  DMProfileView
//
//  Created by Dana Majid on 14/10/15.
//  Copyright © 2015 Dana Majid. All rights reserved.
//

import Foundation
import UIKit
import Cartography

class ProfileTableView: UIView, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {
    internal var headerView: ProfileHeaderView! = ProfileHeaderView()
    internal var headerViewStatic: ProfileHeaderView! = ProfileHeaderView()
    internal var tableView: UITableView!
    
    private var segmentedView:SegmentedControlView?
    private var segmentedViewCopy:SegmentedControlView?
    
    private let kTableHeaderHeight: CGFloat = 240.0
    private let kTableSectionHeight: CGFloat = 46.0
    private let kMinTableHeaderHeight: CGFloat = 64.0
    enum TableData {
        case About
        case Profile
    }
    private var showData: TableData?
    
    var headerViewTop: NSLayoutConstraint?
    var headerViewHeight: NSLayoutConstraint?
    var headerViewStaticHeight: NSLayoutConstraint?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        tableView = UITableView(frame: CGRectZero, style: .Plain)
        tableView.delegate = self
        tableView.dataSource = self
        showData = .About
        
        let nibName = UINib(nibName: "ActivityTableViewCell", bundle:nil)
        tableView.registerNib(nibName, forCellReuseIdentifier: "activityCell")
        tableView.estimatedRowHeight = 44.0
        tableView.rowHeight = UITableViewAutomaticDimension
        
        tableView.scrollIndicatorInsets = UIEdgeInsets(top: kTableHeaderHeight, left: 0, bottom: 0, right: 0)
        tableView.contentInset = UIEdgeInsetsMake(kTableHeaderHeight, 0, kTableSectionHeight + kMinTableHeaderHeight, 0)
        tableView.contentOffset = CGPoint(x: 0, y: -kTableHeaderHeight)
        
        
        segmentedView = SegmentedControlView()
        segmentedViewCopy = SegmentedControlView()
        
        segmentedView!.segmentedControl!.addTarget(self, action: "changePage:", forControlEvents: .ValueChanged)
        segmentedViewCopy!.segmentedControl!.addTarget(self, action: "changePage:", forControlEvents: .ValueChanged)
        
        headerView.addSubview(segmentedView!)
        headerViewStatic!.userBioLabel?.hidden = true
        headerViewStatic!.userAvatar?.hidden = true
        
        headerViewStatic.addSubview(segmentedViewCopy!)
        //headerViewStatic.hidden = true
        
        tableView.addSubview(headerView)
        self.addSubview(tableView)
        self.addSubview(headerViewStatic)
        
        constrain(tableView, segmentedView!, segmentedViewCopy!, headerView, headerViewStatic) { tableView, segmentedView, segmentedViewCopy, headerView, headerViewStatic in
            segmentedView.height == kTableSectionHeight
            segmentedView.width == headerView.superview!.width
            segmentedView.bottom == headerView.bottom
            segmentedView.left == headerView.left
            
            headerViewHeight = headerView.height == kTableHeaderHeight
            headerView.width == tableView.superview!.width
//            headerView.left == tableView.superview!.left
            headerViewTop = headerView.top == tableView.superview!.top// + kTableHeaderHeight
            
            headerViewStaticHeight = headerViewStatic.height == kMinTableHeaderHeight + kTableSectionHeight
            headerViewStatic.width == headerViewStatic.superview!.width
            headerViewStatic.left == headerViewStatic.superview!.left
            headerViewStatic.top == headerViewStatic.superview!.top
            
            segmentedViewCopy.height == kTableSectionHeight
            segmentedViewCopy.width == headerViewStatic.superview!.width
            segmentedViewCopy.bottom == headerViewStatic.bottom
            segmentedViewCopy.left == headerViewStatic.left
        }
        
        constrain(tableView) { tableView in
            tableView.left == tableView.superview!.left
            tableView.right == tableView.superview!.right
            tableView.bottom == tableView.superview!.bottom
            tableView.top == tableView.superview!.top
        }
    }
    
    func changePage(sender: UISegmentedControl) {
        print("change", sender.selectedSegmentIndex)
        switch sender.selectedSegmentIndex {
            case 0:
                showData = .About
                tableView.estimatedRowHeight = 44.0
                tableView.rowHeight = UITableViewAutomaticDimension
                tableView.separatorStyle = .SingleLine
            case 1:
                showData = .Profile
                tableView.estimatedRowHeight = 44.0
                tableView.rowHeight = UITableViewAutomaticDimension
                tableView.separatorStyle = .SingleLine
            default:
                showData = .About
        }
        
        if sender == segmentedView!.segmentedControl! {
            segmentedViewCopy!.segmentedControl!.selectedSegmentIndex = sender.selectedSegmentIndex
        } else if sender == segmentedViewCopy!.segmentedControl! {
            segmentedView!.segmentedControl!.selectedSegmentIndex = sender.selectedSegmentIndex
        }
        
        //tableView.scrollToRowAtIndexPath(NSIndexPath(forRow: 0, inSection:0), atScrollPosition: UITableViewScrollPosition(rawValue: 0)!, animated: false)

        tableView.reloadData()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:ActivityTableViewCell = ActivityTableViewCell(style: .Default, reuseIdentifier: "activityCell")
        cell.label.text = "This is a post with #hashtags and a @userhandle. Here's another hashtag and another @danamajid. This is a post with #nohashtags and a @userzhandle..."
        
        return cell
    }
    
    func updateHeaderView() {
        if tableView.contentOffset.y >= -kMinTableHeaderHeight - kTableSectionHeight {
            headerView.hidden = true
            headerViewStatic.hidden = false
            tableView.contentInset.bottom = max(0,-tableView.contentOffset.y)
            //print("hoi")
            
            if headerViewHeight != nil {
                headerView.updateSubviewsForPercent(headerViewStaticHeight!.constant/kTableHeaderHeight, minimum: headerViewStaticHeight!.constant/kTableHeaderHeight)
            }
        } else {
            headerView.hidden = false
            headerViewStatic.hidden = true
            
            if headerViewHeight != nil {
                headerView.updateSubviewsForPercent(headerViewHeight!.constant/kTableHeaderHeight, minimum: headerViewStaticHeight!.constant/kTableHeaderHeight)
            }
        }
        
        if tableView.contentOffset.y < -kTableHeaderHeight || tableView.contentOffset.y < -kMinTableHeaderHeight && headerViewHeight != nil {
            let topOffset = -tableView.contentOffset.y
            headerViewHeight!.constant = topOffset
            headerViewTop!.constant = 0
            //print(topOffset)
        }
        
        

        
        
        
        
    }
    
    func updateScrollIndicator(scrollView: UIScrollView) {
        if tableView.contentOffset.y < -kTableHeaderHeight {
            scrollView.scrollIndicatorInsets = UIEdgeInsets(top: -scrollView.contentOffset.y, left: 0, bottom: 0, right: 0)
        }
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        updateHeaderView()
        updateScrollIndicator(scrollView)
    }
}