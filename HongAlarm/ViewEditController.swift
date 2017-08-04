//
//  ViewEditController.swift
//  HongAlarm
//
//  Created by JeonHongYeol on 2015. 7. 7..
//  Copyright (c) 2015년 JeonHongYeol. All rights reserved.
//

import Foundation
import UIKit
// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}

// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func >= <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l >= r
  default:
    return !(lhs < rhs)
  }
}


var ArrayAmPm = ["오전", "오후"]
let ArrayHour = Array(1...12)
let ArrayMinute = Array(00...59)

private let hourViewRows = 1200
private let minuteViewRows = 6000
private let hourViewMiddle = ((hourViewRows / ArrayHour.count) / 2) * ArrayHour.count
private let minuteViewMiddle = ((minuteViewRows / ArrayMinute.count) / 2) * ArrayMinute.count

/**
 * checkTime : 11023
               1    (1:am, 2:pm)
                10  (10 hour)
                  23(23 minute)
               am 10:23
 * checkDay  : Sun,Mon,Tue,Wed,Thu,Fri,Sat                    
 * checkSound  : (1:Sound, 2:Vibration, 3:Sound+Vibration)
 * checkSwitch : ON / OFF
*/
struct alarmInventory {
    var checkTime: Int
    var checkDay = [String]()
    var checkSound: Int
    var checkSwitch: Bool

    
    init(checkTime: Int, checkDay: [String], checkSound: Int)
    {
        self.checkTime = checkTime
        self.checkDay = checkDay
        self.checkSound = checkSound
        self.checkSwitch = true
    }
}

struct alarmList{
    static var myAlarmList: [alarmInventory] = []
}

class ViewEditController : UIViewController, UIPickerViewDelegate, UIPickerViewDataSource{
    
    @IBOutlet weak var PickerAmPm: UIPickerView!
    @IBOutlet weak var PickerHour: UIPickerView!
    @IBOutlet weak var PickerMinute: UIPickerView!
    
    var didSelectedAmPm = 0
    var didSelectedHour = 0
    var didSelectedMinute = 0
    
    var subMenu = [
        "요일",
        "사운드"
    ]
    
    override func viewDidLoad() {
        
        PickerAmPm.delegate = self
        PickerAmPm.dataSource = self
        
        PickerHour.delegate = self
        PickerHour.dataSource = self
        
        PickerMinute.delegate = self
        PickerMinute.dataSource = self
        
        let currentTime = getCurrentTime()
        
        PickerAmPm.selectRow(currentTime.ampm, inComponent: 0, animated: false)
        
        if let hourRow = hourForValue(currentTime.hour) {
            PickerHour.selectRow(hourRow, inComponent: 0, animated: false)
        }

        if let minuteRow = minuteForValue(currentTime.minute) {
            PickerMinute.selectRow(minuteRow, inComponent: 0, animated: false)
        }

        didSelectedAmPm = (currentTime.ampm+1) * 10000
        didSelectedHour = (currentTime.hour+1) * 100
        didSelectedMinute = currentTime.minute
    }
    
    func getCurrentTime() -> (ampm:Int, hour:Int, minute:Int, second:Int){
        let date = Date()
        let calendar = Calendar.current
        let unit: NSCalendar.Unit = [.year, .month, .day, .hour, .minute, .second]
        let components = (calendar as NSCalendar).components(unit, from: date)
        
        var ampm = 0
        var hour = components.hour
        let minute = components.minute
        let second = components.second
        
        if ( hour == 12 ){
            ampm = 1
            hour = 11
        }else if ( 12 < hour && hour < 24  ){
            ampm = 1
            hour = hour! - 13
        }else if ( hour == 0 ){
            hour = 11
        }else{
            ampm = 0
            hour = hour! - 1
        }
        
        return (ampm, hour!, minute!, second!)
    }
    
    func getTodayOfWeek()->Int {
        let calendar = Calendar.current
        let date = Date()
        let dateComponent =  (calendar as NSCalendar).components(NSCalendar.Unit.weekday, from: date)
        let weekDay = dateComponent.weekday
        return weekDay!
    }
    
    func hourForRow(_ row: Int) -> Int {
        return ArrayHour[row % ArrayHour.count]
    }

    func minuteForRow(_ row: Int) -> Int {
        return ArrayMinute[row % ArrayMinute.count]
    }
  
    func hourForValue(_ value: Int) -> Int? {
        if (ArrayHour.index(of: value) >= 0) {
            return hourViewMiddle + value
        }
        return nil
    }
    
    func minuteForValue(_ value: Int) -> Int? {
          if (ArrayMinute.index(of: value) >= 0) {
            return minuteViewMiddle + value
        }
        return nil
    }
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView {
        case PickerAmPm :
            return ArrayAmPm[row]
        case PickerHour :
            return String().appendingFormat("%.2d",hourForRow(row))
        case PickerMinute :
            return String().appendingFormat("%.2d",minuteForRow(row))
        default :
            break
        }
        return ""
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        var newHourRow = 0
        var newMinuteRow = 0
        
        switch pickerView {
        case PickerAmPm :
            pickerView.selectRow(row, inComponent: 0, animated: false)
        case PickerHour :
            newHourRow = hourViewMiddle + (row % ArrayHour.count)
            pickerView.selectRow(newHourRow, inComponent: 0, animated: false)
        case PickerMinute :
            newMinuteRow = minuteViewMiddle + (row % ArrayMinute.count)
            pickerView.selectRow(newMinuteRow, inComponent: 0, animated: false)
        default :
            break
        }
        
        if pickerView == PickerAmPm{
            didSelectedAmPm = (row+1) * 10000
        }
        else if pickerView == PickerHour{
            didSelectedHour = (newHourRow%12+1) * 100
        }
        else{
            didSelectedMinute = newMinuteRow%60
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView{
        case PickerAmPm :
            return ArrayAmPm.count
        case PickerHour :
            return hourViewRows
        case PickerMinute :
            return minuteViewRows
        default :
            break
        }
        return 0
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    @IBAction func addAlarmList(_ sender: AnyObject) {
        let checkTime = didSelectedAmPm + didSelectedHour + didSelectedMinute
        let checkDay = globalVariableDay.checkDay
        let checkSound = globalVariableSound.checkSound

        let myAlarm: alarmInventory = alarmInventory(checkTime: checkTime, checkDay: checkDay, checkSound: checkSound)
        alarmList.myAlarmList.append(myAlarm)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return self.subMenu.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAtIndexPath indexPath: IndexPath) -> UITableViewCell{
        var cell = tableView.dequeueReusableCell(withIdentifier: "Week")
        
        if( indexPath.row == 0 ){
            cell = tableView.dequeueReusableCell(withIdentifier: "Week")
        }
        else{
            cell = tableView.dequeueReusableCell(withIdentifier: "Sound")
        }
        
        cell?.textLabel?.text = subMenu[indexPath.row]
        cell?.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
        cell?.selectionStyle = UITableViewCellSelectionStyle.blue
        return cell!
    }
    
}
