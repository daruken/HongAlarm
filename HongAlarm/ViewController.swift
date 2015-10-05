//
//  ViewController.swift
//  HongAlarm
//
//  Created by JeonHongYeol on 2015. 7. 2..
//  Copyright (c) 2015년 JeonHongYeol. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var audioPlayer = AVAudioPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let qualityOfServiceClass = QOS_CLASS_BACKGROUND
        let backgroundQueue = dispatch_get_global_queue(qualityOfServiceClass, 0)
        
        dispatch_async(backgroundQueue, {
            while(true){
                self.checkAlarmList()
            }
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func checkAlarmList(){
        if( alarmList.myAlarmList.count > 0 ){
            let currentTime = ViewEditController().getCurrentTime()
            
            let currentAmPm = (currentTime.ampm+1) * 10000
            let currentHour = (currentTime.hour+1) * 100
            let currentMinute = currentTime.minute
            let currentCheckTime = currentAmPm + currentHour + currentMinute
            
            for var i=0 ; i < alarmList.myAlarmList.count ; i++ {
                
                let today = ViewEditController().getTodayOfWeek()
 
                if(checkDayOfWeekAlarmList(i, today: today) == false){
                    continue
                }
            
                if(checkTimeAlarmList(i, currentCheckTime: currentCheckTime) == true){
                   
                    if(alarmList.myAlarmList[i].checkSwitch==true){
                        playAlarmSound()
                    }else{
                        continue
                    }
                }
            }

            let sleepSecond:UInt32 = 60 - UInt32(currentTime.second)
            sleep(sleepSecond)
        }
    }
    
    func checkDayOfWeekAlarmList(index:Int, today:Int)->Bool{
        switch today {
        case 1:
            if(alarmList.myAlarmList[index].checkDay.contains("Sun") == true){
                return true
            }else{
                return false
            }
        case 2:
            if(alarmList.myAlarmList[index].checkDay.contains("Mon") == true){
                return true
            }else{
                return false
            }
        case 3:
            if(alarmList.myAlarmList[index].checkDay.contains("Tue") == true){
                return true
            }else{
                return false
            }
        case 4:
            if(alarmList.myAlarmList[index].checkDay.contains("Wed") == true){
                return true
            }else{
                return false
            }
        case 5:
            if(alarmList.myAlarmList[index].checkDay.contains("Thu") == true){
                return true
            }else{
                return false
            }
        case 6:
            if(alarmList.myAlarmList[index].checkDay.contains("Fri") == true){
                return true
            }else{
                return false
            }
        case 7:
            if(alarmList.myAlarmList[index].checkDay.contains("Sat") == true){
                return true
            }else{
                return false
            }
        default:
            return false
        }
    }
    
    func checkTimeAlarmList(index:Int, currentCheckTime:Int)->Bool{
        if(alarmList.myAlarmList[index].checkTime == currentCheckTime){
            return true
        }
        return false
    }
    
    func playAlarmSound(){
        do {
            let path = NSBundle.mainBundle().pathForResource("성시경_좋을텐데.mp3", ofType:nil)!
            let url = NSURL(fileURLWithPath: path)
            let sound = try AVAudioPlayer(contentsOfURL: url)
            audioPlayer = sound
            sound.play()
        } catch {
            // couldn't load file :(
        }
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

