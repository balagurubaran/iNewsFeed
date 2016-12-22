//
//  FeedData.swift
//  iNewsFeed
//
//  Created by iappscrazy on 24/11/2014.
//  Copyright (c) 2014 Iappscrazy. All rights reserved.
//

import Foundation

var FeedSettingsDataAllObject = NSMutableArray()
var FeedDSettingsFiltered = NSMutableArray()


class FeedSettingData{
    var feedSettingCategory : NSString = ""
    var feedSettingURL: NSString = ""
    var feedSettingName: NSString = ""
}

class FeedSettingsDataParser{
    
    func parseSettingsJsonData(_ jsonContent:NSString){
        let fileData : Data = jsonContent.data(using: String.Encoding.utf8.rawValue, allowLossyConversion: false)!
        
        do {
            if let boardsDictionary: NSDictionary = try JSONSerialization.jsonObject(with: fileData, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary{
                for key in boardsDictionary.allKeys{
                    let eachDataArray : NSArray = boardsDictionary.object(forKey: key) as! NSArray
                    for eachData in eachDataArray{
                        let tempSettingFeedData = FeedSettingData();
                        tempSettingFeedData.feedSettingCategory = key as! NSString
                        let URLDetail:[String] = (eachData as! NSString).components(separatedBy: ",")
                        tempSettingFeedData.feedSettingURL = URLDetail[1] as NSString
                        tempSettingFeedData.feedSettingName = URLDetail[2] as NSString
                        FeedSettingsDataAllObject.add(tempSettingFeedData)
                    }
                }
            }
        }catch{
            
        }
        
    }
    
    func getAllDataForSettings(_ settingsString:NSString)->NSMutableArray{
        FeedDSettingsFiltered.removeAllObjects()
        for i in 0 ..< FeedSettingsDataAllObject.count {
            let temp:FeedSettingData = FeedSettingsDataAllObject[i] as! FeedSettingData
            if temp.feedSettingCategory.isEqual(to: settingsString as String) {
                FeedDSettingsFiltered.add(temp)
            }
        }
        return FeedDSettingsFiltered;
    }
}
