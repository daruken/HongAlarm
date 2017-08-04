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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return self.subMenu.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "Monday")
        
        cell?.textLabel?.text = subMenu[indexPath.row]
        cell?.selectionStyle = UITableViewCellSelectionStyle.blue
                
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0 : /* Sunday */
            let cell = tableView.cellForRow(at: indexPath)
            if ( cell?.accessoryType == .checkmark ){
                cell?.accessoryType = .none
            }else{
                cell?.accessoryType = .checkmark
                globalVariableDay.checkDay.append("Sun")
            }
        case 1 : /* Monday */
            let cell = tableView.cellForRow(at: indexPath)
            if ( cell?.accessoryType == .checkmark ){
                cell?.accessoryType = .none
            }else{
                cell?.accessoryType = .checkmark
                globalVariableDay.checkDay.append("Mon")
            }
        case 2 : /* Tuesday */
            let cell = tableView.cellForRow(at: indexPath)
            if ( cell?.accessoryType == .checkmark ){
                cell?.accessoryType = .none
            }else{
                cell?.accessoryType = .checkmark
                globalVariableDay.checkDay.append("Tue")
            }
        case 3 : /* Wednesday */
            let cell = tableView.cellForRow(at: indexPath)
            if ( cell?.accessoryType == .checkmark ){
                cell?.accessoryType = .none
            }else{
                cell?.accessoryType = .checkmark
                globalVariableDay.checkDay.append("Wed")
            }
        case 4 : /* Thursday */
            let cell = tableView.cellForRow(at: indexPath)
            if ( cell?.accessoryType == .checkmark ){
                cell?.accessoryType = .none
            }else{
                cell?.accessoryType = .checkmark
                globalVariableDay.checkDay.append("Thu")
            }
        case 5 : /* Friday */
            let cell = tableView.cellForRow(at: indexPath)
            if ( cell?.accessoryType == .checkmark ){
                cell?.accessoryType = .none
            }else{
                cell?.accessoryType = .checkmark
                globalVariableDay.checkDay.append("Fri")
            }
        case 6 : /* Saturday */
            let cell = tableView.cellForRow(at: indexPath)
            if ( cell?.accessoryType == .checkmark ){
                cell?.accessoryType = .none
            }else{
                cell?.accessoryType = .checkmark
                globalVariableDay.checkDay.append("Sat")
            }
        default :
            break
        }
    }
}
