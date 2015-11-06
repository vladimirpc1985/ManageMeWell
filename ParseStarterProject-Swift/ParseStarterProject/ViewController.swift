/*
This is the Login Page.

*/

import UIKit
import Parse


class ViewController: UIViewController {
    
    // Text Fields
    @IBOutlet weak var userIDField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    
    
    // Labels
    @IBOutlet weak var errorLabel: UILabel!
    

    
    // Action Buttons
    @IBAction func loginAction(sender: AnyObject)
    {
        // By defaul:
        self.errorLabel.textColor = UIColor.redColor()
        self.errorLabel.hidden = true
        self.userIDField.backgroundColor = UIColor.whiteColor()
        self.passwordField.backgroundColor = UIColor.whiteColor()
        
        if self.userIDField.text!.isEmpty || self.passwordField.text!.isEmpty
        {
            // Error! At least one field does not have information.
            self.errorLabel.text = "All the fields need information"
            self.errorLabel.hidden = false
            
            
            if self.userIDField.text!.isEmpty
            {self.userIDField.backgroundColor = UIColor.redColor()}
            
            if self.passwordField.text!.isEmpty
            {self.passwordField.backgroundColor = UIColor.redColor()}
            
        }
        else
        {
            // Both fields have information. Then, go to login.
            PFUser.logInWithUsernameInBackground(self.userIDField.text!, password: self.passwordField.text!, block: { (isUser: PFUser?, isError: NSError?) -> Void in
                
                if isError == nil
                {
                    // The login was successful. Then, go to Control Profile.
                    print("Successful Login!")
                    
                   //////////// self.performSegueWithIdentifier("successLogin", sender: self)
                }
                else
                {
                    // Invalid UserID and/or Password.
                    print(isError)
                    
                    self.errorLabel.text = "Invalid Information"
                    self.errorLabel.hidden = false
                    
                }
            })
        }
        
        
        
        
    }
    
    
    
    
    
    
    
    

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        // By defaul, I do not want to see the error label. 
        self.errorLabel.hidden = true

    }

    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
