//
//  ViewEditController.swift
//  HongAlarm
//
//  Created by JeonHongYeol on 2015. 7. 7..
//  Copyright (c) 2015년 JeonHongYeol. All rights reserved.
//

import Foundation
import UIKit

var ArrayAmPm = ["오전", "오후"]
let ArrayHour = Array(1...12)
let ArrayMinute = Array(00...59)

private let hourViewRows = 1200
private let minuteViewRows = 6000
private let hourViewMiddle = ((hourViewRows / ArrayHour.count) / 2) * ArrayHour.count
private let minuteViewMiddle = ((minuteViewRows / ArrayMinute.count) / 2) * ArrayMinute.count

struct alarmInventory {
    var checkTime: Int
    var checkDay: Int
    var checkSwitch: Bool
    
    init(checkTime: Int, checkDay: Int)
    {
        self.checkTime = checkTime
        self.checkDay = checkDay
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
        
        PickerAmPm.selectRow(ampm, inComponent: 0, animated: false)
        
        if let hourRow = hourForValue(hour) {
            PickerHour.selectRow(hourRow, inComponent: 0, animated: false)
        }

        if let minuteRow = minuteForValue(minute) {
            PickerMinute.selectRow(minuteRow, inComponent: 0, animated: false)
        }

 
        didSelectedAmPm = (ampm+1) * 10000
        didSelectedHour = (hour+1) * 100
        didSelectedMinute = minute

    }

    func hourForRow(row: Int) -> Int {
        return ArrayHour[row % ArrayHour.count]
    }

    func minuteForRow(row: Int) -> Int {
        return ArrayMinute[row % ArrayMinute.count]
    }
  
    func hourForValue(value: Int) -> Int? {
        if (ArrayHour.indexOf(value) >= 0) {
            return hourViewMiddle + value
        }
        return nil
    }
    
    func minuteForValue(value: Int) -> Int? {
          if (ArrayMinute.indexOf(value) >= 0) {
            return minuteViewMiddle + value
        }
        return nil
    }
    
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView {
        case PickerAmPm :
            return ArrayAmPm[row]
        case PickerHour :
            return String().stringByAppendingFormat("%.2d",hourForRow(row))
        case PickerMinute :
            return String().stringByAppendingFormat("%.2d",minuteForRow(row))
        default :
            break
        }
        return ""
    }
    
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
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
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
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
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }

    @IBAction func addAlarmList(sender: AnyObject) {
        let checkTime = didSelectedAmPm + didSelectedHour + didSelectedMinute
        let checkDay = variables.checkDay
        let myAlarm: alarmInventory = alarmInventory(checkTime: checkTime, checkDay: checkDay)
        alarmList.myAlarmList.append(myAlarm)
        variables.checkDay = 10000000
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.subMenu.count;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        var cell = tableView.dequeueReusableCellWithIdentifier("Week")
        
        if( indexPath.row == 0 ){
            cell = tableView.dequeueReusableCellWithIdentifier("Week")
        }
        else{
            cell = tableView.dequeueReusableCellWithIdentifier("Sound")
        }
        
        cell?.textLabel?.text = subMenu[indexPath.row]
        cell?.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        cell?.selectionStyle = UITableViewCellSelectionStyle.Blue
        
        return cell!
    }
    
}