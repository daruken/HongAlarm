//
//  ViewController.swift
//  HongAlarm
//
//  Created by JeonHongYeol on 2015. 7. 2..
//  Copyright (c) 2015년 JeonHongYeol. All rights reserved.
//

import UIKit
import AudioToolbox
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var audioPlayer = AVAudioPlayer()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        /**
        * Vibration
        AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
        */
        
        var currentAmPm = 0
        var currentHour = 0
        var currentMinute = 0
        
        let date = NSDate()
        let calendar = NSCalendar.currentCalendar()
        let unit: NSCalendarUnit = [.Year, .Month, .Day, .Hour, .Minute, .Second]
        let components = calendar.components(unit, fromDate: date)
        
        var ampm = 0
        var hour = components.hour
        let minute = components.minute
        
        if ( hour == 12 )
        {
            ampm = 1
            hour = 11
        }
        else if ( 12 < hour && hour < 24  ){
            ampm = 1
            hour = hour - 13
        }
        else if ( hour == 0 ){
            hour = 11
        }
        else{
            ampm = 0
        }
        
        currentAmPm = (ampm+1) * 10000
        currentHour = (hour+1) * 100
        currentMinute = minute
        let currentTime = currentAmPm + currentHour + currentMinute
        
        let path = NSBundle.mainBundle().pathForResource("hope.mp3", ofType:nil)!
        let url = NSURL(fileURLWithPath: path)
        
        if( alarmList.myAlarmList.count > 0 ){
            for var i=0 ; i < alarmList.myAlarmList.count ; i++ {
                if(alarmList.myAlarmList[i].checkTime == currentTime){
                    do {
                        let sound = try AVAudioPlayer(contentsOfURL: url)
                        audioPlayer = sound
                        sound.play()
                        print("OK")
                    } catch {
                        // couldn't load file :(
                    }
                }
            }
        }
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
        
        if cell.alarmSwitch.on {
            alarmList.myAlarmList[indexPath.row].checkSwitch = true
            cell.backgroundColor = UIColor.whiteColor()
        }else{
            alarmList.myAlarmList[indexPath.row].checkSwitch = false
            cell.backgroundColor = UIColor.groupTableViewBackgroundColor()
        }
        
       return cell
    }

    @IBAction func pressedSwitch(sender: AnyObject) {
        self.tableView.reloadData()
    }
    
}

