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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return self.subMenu.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAtIndexPath indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "Vibration")

        cell?.textLabel?.text = subMenu[indexPath.row]
        cell?.selectionStyle = UITableViewCellSelectionStyle.blue
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAtIndexPath indexPath: IndexPath) {
        
        if (indexPath.row == 0){
            let cell = tableView.cellForRow(at: indexPath)
            if ( cell?.accessoryType == .checkmark ){
                cell?.accessoryType = .none
                globalVariableSound.checkSound = 1
            }else{
                cell?.accessoryType = .checkmark
                globalVariableSound.checkSound = 2
            }
        }
    }
}
