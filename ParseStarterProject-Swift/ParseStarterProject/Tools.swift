//
//  Tools.swift
//  ParseStarterProject-Swift
//
//  Created by Lesly Villa on 11/6/15.
//  Copyright © 2015 Parse. All rights reserved.
//

import Foundation
import UIKit

enum Role {
    case Client
    case Vendor
    case Employee
    case EmployeePending
}

enum EmployeeOptions
{
    case MySchedule
    case GiveUpShift
    case RequestTimeOff
    case Availability
}

class Tools
{
    static var userTypesList = ["Choose user type", "Vendor (provides service)", "Client (requests service)", "Employee"]

    
    static func showAlert(uiViewController: UIViewController, alertTitle: String, alertMessage: String)
    {
        if #available(iOS 8.0, *)
        {
            let alertSuccess = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .Alert)
            let alertAction = UIAlertAction(title: "Ok", style: .Destructive, handler: nil)
            alertSuccess.addAction(alertAction)
            uiViewController.presentViewController(alertSuccess, animated:true, completion: nil)
        }
        else
        {
            // Fallback on earlier versions
            print(alertTitle + " " + alertMessage)
        }
    }
    
    //This function returns the options listed in the table view for a user according to his/her role
    //role: Employee, Vendor or Client
    static func setOptions(role: Role)throws ->[String!]
    {
        var optionsList : [String!] = []
        
        if role == Role.Employee
        {
            optionsList = ["My Schedule", "Give Up Shift", "Request Time Off", "Availability"]
        }
        else if role == Role.Vendor
        {
            optionsList = ["Add Job", "Jobs", "Employees Availability", "Clock In / Clock Out", "Add Employee", "Employees"]
        }
        else if role == Role.Client
        {
            optionsList = ["Create Work Order", "Works"]
        }
        else
        {
            NSException(name: "InvalidRole", reason: "Role type is supposed to be employee, vendor or client.", userInfo: nil).raise()
            //print("Error: Role type is supposed to be employee, vendor or client.")
        }
        
        return optionsList
    }
    
    
    static func getStringFromArray(errors: [String!])->String
    {
        var result = ""
        
        for(var i=0;i<errors.count - 2;i++)
        {
            result += errors[i]
            result += ", "
        }
        
        if errors.count == 1
        {
            result = errors[0]
        }
        else
        {
            if errors.count == 2
            {
                result = errors[0] + " "
            }

            result += "and " + errors[errors.count - 1]
        }
        
        return result
    }
    
    static func getUserRole(role: String!) ->Role
    {
        switch role
        {
        case userTypesList[1]:
            return Role.Vendor
        case userTypesList[3]:
            return Role.Employee
        default:
            return Role.Client
        }
    }

}