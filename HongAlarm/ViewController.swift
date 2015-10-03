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
    
    func checkAlarmList(){
        if( alarmList.myAlarmList.count > 0 ){
            let currentTime = ViewEditController().getCurrentTime()
            
            let currentAmPm = (currentTime.ampm+1) * 10000
            let currentHour = (currentTime.hour+1) * 100
            let currentMinute = currentTime.minute
            let currentCheckTime = currentAmPm + currentHour + currentMinute
            
            for var i=0 ; i < alarmList.myAlarmList.count ; i++ {
                
                if(alarmList.myAlarmList[i].checkTime == currentCheckTime){
                    do {
                        let path = NSBundle.mainBundle().pathForResource("hope.mp3", ofType:nil)!
                        let url = NSURL(fileURLWithPath: path)
                        let sound = try AVAudioPlayer(contentsOfURL: url)
                        self.audioPlayer = sound
                        sound.play()
                        break;
                    } catch {
                        // couldn't load file :(
                    }
                }
            }
            
            let sleepSecond:UInt32 = 60 - UInt32(currentTime.second)
            sleep(sleepSecond)
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

