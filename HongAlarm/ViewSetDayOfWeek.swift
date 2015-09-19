//
//  ViewSetDayOfWeek.swift
//  HongAlarm
//
//  Created by K on 2015. 9. 7..
//  Copyright (c) 2015년 JeonHongYeol. All rights reserved.
//

import UIKit

class ViewSetDayOfWeek: UIViewController {
    
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
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.subMenu.count;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("Monday")
 
        cell?.textLabel?.text = subMenu[indexPath.row]
        cell?.accessoryType = UITableViewCellAccessoryType.Checkmark
        cell?.selectionStyle = UITableViewCellSelectionStyle.Blue
                
        return cell!
    }
}