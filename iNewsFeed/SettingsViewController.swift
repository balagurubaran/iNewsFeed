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
   
    var feedSettingsDataObject = FeedSettingsDataParser()
    @IBOutlet weak var SettingsTableView: UITableView!
    
    @IBAction func SettingsSegmentSelected(sender: UISegmentedControl) {
        var theTitle : NSString = sender.titleForSegmentAtIndex(sender.selectedSegmentIndex)!
        filteredSettingsData = feedSettingsDataObject.getAllDataForSettings(theTitle)
        SettingsTableView.reloadData()
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredSettingsData.count;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:UITableViewCell=UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "mycell")
        var tempFeedSttingData : FeedSettingData = filteredSettingsData[indexPath.row] as FeedSettingData
        cell.textLabel.text = tempFeedSttingData.feedSettingName
        
        return cell
    }
    
    func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
        println("You selected cell #\(indexPath.row)!")
    }

}