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
    
    var selectedRow = -1;
    
    @IBOutlet weak var MoreButton: UIButton!
    let animationDuration:Float = 0.8
    
    @IBOutlet weak var SettingsTableView: UITableView!
    
    @IBOutlet weak var SideMenuWidth: NSLayoutConstraint!
    
    @IBOutlet var webView: UIWebView!
    @IBOutlet weak var buttonLeftMargin: NSLayoutConstraint!
   
    @IBOutlet weak var WebViewTopMargin: NSLayoutConstraint!
    override func viewDidLoad() {
        SideMenuWidth.constant = 0;
        MoreButton.isHidden = true
        let fm = FileManger()
        let fileContent : NSString =  fm.ReadFile("Settings") as NSString
        feedDataParserObejct.parseSettingsJsonData(fileContent)
        
        webView.scalesPageToFit = true
        webView.contentMode = UIViewContentMode.scaleToFill
        
        SettingsTableView.register(CustomCell.self, forCellReuseIdentifier: "cell")
        
        filteredSettingsData = feedSettingsDataObject.getAllDataForSettings("Sports")
        SettingsTableView.reloadData()
        let myFilePath = Bundle.main.path(forResource: "bg", ofType: "png")

        let bgColor:UIColor = UIColor.init(patternImage: UIImage.init(contentsOfFile: myFilePath!)!)
        webView.backgroundColor = bgColor
        self.view.backgroundColor = bgColor
        webView.scrollView.backgroundColor = UIColor.clear
        
    }
    
    @IBAction func NewsGestureAction(_ sender: UISwipeGestureRecognizer) {
        if(sender.direction == .right){
            UIView.animate(withDuration: TimeInterval(animationDuration)) { () -> Void in
                self.SideMenuWidth.constant = 240
                self.buttonLeftMargin.constant = 230
                self.WebViewTopMargin.constant = 45
                self.MoreButton.isHidden = false
                self.MoreButton.transform = CGAffineTransform.init(rotationAngle: 180*3.14/180);

                self.view.layoutIfNeeded()
            }

        }
        
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
           closeButtonAnimation()
        }
    }
    
    func closeButtonAnimation(){
        UIView.animate(withDuration: TimeInterval(animationDuration/2), animations: {
            self.SideMenuWidth.constant = 0
            self.buttonLeftMargin.constant = -5
            self.WebViewTopMargin.constant = 0
            self.MoreButton.transform = CGAffineTransform.init(rotationAngle: 0);
            self.view.layoutIfNeeded()
        }, completion: { (Bool) in
            self.MoreButton.isHidden = true
        })
    }
    
    func loadPage(){
       // paperName.text = selectedPaper.feedSettingName as String
        //activityIndicator.startAnimating()
        let url:URL = URL(string: selectedPaper.feedSettingURL as String)!
        let URLRequest:Foundation.URLRequest = Foundation.URLRequest(url: url)
        webView.loadRequest(URLRequest)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allCategory.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CustomCell = (tableView.dequeueReusableCell(withIdentifier: "cell"))! as! CustomCell
        
        //let feedData:FeedSettingData = filteredSettingsData.object(at: indexPath.row) as! FeedSettingData
        //cell.textLabel?.text = feedData.feedSettingName as String
        
        cell.textLabel?.text = allCategory[indexPath.row] as? String
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      /*  selectedPaper = filteredSettingsData.object(at: indexPath.row) as! FeedSettingData
        closeButtonAnimation()
        loadPage()
         */
        
        if(selectedRow != indexPath.row){
            selectedRow =  indexPath.row;
        }else{
            selectedRow = -1
        }
        SettingsTableView.reloadRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
     }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        print(selectedRow)
        if(selectedRow == indexPath.row){
            return 100.0;
        }
        return 44.0;
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
