//
//  ViewController.swift
//  iNewsFeed
//
//  Created by Balagurubaran on 24/11/2014.
//  Copyright (c) 2014 Iappscrazy. All rights reserved.
//

import UIKit
var selectedPaper:FeedSettingData = FeedSettingData()
class ViewController: UIViewController,UIWebViewDelegate{

    @IBOutlet weak var topBarView: UIView!
    
    let fm = FileManger()
    let feedDataParserObejct = FeedSettingsDataParser()
    
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    @IBOutlet var webView: UIWebView!
    @IBOutlet var paperName: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let fm = FileManger()
        var fileContent : NSString =  fm.ReadFile("Settings")
        
        webView.scalesPageToFit = true
        webView.contentMode = UIViewContentMode.ScaleToFill
        
        feedDataParserObejct.parseSeetingsJsonData(fileContent)
        NSNotificationCenter.defaultCenter().addObserver(self, selector:"loadPage", name: "loadPage", object: nil)
        selectedPaper = FeedSettingsDataAllObject.objectAtIndex(0) as FeedSettingData
        loadPage()
    }
    
    func loadPage(){
        paperName.text = selectedPaper.feedSettingName
        activityIndicator.startAnimating()
        var url:NSURL = NSURL(string: selectedPaper.feedSettingURL)!
        let URLRequest:NSURLRequest = NSURLRequest(URL: url)
        webView.loadRequest(URLRequest)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        activityIndicator.stopAnimating()
    }
    func webView(webView: UIWebView, didFailLoadWithError error: NSError) {
        activityIndicator.stopAnimating()
    }
}

