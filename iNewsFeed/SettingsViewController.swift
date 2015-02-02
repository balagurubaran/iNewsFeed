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
        SettingsTableView.registerClass(SettingsTableViewCell.self, forCellReuseIdentifier: "SettingsTableViewCell")
        
        SettingsTableView.reloadData()
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredSettingsData.count;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell =  tableView.dequeueReusableCellWithIdentifier("SettingsTableViewCell") as? SettingsTableViewCell
            //
       /* if(cell == nil){
            cell = SettingsTableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "SettingsTableViewCell")
        }*/
        let feedData: FeedSettingData = filteredSettingsData[indexPath.row] as FeedSettingData
        //cell?.contentView.viewWithTag(<#tag: Int#>)
        (cell?.contentView.viewWithTag(10) as UILabel).text = feedData.feedSettingName
        //cell?.textLabel?.text = feedData.feedSettingName
        ///cell?.updateSettingsTableViewCell(feedData.feedSettingName, status: true);
        return cell!
    }
    
    func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
        println("You selected cell #\(indexPath.row)!")
    }

}