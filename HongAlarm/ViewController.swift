//
//  ViewController.swift
//  HongAlarm
//
//  Created by JeonHongYeol on 2015. 7. 2..
//  Copyright (c) 2015년 JeonHongYeol. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var bossLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        if( !alarmList.myAlarmList.isEmpty ){
        bossLabel.text = String(alarmList.myAlarmList[0].checkTime) + " : " + String(alarmList.myAlarmList[0].checkDay)
        }else{
            bossLabel.text = "empty"
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

