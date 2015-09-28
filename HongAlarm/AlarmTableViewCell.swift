//
//  AlarmTableViewCell.swift
//  HongAlarm
//
//  Created by K on 2015. 9. 28..
//  Copyright © 2015년 JeonHongYeol. All rights reserved.
//

import Foundation
import UIKit

class AlarmTableViewCell: UITableViewCell {
    
    @IBOutlet weak var ampmLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        contentView.addSubview(ampmLabel)
        contentView.addSubview(timeLabel)

        let viewsDict = [
            "ampm" : ampmLabel,
            "time" : timeLabel,
        ]
        
        contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-[ampm]-[time]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewsDict))
    }
    
}