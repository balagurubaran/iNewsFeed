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
    var feedSettingName: NSString = ""
}

class FeedSettingsDataParser{
    
    func parseSeetingsJsonData(jsonContent:NSString){
        var fileData : NSData = jsonContent.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)!
        var error:NSError?
        var boardsDictionary: NSDictionary  = NSJSONSerialization.JSONObjectWithData(fileData, options: NSJSONReadingOptions.MutableContainers, error: &error)  as NSDictionary
        for key in boardsDictionary.allKeys{
            var eachDataArray : NSArray = boardsDictionary.objectForKey(key) as NSArray
            for eachData in eachDataArray{
                var tempSettingFeedData = FeedSettingData();
                tempSettingFeedData.feedSettingCategory = key as NSString
                tempSettingFeedData.feedSettingName = eachData as NSString
                FeedSettingsDataAllObject.addObject(tempSettingFeedData)
            }
        }
    }
    
    func getAllDataForSettings(settingsString:NSString)->NSMutableArray{
        FeedDSettingsFiltered.removeAllObjects()
        for var i = 0;i < FeedSettingsDataAllObject.count;i++ {
            var temp:FeedSettingData = FeedSettingsDataAllObject[i] as FeedSettingData
            if temp.feedSettingCategory.isEqualToString(settingsString) {
                FeedDSettingsFiltered.addObject(temp)
            }
        }
        return FeedDSettingsFiltered;
    }
}