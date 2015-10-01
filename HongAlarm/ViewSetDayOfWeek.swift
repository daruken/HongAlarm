//
//  ViewSetDayOfWeek.swift
//  HongAlarm
//
//  Created by K on 2015. 9. 7..
//  Copyright (c) 2015년 JeonHongYeol. All rights reserved.
//

import UIKit

struct globalVariableDay {
    static var checkDay: Int = 10000000
}

class ViewSetDayOfWeek: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var subMenu = [
        "월요일",
        "화요일",
        "수요일",
        "목요일",
        "금요일",
        "토요일",
        "일요일"
    ]
  
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return self.subMenu.count;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCellWithIdentifier("Monday")
        
        cell?.textLabel?.text = subMenu[indexPath.row]
        cell?.selectionStyle = UITableViewCellSelectionStyle.Blue
                
        return cell!
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        switch indexPath.row {
        case 0 :
            let cell = tableView.cellForRowAtIndexPath(indexPath)
            if ( cell?.accessoryType == .Checkmark ){
                cell?.accessoryType = .None
                globalVariableDay.checkDay -= 1000000
            }else{
                cell?.accessoryType = .Checkmark
                globalVariableDay.checkDay += 1000000
            }
        case 1 :
            let cell = tableView.cellForRowAtIndexPath(indexPath)
            if ( cell?.accessoryType == .Checkmark ){
                cell?.accessoryType = .None
                globalVariableDay.checkDay -= 100000
            }else{
                cell?.accessoryType = .Checkmark
                globalVariableDay.checkDay += 100000
            }
        case 2 :
            let cell = tableView.cellForRowAtIndexPath(indexPath)
            if ( cell?.accessoryType == .Checkmark ){
                cell?.accessoryType = .None
                globalVariableDay.checkDay -= 10000
            }else{
                cell?.accessoryType = .Checkmark
                globalVariableDay.checkDay += 10000
            }
        case 3 :
            let cell = tableView.cellForRowAtIndexPath(indexPath)
            if ( cell?.accessoryType == .Checkmark ){
                cell?.accessoryType = .None
                globalVariableDay.checkDay -= 1000
            }else{
                cell?.accessoryType = .Checkmark
                globalVariableDay.checkDay += 1000
            }
        case 4 :
            let cell = tableView.cellForRowAtIndexPath(indexPath)
            if ( cell?.accessoryType == .Checkmark ){
                cell?.accessoryType = .None
                globalVariableDay.checkDay -= 100
            }else{
                cell?.accessoryType = .Checkmark
                globalVariableDay.checkDay += 100
            }
        case 5 :
            let cell = tableView.cellForRowAtIndexPath(indexPath)
            if ( cell?.accessoryType == .Checkmark ){
            cell?.accessoryType = .None
            globalVariableDay.checkDay -= 10
            }else{
            cell?.accessoryType = .Checkmark
            globalVariableDay.checkDay += 10
            }
        case 6 :
            let cell = tableView.cellForRowAtIndexPath(indexPath)
            if ( cell?.accessoryType == .Checkmark ){
                cell?.accessoryType = .None
                globalVariableDay.checkDay -= 1
            }else{
                cell?.accessoryType = .Checkmark
                globalVariableDay.checkDay += 1
            }
        default :
            break
        }
        
    }
}