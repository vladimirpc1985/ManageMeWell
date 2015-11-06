/*
This is the Sign Up page.
*/

import UIKit
import Parse

class SingUpViewController: UIViewController, UIPickerViewDelegate
{
    // Text Fields
    @IBOutlet weak var nameField: UITextField!
    
    @IBOutlet weak var emailField: UITextField!
    
    @IBOutlet weak var userIDField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    
    @IBOutlet weak var passwordVerifiedField: UITextField!
    
    @IBOutlet weak var userTypePickerView: UIPickerView!
    
    // Labels
    @IBOutlet weak var errorLabel: UILabel!
    
    var userTypesList = ["Choose user type", "Vendor (provides service)", "Client (requests service)", "Employee"]
    var selectedUserType: String!
    
    
    // Action Buttons
    @IBAction func signUpAction(sender: AnyObject)
    {
        // By defaul:
        self.errorLabel.textColor = UIColor.redColor()
        self.errorLabel.hidden = true
        self.nameField.backgroundColor = UIColor.whiteColor()
        self.emailField.backgroundColor = UIColor.whiteColor()
        self.userIDField.backgroundColor = UIColor.whiteColor()
        self.passwordField.backgroundColor = UIColor.whiteColor()
        self.passwordVerifiedField.backgroundColor = UIColor.whiteColor()

        var isProfileOk = checkProfileInfo()
        var isPasswordOk = checkPasswordMatches()
        
        /*
        if self.nameField.text!.isEmpty || self.emailField.text!.isEmpty || self.userIDField.text!.isEmpty || self.passwordField.text!.isEmpty || self.passwordVerifiedField.text!.isEmpty || self.selectedUserType == self.userTypesList[0]
        {
            // Error! At least one field does not have information.
            self.errorLabel.text = "All the fields need information"
            self.errorLabel.hidden = false
            
           
            
            
        }
*/
        if( isProfileOk && isPasswordOk )
        {
            // Each field has information. Then, go to sign up.
            let userObject = createPFUser()
            
            userObject.signUpInBackgroundWithBlock({ (isSuccessful: Bool, isError: NSError?) -> Void in
                
                if isSuccessful
                {
                    // Was succesful the sign up.
                    // Then, add Name, Cellphone, Company Name, and User type
                    self.addInfoToPFUser(userObject)
                    
                    userObject.saveInBackgroundWithBlock({ (isSuccessful2: Bool, isError2: NSError?) -> Void in
                        
                        if isSuccessful2
                        {
                            // Was successful.
                            
                            //check if employee
                            //if employee, send request to employer and 
                            //show Alert - request sent to employee, waiting for approval
                            print("Alert")
                        }
                        else
                        {
                            // There is an error.
                            print(isError2)
                        }
                    })
                    
                }
                else
                {
                    //There is an error.
                    print(isError)
                    
                    self.errorLabel.text = "Invalid UserID, Password, and/or Email. \n Please, try again."
                    self.errorLabel.hidden = false
                    
                }
            })
        }
        
        
    }
    
    func createPFUser()->PFUser
    {
        //finish
        let userObject = PFUser()
        userObject.username = self.userIDField.text
        userObject.email = self.emailField.text
        userObject.password = self.passwordField.text

        return userObject
    }
    
    
    
    func addInfoToPFUser(userObject: PFUser)->PFUser
    {
        userObject["name"] = self.nameField.text
        
        return userObject
    }
    
    
    
    func checkProfileInfo()->Bool
    {
        var fieldsWithErrors : [String!] = []
        
        if self.nameField.text!.isEmpty
        {
            fieldsWithErrors.append("name")
            self.nameField.backgroundColor = UIColor.redColor()
        }
        
       
        
        if self.emailField.text!.isEmpty
        {
            fieldsWithErrors.append("email")
            self.emailField.backgroundColor = UIColor.redColor()
        }
        
        if self.userIDField.text!.isEmpty
        {
            fieldsWithErrors.append("username")
            self.userIDField.backgroundColor = UIColor.redColor()
        }
        
        if self.passwordField.text!.isEmpty
        {
            fieldsWithErrors.append("password")
            self.passwordField.backgroundColor = UIColor.redColor()
        }
        
        if self.passwordVerifiedField.text!.isEmpty
        {
            fieldsWithErrors.append("password match")
            self.passwordVerifiedField.backgroundColor = UIColor.redColor()
        }
        
        if fieldsWithErrors.count > 0
        {
            //print("Alert")
            return false
        }
        else
        {
            return true
        }
    }
    
    func checkPasswordMatches()->Bool
    {
        if self.passwordField.text != self.passwordVerifiedField.text
        {
            // The password and the password verified texts are not equals.
            print("Alert")
            return false
            //self.errorLabel.text = "Sorry, the password mismatchs. \nPlease, try again."
            //self.errorLabel.hidden = false
        }
        else
        {
            return true
        }
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView!)->Int
    {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        return userTypesList.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        return userTypesList[row]
    }

    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        selectedUserType = userTypesList[row]
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
