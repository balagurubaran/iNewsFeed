//
//  SettignsViewController.swift
//  iNewsFeed
//
//  Created by iappscrazy on 24/11/2014.
//  Copyright (c) 2014 Iappscrazy. All rights reserved.
//

import UIKit

var filteredSettingsData:NSArray = NSArray()

class SettingsViewController:UIViewController,UITableViewDataSource,UITableViewDelegate{
    @IBOutlet var segementControll: UISegmentedControl!
   
    var feedSettingsDataObject = FeedSettingsDataParser()
    @IBOutlet weak var SettingsTableView: UITableView!
    
    override func viewDidLoad() {
        segementControll.setEnabled(true, forSegmentAtIndex: 0);
        var theTitle : NSString = segementControll.titleForSegmentAtIndex(segementControll.selectedSegmentIndex)!
        SettingsTableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        filteredSettingsData = feedSettingsDataObject.getAllDataForSettings(theTitle)
        SettingsTableView.reloadData()
    }
    
    @IBAction func SettingsSegmentSelected(sender: UISegmentedControl) {
        var theTitle : NSString = sender.titleForSegmentAtIndex(sender.selectedSegmentIndex)!
        filteredSettingsData = feedSettingsDataObject.getAllDataForSettings(theTitle)
        SettingsTableView.reloadData()
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredSettingsData.count;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell: UITableViewCell = (tableView.dequeueReusableCellWithIdentifier("cell")) as UITableViewCell
        
        var feedData:FeedSettingData = filteredSettingsData.objectAtIndex(indexPath.row) as FeedSettingData
        cell.textLabel?.text = feedData.feedSettingName
        return cell
        
    }
    
    func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
        selectedPaper = filteredSettingsData.objectAtIndex(indexPath.row) as FeedSettingData
        NSNotificationCenter.defaultCenter().postNotificationName("loadPage", object: nil)
        self.dismissViewControllerAnimated(true, completion: { () -> Void in
            
        })
    }

}