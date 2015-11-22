/*
This is the Sign Up page.
*/

import UIKit
import Parse

class SingUpViewController: UIViewController, UIPickerViewDelegate, UINavigationControllerDelegate, UITextFieldDelegate, UITableViewDelegate
{
    // Text Field Variables
    var nameField: String = ""
    var lastNameField: String = ""
    var emailField: String = ""
    var companyNameField: String = ""
    var phoneNumberField: Int! = 0
    var userIDField: String = ""
    var passwordField: String = ""
    var passwordVerifiedField: String = ""
    var selectedUserType: String!
    
    // Containers
    var userTypesList = Tools.userTypesList
    var inputFields = ["First Name:", "Last Name:", "Email:", "Company Name:", "Phone Number(10 numbers with no spaces):", "UserName:", "Password:", "Re-enter Password:"]
    var profileInfo = [SignUpTableViewCell()]
    
    // PickerView
    @IBOutlet weak var userTypePickerView: UIPickerView!
    
    // Table View Variable
    @IBOutlet weak var tableView: UITableView!

    // Action Buttons
    @IBAction func signUpAction(sender: AnyObject)
    {
        fillLabelsFields()
        
        let isProfileOk = checkProfileInfo()
        let isPasswordOk = checkPasswordMatches()
        
        if (phoneNumberField != 0)
        {
            if( isProfileOk && isPasswordOk )
            {
                // Each field has information. Then, go to sign up.
                let userObject = createPFUser()
                
                userObject.signUpInBackgroundWithBlock({ (isSuccessful: Bool, isError: NSError?) -> Void in
                    if isSuccessful
                    {
                        // Was succesful the sign up. Then, add the rest of the information.
                        self.addInfoToPFUser(userObject)
                        
                        userObject.saveInBackgroundWithBlock({ (isSuccessful2: Bool, isError2: NSError?) -> Void in
                            if isSuccessful2
                            {
                                // Was successful.
                                if self.isEmployee()
                                {
                                    //if employee, send request to employer and
                                    //show Alert - request sent to employee, waiting for approval
                                    // Tools.showAlert(self, alertTitle: "Pending Approval!", alertMessage: "Waiting for manager approval.")
                                    self.performSegueWithIdentifier("EmployeeGoToLoginPage", sender: self)
                                }
                                else
                                {
                                    print("Successful sign up!")
                                    self.performSegueWithIdentifier("signUpToMainScreen", sender: self)
                                }
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
                    }
                })
            }
        }
        else
        {
            // The phone number is incorrect
            Tools.showAlert(self,alertTitle: "Invalid phone number!", alertMessage: "The phone number is incorrect. It must be 10 digits with no spaces, letters, or symbols.")
        }
    }

    // Create New User.
    func createPFUser()->PFUser
    {
        let userObject = PFUser()
        userObject.username = self.userIDField
        userObject.email = self.emailField
        userObject.password = self.passwordField

        return userObject
    }

    // Saving information in user.
    func addInfoToPFUser(userObject: PFUser)->PFUser
    {
        userObject["firstName"] = self.nameField
        userObject["lastName"] = self.lastNameField
        userObject["phoneNumber"] = self.phoneNumberField
        userObject["companyName"] = self.companyNameField
        userObject["role"] = self.selectedUserType
        
        return userObject
    }


    func fillLabelsFields()
    {
        nameField = profileInfo[1].informationField.text!
        lastNameField = profileInfo[2].informationField.text!
        emailField = profileInfo[3].informationField.text!
        companyNameField = profileInfo[4].informationField.text!
       
        
        if (profileInfo[5].informationField.text!.isEmpty)
        {
            // The string is empty.
            phoneNumberField = -1
        }
        else if (phoneNumberValidate(profileInfo[5].informationField.text!))
        {
            // The string is a valid number.
            phoneNumberField = Int(profileInfo[5].informationField.text!)!
        }
        else
        {
            // The string is not a valid number.
            phoneNumberField = 0
        }
        
        userIDField = profileInfo[6].informationField.text!
        passwordField = profileInfo[7].informationField.text!
        passwordVerifiedField = profileInfo[8].informationField.text!
    }
    
    
    // Regular Expression for phone number validation.
    func phoneNumberValidate(number: String) -> Bool {
        
        let phoneREGEX = "^\\d{10}$"
        
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", phoneREGEX)
        
        let ans =  phoneTest.evaluateWithObject(number)
        
        return ans
    }
    
    
    func isEmployee()-> Bool
    {
        if selectedUserType == userTypesList[3]
        {//and check if is valid employee (vendor authorized him/her)
            return true
        }
        
        return false
    }
    
    
    func checkProfileInfo()->Bool
    {
        var fieldsWithErrors : [String!] = []
        
    
        if self.nameField == ""
        {
            fieldsWithErrors.append("name")
        }
        
        if self.lastNameField == ""
        {
            fieldsWithErrors.append("last name")
        }
        
        if self.emailField == ""
        {
            fieldsWithErrors.append("email")
        }
        
        if self.companyNameField == ""
        {
            if selectedUserType != nil
            {
                if selectedUserType == userTypesList[1] || selectedUserType == userTypesList[3]
                {
                    fieldsWithErrors.append("company name")
                }
            }
        }
        
        if self.phoneNumberField == -1
        {
            fieldsWithErrors.append("phone number")
        }
        
        if self.userIDField == ""
        {
            fieldsWithErrors.append("username")
        }
        
        if self.passwordField == ""
        {
            fieldsWithErrors.append("password")
        }
        
        if self.passwordVerifiedField == ""
        {
            fieldsWithErrors.append("password match")
        }
        
        if  selectedUserType == nil || selectedUserType == userTypesList[0]
        {
            fieldsWithErrors.append("user's type")
        }
        
        if fieldsWithErrors.count > 0
        {
            Tools.showAlert(self,alertTitle: "Sign up failed!", alertMessage: Tools.getStringFromArray(fieldsWithErrors) + " are missing.")
            return false
        }
        else
        {
            return true
        }
    }

    // Check that password matchs with re-enter password.
    func checkPasswordMatches()->Bool
    {
        if self.passwordField != self.passwordVerifiedField
        {
            // The password and the password verified texts are not equals.
            Tools.showAlert(self,alertTitle: "Password mismatches!", alertMessage: " Sorry, the password mismatches.")
            return false
        }
        else
        {
            return true
        }
    }
    
    /************************ PickerView Methods ********************************/
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
        
    /******************************* Populate the Cells ****************************************/
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return inputFields.count
    }
        
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        
        let oneCell: SignUpTableViewCell = tableView.dequeueReusableCellWithIdentifier("Cell") as! SignUpTableViewCell
    
        oneCell.informationField.placeholder = inputFields[indexPath.row]
        profileInfo.append(oneCell)
        
        if profileInfo.count == 8 || profileInfo.count == 9
        {
            oneCell.informationField.secureTextEntry = true
        }
        
        return oneCell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "signUpToMainScreen"
        {
            //let svc = segue.destinationViewController as! MainScreenViewController
            let role: String = PFUser.currentUser()!["role"] as! String
            selectedRole = Tools.getUserRole(role)
        }
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        // Avoid the cells' seperator lines.
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
}

