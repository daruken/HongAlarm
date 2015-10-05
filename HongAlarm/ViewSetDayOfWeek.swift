//
//  ViewSetDayOfWeek.swift
//  HongAlarm
//
//  Created by K on 2015. 9. 7..
//  Copyright (c) 2015년 JeonHongYeol. All rights reserved.
//

import UIKit

struct globalVariableDay {
    static var checkDay = [String]()
}

class ViewSetDayOfWeek: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var subMenu = [
        "일요일",
        "월요일",
        "화요일",
        "수요일",
        "목요일",
        "금요일",
        "토요일"
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
        case 0 : /* Sunday */
            let cell = tableView.cellForRowAtIndexPath(indexPath)
            if ( cell?.accessoryType == .Checkmark ){
                cell?.accessoryType = .None
            }else{
                cell?.accessoryType = .Checkmark
                globalVariableDay.checkDay.append("Sun")
            }
        case 1 : /* Monday */
            let cell = tableView.cellForRowAtIndexPath(indexPath)
            if ( cell?.accessoryType == .Checkmark ){
                cell?.accessoryType = .None
            }else{
                cell?.accessoryType = .Checkmark
                globalVariableDay.checkDay.append("Mon")
            }
        case 2 : /* Tuesday */
            let cell = tableView.cellForRowAtIndexPath(indexPath)
            if ( cell?.accessoryType == .Checkmark ){
                cell?.accessoryType = .None
            }else{
                cell?.accessoryType = .Checkmark
                globalVariableDay.checkDay.append("Tue")
            }
        case 3 : /* Wednesday */
            let cell = tableView.cellForRowAtIndexPath(indexPath)
            if ( cell?.accessoryType == .Checkmark ){
                cell?.accessoryType = .None
            }else{
                cell?.accessoryType = .Checkmark
                globalVariableDay.checkDay.append("Wed")
            }
        case 4 : /* Thursday */
            let cell = tableView.cellForRowAtIndexPath(indexPath)
            if ( cell?.accessoryType == .Checkmark ){
                cell?.accessoryType = .None
            }else{
                cell?.accessoryType = .Checkmark
                globalVariableDay.checkDay.append("Thu")
            }
        case 5 : /* Friday */
            let cell = tableView.cellForRowAtIndexPath(indexPath)
            if ( cell?.accessoryType == .Checkmark ){
                cell?.accessoryType = .None
            }else{
                cell?.accessoryType = .Checkmark
                globalVariableDay.checkDay.append("Fri")
            }
        case 6 : /* Saturday */
            let cell = tableView.cellForRowAtIndexPath(indexPath)
            if ( cell?.accessoryType == .Checkmark ){
                cell?.accessoryType = .None
            }else{
                cell?.accessoryType = .Checkmark
                globalVariableDay.checkDay.append("Sat")
            }
        default :
            break
        }
    }
}