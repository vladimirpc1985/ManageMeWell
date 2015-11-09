//
//  Tools.swift
//  ParseStarterProject-Swift
//
//  Created by Lesly Villa on 11/6/15.
//  Copyright © 2015 Parse. All rights reserved.
//

import Foundation
import UIKit
import Parse

enum Role {
    case Client
    case Vendor
    case Employee
}

class Tools: UIViewController
{
    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func showAlert(alertTitle: String, alertMessage: String)
    {
        if #available(iOS 8.0, *)
        {
            let alertSuccess = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .Alert)
            let alertAction = UIAlertAction(title: "Ok", style: .Destructive, handler: nil)
            alertSuccess.addAction(alertAction)
            self.presentViewController(alertSuccess, animated:true, completion: nil)
        }
        else
        {
            // Fallback on earlier versions
            print(alertTitle + " " + alertMessage)
        }
    }
    
    //This function returns the options listed in the table view for a user according to his/her role
    //role: Employee, Vendor or Client
    static func setOptions(role: Role)->[String!]
    {
        var optionsList : [String!] = []
        
        if role == Role.Employee
        {
            optionsList = ["My Schedule", "Give Up Shift", "Request Time Off", "Availability"]
        }
        else if role == Role.Vendor
        {
            optionsList = ["Add Job", "Jobs", "Workers Availability", "Clock In / Clock Out", "Workers"]
        }
        else if role == Role.Client
        {
            optionsList = ["Create Work Order", "Works"]
        }
        else
        {
            print("Error: Role type is supposed to be employee, vendor or client.")
        }
        
        return optionsList
    }

}