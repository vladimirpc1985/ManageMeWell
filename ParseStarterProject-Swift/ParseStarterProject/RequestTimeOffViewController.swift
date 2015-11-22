//
//  RequestTimeOffViewController.swift
//  ParseStarterProject-Swift
//
//  Created by Lisbeth Cardoso on 11/21/15.
//  Copyright © 2015 Parse. All rights reserved.
//

import UIKit

class RequestTimeOffViewController: UIViewController {

    @IBOutlet weak var fromDatePicker: UIDatePicker!
    @IBOutlet weak var reasonPicker: UIPickerView!
    @IBOutlet weak var toDatePicker: UIDatePicker!
    
    
    @IBAction func editSubmitButtonClicked(sender: AnyObject) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
