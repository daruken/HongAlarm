//
//  ViewSetSoundForAlarm.swift
//  HongAlarm
//
//  Created by K on 2015. 9. 12..
//  Copyright (c) 2015년 JeonHongYeol. All rights reserved.
//

import UIKit

struct globalVariableSound {
    static var checkSound: Int = 1
}

class ViewSetSoundForAlarm: UIViewController {
    var subMenu = [
        "진동",
        "노래 선택"
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
        let cell = tableView.dequeueReusableCellWithIdentifier("Vibration")

        cell?.textLabel?.text = subMenu[indexPath.row]
        cell?.selectionStyle = UITableViewCellSelectionStyle.Blue
        
        return cell!
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if (indexPath.row == 0){
            let cell = tableView.cellForRowAtIndexPath(indexPath)
            if ( cell?.accessoryType == .Checkmark ){
                cell?.accessoryType = .None
                globalVariableSound.checkSound = 1
            }else{
                cell?.accessoryType = .Checkmark
                globalVariableSound.checkSound = 2
            }
        }
    }
}