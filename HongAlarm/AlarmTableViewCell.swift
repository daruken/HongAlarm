//
//  AlarmTableViewCell.swift
//  HongAlarm
//
//  Created by K on 2015. 9. 28..
//  Copyright © 2015년 JeonHongYeol. All rights reserved.
//

import UIKit

class AlarmTableViewCell: UITableViewCell {
    
    @IBOutlet weak var ampmLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var alarmSwitch: UISwitch!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        contentView.addSubview(ampmLabel)
        contentView.addSubview(timeLabel)
        contentView.addSubview(alarmSwitch)
  
        let viewsDict = [
            "ampm" : ampmLabel,
            "time" : timeLabel,
            "alarm": alarmSwitch,
        ] as [String : Any]
        
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[ampm]-[time]-[alarm]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewsDict))
    }
    
}
