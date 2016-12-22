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
        let fileContent : NSString =  fm.ReadFile("Settings") as NSString
        
        webView.scalesPageToFit = true
        webView.contentMode = UIViewContentMode.scaleToFill
        
        feedDataParserObejct.parseSettingsJsonData(fileContent)
        NotificationCenter.default.addObserver(self, selector:#selector(ViewController.loadPage), name: NSNotification.Name(rawValue: "loadPage"), object: nil)
        selectedPaper = FeedSettingsDataAllObject.object(at: 0) as! FeedSettingData
        loadPage()
    }
    
    func loadPage(){
        paperName.text = selectedPaper.feedSettingName as String
        activityIndicator.startAnimating()
        let url:URL = URL(string: selectedPaper.feedSettingURL as String)!
        let URLRequest:Foundation.URLRequest = Foundation.URLRequest(url: url)
        webView.loadRequest(URLRequest)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override var prefersStatusBarHidden : Bool {
        return true
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        activityIndicator.stopAnimating()
    }
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        activityIndicator.stopAnimating()
    }
}

