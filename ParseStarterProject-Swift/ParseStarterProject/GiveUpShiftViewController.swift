//
//  GiveUpShiftViewController.swift
//  ParseStarterProject-Swift
//
//  Created by Lisbeth Cardoso on 11/13/15.
//  Copyright © 2015 Parse. All rights reserved.
//

import UIKit

class GiveUpShiftViewController: UIViewController {

    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var messageTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        reset()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func sendMessage(sender: AnyObject) {
        
    }
    
    func reset()
    {
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
