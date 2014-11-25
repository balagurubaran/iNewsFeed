//
//  FileManager.swift
//  iNewsFeed
//
//  Created by Balagurubaran on 24/11/2014.
//  Copyright (c) 2014 Iappscrazy. All rights reserved.
//

import Foundation


class FileManger{
    
    func ReadFile(fileName:String)->String{
        
        let bundle = NSBundle.mainBundle()
        let myFilePath = bundle.pathForResource(fileName, ofType: "json")
        var error:NSError?
        var content:String = String(contentsOfFile: myFilePath!, encoding: NSUTF8StringEncoding, error: &error)!
        return content;
    }
    
    func writeFile(fileName:String,fileContent:NSString)->Bool{
        
        return true;
    }
    
    
}
