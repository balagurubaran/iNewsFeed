//
//  HomeViewController.swift
//  iNewsFeed
//
//  Created by Balagurubaran Kalingarayan on 12/21/16.
//  Copyright © 2016 Iappscrazy. All rights reserved.
//

import Foundation
import UIKit


var filteredSettingsData:NSArray = NSArray()

class HomeViewController: UIViewController,UIWebViewDelegate,UITableViewDataSource, UITableViewDelegate
    
{
    
    var feedSettingsDataObject = FeedSettingsDataParser()
    
    let feedDataParserObejct = FeedSettingsDataParser()
    
    let animationDuration:Float = 0.8
    
    @IBOutlet weak var SettingsTableView: UITableView!
    
    @IBOutlet weak var SideMenuWidth: NSLayoutConstraint!
    
    @IBOutlet var webView: UIWebView!
    @IBOutlet weak var buttonLeftMargin: NSLayoutConstraint!
   
    @IBOutlet weak var WebViewTopMargin: NSLayoutConstraint!
    override func viewDidLoad() {
        SideMenuWidth.constant = 0;
        let fm = FileManger()
        let fileContent : NSString =  fm.ReadFile("Settings") as NSString
        feedDataParserObejct.parseSettingsJsonData(fileContent)
        
        webView.scalesPageToFit = true
        webView.contentMode = UIViewContentMode.scaleToFill
        
        SettingsTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        filteredSettingsData = feedSettingsDataObject.getAllDataForSettings("Sports")
        SettingsTableView.reloadData()

    }
    
    @IBAction func MoreButton(_ sender: Any) {
        
        if(SideMenuWidth.constant == 0){
            UIView.animate(withDuration: TimeInterval(animationDuration)) { () -> Void in
                self.SideMenuWidth.constant = 240
                self.buttonLeftMargin.constant = 230
                self.WebViewTopMargin.constant = 45
                self.view.layoutIfNeeded()
            }
            
        }else{
            UIView.animate(withDuration: TimeInterval(animationDuration/2)) { () -> Void in
                self.SideMenuWidth.constant = 0
                self.buttonLeftMargin.constant = -5
                self.WebViewTopMargin.constant = 0
                self.view.layoutIfNeeded()
            }
        }
    }
    
    func loadPage(){
       // paperName.text = selectedPaper.feedSettingName as String
        //activityIndicator.startAnimating()
        let url:URL = URL(string: selectedPaper.feedSettingURL as String)!
        let URLRequest:Foundation.URLRequest = Foundation.URLRequest(url: url)
        webView.loadRequest(URLRequest)
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
        UIView.animate(withDuration: TimeInterval(animationDuration/2)) { () -> Void in
            self.SideMenuWidth.constant = 0
            self.buttonLeftMargin.constant = -5
            self.WebViewTopMargin.constant = 0
            self.view.layoutIfNeeded()
        }
    
        loadPage()
     }
    
    override var prefersStatusBarHidden : Bool {
        return true
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        //activityIndicator.stopAnimating()
    }
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        //activityIndicator.stopAnimating()
    }
    
}
