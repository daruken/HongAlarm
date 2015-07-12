//
//  ViewEditController.swift
//  HongAlarm
//
//  Created by JeonHongYeol on 2015. 7. 7..
//  Copyright (c) 2015년 JeonHongYeol. All rights reserved.
//

import Foundation
import UIKit

class ViewEditController : UIViewController, UIPickerViewDelegate, UIPickerViewDataSource{
    
    @IBOutlet weak var PickerAmPm: UIPickerView!
    @IBOutlet weak var PickerHour: UIPickerView!
    @IBOutlet weak var PickerMinute: UIPickerView!
    
    var ArrayAmPm = ["오전", "오후"]
    var ArrayHour = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12" ]
    var ArrayMinute = ["00", "01", "02", "03", "04", "05", "06", "07", "08", "09"
    , "10", "11", "12", "13", "14", "15", "16", "17", "18", "19"
    , "20", "21", "22", "23", "24", "25", "26", "27", "28", "29"
    , "30", "31", "32", "33", "34", "35", "36", "37", "38", "39"
    , "40", "41", "42", "43", "44", "45", "46", "47", "48", "49"
    , "50", "51", "52", "53", "54", "55", "56", "57", "58", "59" ]
    
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
        
        if ( hour > 12 ){
            hour = hour - 13
            ampm = 1
        }
        
        PickerAmPm.selectRow(ampm, inComponent: 0, animated: false)
        PickerHour.selectRow(hour, inComponent: 0, animated: true)
        PickerMinute.selectRow(minute, inComponent: 0, animated: true)

    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        switch pickerView {
        case PickerAmPm :
            return ArrayAmPm[row]
        case PickerHour :
            return ArrayHour[row]
        case PickerMinute :
            return ArrayMinute[row]
        default :
            break
        }

        return ""
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView {
        case PickerAmPm :
            return ArrayAmPm.count
        case PickerHour :
            return ArrayHour.count
        case PickerMinute :
            return ArrayMinute.count
        default :
            break
        }
        return 0
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component:Int ){

        if pickerView == PickerAmPm
        {
            didSelectedAmPm = (row+1) * 10000
        }
        else if pickerView == PickerHour
        {
            didSelectedHour = (row+1) * 100
        }
        else if pickerView == PickerMinute
        {
            didSelectedMinute = row
        }
        else
        {
            
        }
        
        let sum = didSelectedAmPm + didSelectedHour + didSelectedMinute
        testLabel.text = String(sum)
    }
    
    @IBOutlet weak var testLabel: UILabel!
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    @IBAction func addAlarmList(sender: AnyObject) {
    
    }
}