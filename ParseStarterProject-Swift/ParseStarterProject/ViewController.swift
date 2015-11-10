/*
This is the Login Page.
*/

import UIKit
import Parse


class ViewController: UIViewController {
    
    // Text Fields
    @IBOutlet weak var userIDField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    
    var user : PFUser? = (PFUser.currentUser())
    
        
    // Action Buttons
    @IBAction func loginAction(sender: AnyObject)
    {
        if checkLoginInfo()
        {
            // Both fields have information. Then, go to login.
            PFUser.logInWithUsernameInBackground(self.userIDField.text!, password: self.passwordField.text!, block: { (isUser: PFUser?, isError: NSError?) -> Void in
                
                if isError == nil
                {
                    // The login was successful. Then, go to Main Screen.
                    print("Successful Login!")
                    
                    self.user = isUser!
                    self.performSegueWithIdentifier("logInToMainScreen", sender: self)
                    
                }
                else
                {
                    // Invalid UserID and/or Password.
                   Tools.showAlert(self, alertTitle: "Login failed!", alertMessage: "Invalid userName and / or password.")
                }
            })
        }
    }
    
    
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "logInToMainScreen"
        {
            let svc = segue.destinationViewController as! MainScreenViewController
            svc.selectedRole = getUserRole()
        }
    }
    
    func getUserRole()->Role
    {
        var userTypesList = Tools.userTypesList

        let role: String = PFUser.currentUser()!["role"] as! String
       
        
        switch role
        {
        case "Vendor":
            return Role.Vendor
        case userTypesList[2]:
            return Role.Client
        case userTypesList[3]:
            return Role.Employee
        default:
            return Role.Client   // This is never executed because it is not true
        }
    }
    
    
    func checkLoginInfo()->Bool
    {
        var emptyFields = [String!]()
        var result = true
        
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
            result = false
            Tools.showAlert(self, alertTitle: "Missing information!", alertMessage: Tools.getStringFromArray(emptyFields) + " are missing.")
        }
        
        return result
    }
    
    
    
    

    override func viewDidLoad()
    {
        super.viewDidLoad()

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
