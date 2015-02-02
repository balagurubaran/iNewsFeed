//
//  ViewController.swift
//  iNewsFeed
//
//  Created by Balagurubaran on 24/11/2014.
//  Copyright (c) 2014 Iappscrazy. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout
{

    @IBOutlet weak var topBarView: UIView!
    @IBOutlet var MainRSSFeedTableView: UITableView!
    let fm = FileManger()
    let feedDataParserObejct = FeedSettingsDataParser()
    override func viewDidLoad() {
        super.viewDidLoad()
        let fm = FileManger()
        var fileContent : NSString =  fm.ReadFile("Settings")
        
        feedDataParserObejct.parseSeetingsJsonData(fileContent)
        
        topBarView.layer.borderColor = UIColor.blackColor().CGColor
        topBarView.layer.borderWidth = 1.5;
       /* topBarView.layer.shadowColor = UIColor.blackColor().CGColor
        topBarView.layer.shadowOpacity = 0.8
        topBarView.layer.shadowRadius = 1.0
        topBarView.layer.shadowOffset = CGSize(width: 1.0,height: 1.0)
        */
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    var items: [String] = ["We", "Heart", "Swift"]

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("iPhoneCollectionViewCell", forIndexPath: indexPath) as CollectionViewCell
        
        
        //cell.layer.masksToBounds = true;
        cell.layer.cornerRadius = 6;
        
        cell.feedDescreption.text = "    I created a collection view very simple to an Apple collection view sample project. I have a collection view in a view controller in storyboard, and set a label inside the collection view cell in the top right part of the collection view"
        var image : UIImage = UIImage(named: "appicon.jpg")!
        cell.feedImage.image = image
        return cell
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
}

