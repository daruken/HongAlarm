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
let ArrayMinute = Array(0...59)

private let hourViewRows = 1200
private let minuteViewRows = 6000
private let hourViewMiddle = ((hourViewRows / ArrayHour.count) / 2) * ArrayHour.count
private let minuteViewMiddle = ((minuteViewRows / ArrayMinute.count) / 2) * ArrayMinute.count

class ViewEditController : UIViewController, UIPickerViewDelegate, UIPickerViewDataSource{
    
    @IBOutlet weak var PickerAmPm: UIPickerView!
    @IBOutlet weak var PickerHour: UIPickerView!
    @IBOutlet weak var PickerMinute: UIPickerView!
    
    var didSelectedAmPm = 0
    var didSelectedHour = 0
    var didSelectedMinute = 0
    var alarmList = [Int]()
    
    override func viewDidLoad() {
        
        PickerAmPm.delegate = self
        PickerAmPm.dataSource = self
        
        PickerHour.delegate = self
        PickerHour.dataSource = self
        
        PickerMinute.delegate = self
        PickerMinute.dataSource = self
        
        let date = NSDate()
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components(.CalendarUnitHour | .CalendarUnitMinute, fromDate: date)
        
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

    }

    func hourForRow(row: Int) -> Int {
        return ArrayHour[row % ArrayHour.count]
    }

    func minuteForRow(row: Int) -> Int {
        return ArrayMinute[row % ArrayMinute.count]
    }
  
    func hourForValue(value: Int) -> Int? {
        if let valueIndex = find(ArrayHour, value) {
            return hourViewMiddle + value
        }
        return nil
    }
    
    func minuteForValue(value: Int) -> Int? {
        if let valueIndex = find(ArrayMinute, value) {
            return minuteViewMiddle + value
        }
        return nil
    }
    
    
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        switch pickerView {
        case PickerAmPm :
            return ArrayAmPm[row]
        case PickerHour :
            return "\(hourForRow(row))"
        case PickerMinute :
            return "\(minuteForRow(row))"
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
        
        if pickerView == PickerAmPm
        {
            didSelectedAmPm = (row+1) * 10000
        }
        else if pickerView == PickerHour
        {
            didSelectedHour = (newHourRow%12+1) * 100
        }
        else if pickerView == PickerMinute
        {
            didSelectedMinute = newMinuteRow%60
        }
        else
        {
            
        }
        
        //let sum = didSelectedAmPm + didSelectedHour + didSelectedMinute
        //testLabel.text = String(sum)
        
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
    
    
    @IBOutlet weak var testLabel: UILabel!
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }

    @IBAction func addAlarmList(sender: AnyObject) {
    
    }
}