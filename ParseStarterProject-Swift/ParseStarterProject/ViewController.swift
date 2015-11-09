/*
This is the Login Page.
*/

import UIKit
import Parse


class ViewController: UIViewController {
    
    // Text Fields
    @IBOutlet weak var userIDField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    
        
    // Action Buttons
    @IBAction func loginAction(sender: AnyObject)
    {
        if checkLoginInfo()
        {
            // Both fields have information. Then, go to login.
            PFUser.logInWithUsernameInBackground(self.userIDField.text!, password: self.passwordField.text!, block: { (isUser: PFUser?, isError: NSError?) -> Void in
                
                if isError == nil
                {
                    // The login was successful. Then, go to Control Profile.
                    print("Successful Login!")
                    
                    
                    
                    
                    
                   //////////// self.performSegueWithIdentifier("OjO Identifier Name", sender: self)
                    
                    
                    
                    
                    
                    
                }
                else
                {
                    // Invalid UserID and/or Password.
                   Tools.showAlert(self, alertTitle: "Login failed!", alertMessage: "Invalid userName and / or password.")
                }
            })
        }
    }
    
    
    
    
    
    func checkLoginInfo()->Bool
    {
        var emptyFields = [String!]()
        
        if self.userIDField.text!.isEmpty
        {
            emptyFields.append("user name")
        }
        
        if self.passwordField.text!.isEmpty
        {
            emptyFields.append("password")
        }
        
        
        if emptyFields.count > 0
        {
            // Error! At least one field does not have information.
            Tools.showAlert(self, alertTitle: "Missing information!", alertMessage: Tools.getStringFromArray(emptyFields) + " are missing.")
            return false
        }
        else
        {
            return false
        }
    }

    
    
    

    override func viewDidLoad()
    {
        super.viewDidLoad()

    }

    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
