//
//  GiveUpShiftViewController.swift
//  ParseStarterProject-Swift
//
//  Created by Lisbeth Cardoso on 11/13/15.
//  Copyright © 2015 Parse. All rights reserved.
//

import UIKit

class GiveUpShiftViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var messageTextView: UITextView!

    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        // Do any additional setup after loading the view.
        messageTextView.delegate = self
        
        addBordersToUITextView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func sendMessage(sender: AnyObject) {
        
        do
        {
            try sendRequestToVendor()
            
            Tools.showAlert(self, alertTitle: "Success!", alertMessage: "Your give-up-shift request message was successfully sent and is pending for approval.")
        }
        catch
        {
            Tools.showAlert(self, alertTitle: "Send Request Failed!", alertMessage: "Your give-up-shift request message was not sent.")
        }
    }
    
    func addBordersToUITextView()
    {
        //http://stackoverflow.com/questions/2647164/bordered-uitextview
        
        self.messageTextView.layer.borderWidth = 1
        self.messageTextView.layer.borderColor = UIColor.grayColor().CGColor
        self.messageTextView.layer.cornerRadius = 8
    }
    
    //This function sends a request to give up shift for vendor to approve/decline.
    func sendRequestToVendor() throws
    {
    
    }
    
    //This code clears the textView when user starts editing
    func textViewDidBeginEditing(textView: UITextView) {
        self.messageTextView.text = ""
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
