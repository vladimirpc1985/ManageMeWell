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
    


}