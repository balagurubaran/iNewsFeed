//
//  SettingsTableViewCell.swift
//  iNewsFeed
//
//  Created by iappscrazy on 01/02/2015.
//  Copyright (c) 2015 Iappscrazy. All rights reserved.
//
import UIKit

class SettingsTableViewCell: UITableViewCell {
    
    @IBOutlet var paperAddedStatus: UISwitch!
    @IBOutlet var nameLbl: UILabel!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String!) {
        super.init(style: UITableViewCellStyle.Value1, reuseIdentifier: reuseIdentifier)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateSettingsTableViewCell(name:NSString,status:Bool){
        nameLbl.text = name;
        paperAddedStatus.setOn(status, animated: true)
    }
    @IBAction func addPaperToList(sender: AnyObject) {
    }
}
