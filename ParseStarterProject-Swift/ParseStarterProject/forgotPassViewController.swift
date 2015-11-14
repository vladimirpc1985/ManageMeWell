//
//  forgotPassViewController.swift
//  ParseStarterProject-Swift
//
//  Created by Lesly Villa on 11/13/15.
//  Copyright © 2015 Parse. All rights reserved.
//

import UIKit
import Parse

class forgotPassViewController: UIViewController {

    
    
    @IBOutlet weak var emailAddressTextField: UITextField!
    
    
    @IBAction func submitButton(sender: AnyObject) {
        
        emailIsEmpty()
    }
    
    
    @IBAction func cancelButton(sender: AnyObject) {
        
        //Cancel the password reset. Dismmissing this view controller.
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func emailIsEmpty(){
    
        let email = emailAddressTextField.text
        
        if email!.isEmpty
        {
            //Display a warning message
            
            let messageToUser: String = "Enter your email address, please."
            showMessage(messageToUser)
            return
        }
        
        PFUser.requestPasswordResetForEmailInBackground(email!, block: { (success:Bool, error:NSError?) -> Void in
            
            if (error != nil){
            
                //Display error message
                let errorMessage: String = error!.localizedDescription
                self.showMessage(errorMessage)
                
            }
            else{
                
                //Display a success message
                let succeedMessage: String = "We have sent a message to your email address \(email)"
                self.showMessage(succeedMessage)
                self.dismissViewControllerAnimated(true, completion: nil)
                
            }
            
        })
        
    }
    
    func showMessage(messageToUser:String){
   
        Tools.showAlert(self, alertTitle: "Alert", alertMessage: messageToUser)
        
        
    }
}
