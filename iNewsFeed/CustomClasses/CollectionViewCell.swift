//
//  CollectionViewCell.swift
//  iNewsFeed
//
//  Created by Balagurubaran on 25/11/2014.
//  Copyright (c) 2014 Iappscrazy. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var feedDescreption: UILabel!
    @IBOutlet var feedImage: UIImageView!
    
    func setRoundCorner() {
        self.contentView.layer.cornerRadius = 2.0;
        self.contentView.layer.borderWidth = 1.0;
        self.contentView.layer.borderColor = UIColor.brown.cgColor;
        self.contentView.layer.masksToBounds = true;
        
    }
}
