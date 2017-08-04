//
//  ViewController.swift
//  HongAlarm
//
//  Created by JeonHongYeol on 2015. 7. 2..
//  Copyright (c) 2015년 JeonHongYeol. All rights reserved.
//

import UIKit
import AVFoundation
import AudioToolbox

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var audioPlayer = AVAudioPlayer()
  
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let qualityOfServiceClass = DispatchQoS.QoSClass.background
        let backgroundQueue = DispatchQueue.global(qos: qualityOfServiceClass)
        
        backgroundQueue.async(execute: {
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
            
            for i in 0  ..< alarmList.myAlarmList.count {
                
                let today = ViewEditController().getTodayOfWeek()
 
                if(checkDayOfWeekAlarmList(i, today: today) == false){
                    continue
                }
            
                if(checkTimeAlarmList(i, currentCheckTime: currentCheckTime) == true){
                   
                    if(alarmList.myAlarmList[i].checkSwitch==true){
                        if (globalVariableSound.checkSound == 1){
                            playAlarmSound()
                        }
                        else{
                            var sec = 0
                            while(sec < 100000){
                                AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
                                sec += 1
                            }
                            
                        }
                    }else{
                        continue
                    }
                }
            }

            let sleepSecond:UInt32 = 60 - UInt32(currentTime.second)
            sleep(sleepSecond)
        }
    }
    
    func checkDayOfWeekAlarmList(_ index:Int, today:Int)->Bool{
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
    
    func checkTimeAlarmList(_ index:Int, currentCheckTime:Int)->Bool{
        if(alarmList.myAlarmList[index].checkTime == currentCheckTime){
            return true
        }
        return false
    }
    
    func playAlarmSound(){
        do {
            let path = Bundle.main.path(forResource: "music.mp3", ofType:nil)!
            let url = URL(fileURLWithPath: path)
            let sound = try AVAudioPlayer(contentsOf: url)
            audioPlayer = sound
            sound.play()
        } catch {
            // couldn't load file :(
        }
    }


    func numberOfSectionsInTableView(_ tableView: UITableView!) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        return alarmList.myAlarmList.count
    }
    
    func tableView(_ tableView: UITableView!, cellForRowAtIndexPath indexPath: IndexPath!) -> UITableViewCell! {
        let cell = tableView.dequeueReusableCell(withIdentifier: "alarmCell", for: indexPath) as! AlarmTableViewCell
        
        if( (alarmList.myAlarmList[indexPath.row].checkTime / 10000) == 1 ){
            cell.ampmLabel.text = "오전"
        }else{
            cell.ampmLabel.text = "오후"
        }
        
        let hour = alarmList.myAlarmList[indexPath.row].checkTime%10000/100
        let minute  = alarmList.myAlarmList[indexPath.row].checkTime%10000%100
        
        cell.timeLabel.text = String().appendingFormat("%.2d", hour) + " : " + String().appendingFormat("%.2d",minute)
       
        if cell.alarmSwitch.isOn {
            alarmList.myAlarmList[indexPath.row].checkSwitch = true
            cell.backgroundColor = UIColor.white
        }else{
            alarmList.myAlarmList[indexPath.row].checkSwitch = false
            cell.backgroundColor = UIColor.groupTableViewBackground
        }
        
        cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator

        return cell
    }
    
    func tableView(_ tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: IndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.delete) {
            alarmList.myAlarmList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
        }
    }
    
    @IBAction func pressedSwitch(_ sender: AnyObject) {
        self.tableView.reloadData()
    }
   
}

