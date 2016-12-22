//
//  SettignsViewController.swift
//  iNewsFeed
//
//  Created by iappscrazy on 24/11/2014.
//  Copyright (c) 2014 Iappscrazy. All rights reserved.
//

import UIKit



class SettingsViewController:UIViewController,UITableViewDataSource,UITableViewDelegate{
    @IBOutlet var segementControll: UISegmentedControl!
   
    var feedSettingsDataObject = FeedSettingsDataParser()
    var filteredSettingsData:NSArray = NSArray()
    
    @IBOutlet weak var SettingsTableView: UITableView!
    
    override func viewDidLoad() {
        segementControll.setEnabled(true, forSegmentAt: 0);
        let theTitle : NSString = segementControll.titleForSegment(at: segementControll.selectedSegmentIndex)! as NSString
        SettingsTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        filteredSettingsData = feedSettingsDataObject.getAllDataForSettings(theTitle)
        SettingsTableView.reloadData()
    }
    
    @IBAction func SettingsSegmentSelected(_ sender: UISegmentedControl) {
        let theTitle : NSString = sender.titleForSegment(at: sender.selectedSegmentIndex)! as NSString
        filteredSettingsData = feedSettingsDataObject.getAllDataForSettings(theTitle)
        SettingsTableView.reloadData()
    }
    
    @IBAction func backToMain(_ sender: Any) {
        NotificationCenter.default.post(name: Notification.Name(rawValue: "loadPage"), object: nil)
        self.dismiss(animated: true, completion: { () -> Void in
            
        })
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredSettingsData.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = (tableView.dequeueReusableCell(withIdentifier: "cell"))! as UITableViewCell
        
        let feedData:FeedSettingData = filteredSettingsData.object(at: indexPath.row) as! FeedSettingData
        cell.textLabel?.text = feedData.feedSettingName as String
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedPaper = filteredSettingsData.object(at: indexPath.row) as! FeedSettingData
        NotificationCenter.default.post(name: Notification.Name(rawValue: "loadPage"), object: nil)
        self.dismiss(animated: true, completion: { () -> Void in
            
        })
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}
