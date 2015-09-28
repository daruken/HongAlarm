//
//  ViewController.swift
//  HongAlarm
//
//  Created by JeonHongYeol on 2015. 7. 2..
//  Copyright (c) 2015년 JeonHongYeol. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView!) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        return alarmList.myAlarmList.count
    }
    
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        let cell = tableView.dequeueReusableCellWithIdentifier("alarmCell", forIndexPath: indexPath) as! AlarmTableViewCell
        
        if( (alarmList.myAlarmList[indexPath.row].checkTime / 10000) == 1 ){
            cell.ampmLabel.text = "오전"
        }else{
            cell.ampmLabel.text = "오후"
        }
        
        
        let hour = alarmList.myAlarmList[indexPath.row].checkTime%10000/100
        let minute  = alarmList.myAlarmList[indexPath.row].checkTime%10000%100
        
        cell.timeLabel.text = String().stringByAppendingFormat("%.2d", hour) + " : " + String().stringByAppendingFormat("%.2d",minute)

        return cell
    }
}

