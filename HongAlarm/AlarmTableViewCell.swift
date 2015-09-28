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
    
    @IBOutlet weak var labUserName: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        contentView.addSubview(labUserName)

        let viewsDict = [
            "username" : labUserName,
        ]
        
        contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-[username]-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewsDict))
    }
    
}