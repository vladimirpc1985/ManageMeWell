//
//  NewJobViewController.swift
//  ParseStarterProject-Swift
//
//  Created by Lesly Villa on 11/13/15.
//  Copyright © 2015 Parse. All rights reserved.
//

import UIKit
import Parse

class NewJobViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource
{
    var nameArray = [String]()
    var availableEmployees = [PFObject]()
    var selectedAvailableEmployees = [PFObject]()
    
    // Text Field Variables
    @IBOutlet weak var nameField: UITextField!
    
    @IBOutlet weak var locationField: UITextField!
    
    // Table View Variable
    @IBOutlet weak var tableView: UITableView!
    
    // Picker View Variables
    @IBOutlet weak var fromPickerView: UIDatePicker!
    
    @IBOutlet weak var toPickerView: UIDatePicker!
    
    
    // Action Buttons
    @IBAction func ShowAvailableEmployeesAction(sender: AnyObject)
    {
        // Clean the arrays
        nameArray.removeAll()
        availableEmployees.removeAll()
        selectedAvailableEmployees.removeAll()
        
        if checkPickerViewInfo()
        {
            let query = PFQuery(className: "_User")
            query.orderByAscending("firstName")
            query.whereKey("role", equalTo: "Employee")
            // query.whereKey("availability", equalTo: "")   //OJO This is different
            query.findObjectsInBackgroundWithBlock { (posts: [PFObject]?, error: NSError?) -> Void in
                if error == nil
                {
                    // Success fitching objects
                    for post in posts!
                    {
                        self.availableEmployees.append(post)

                        // Add the firstName and lastName of this particular object to the array "nameArray"
                        var temporalName: String = post["firstName"] as! String
                        temporalName += " "
                        temporalName += post["lastName"] as! String
                        
                        self.nameArray.append(temporalName)
                    }
                    // Reload the table with data
                    self.tableView.reloadData()
                }
                else
                {
                    // There is an error
                    print(error)
                }

            }
        
        }

    }
    
    
    @IBAction func SubmitButtonAction(sender: AnyObject)
    {
        // The name field and the pickers have valid information
       if checkFieldAndPickerViewInfo()
       {
        let jobObject:PFObject = createNewJob()
        
            jobObject.saveInBackgroundWithBlock({ (isSuccessful: Bool, isError: NSError?) -> Void in
                if isSuccessful
                {
                    //self.performSegueWithIdentifier("FromNewJobViewToMainScreenViewAfterCreateAJob", sender: self)
                }
                else
                {
                    // There is an error.
                    print(isError)
                }
            })
        }
    }
    
    // Create New Job.
    func createNewJob()->PFObject
    {
        let jobObject: PFObject = PFObject(className: "Job")
        
        jobObject["jobName"] = self.nameField.text
        jobObject["jobLocation"] = self.locationField.text
        jobObject["jobStartTime"] = self.fromPickerView.date
        jobObject["jobEndTime"] = self.toPickerView.date
        
        // OJO I need to add the employees that go to work in this job.
        // The objects of those employees are in selectedAvailableEmployees.
        // Therefore, we need to change in Parse.com the employeeID relation.
        // jobObject["employeeID"] = self.selectedAvailableEmployees
        return jobObject
    }
    

    
    
    
    func checkFieldAndPickerViewInfo() ->Bool
    {
        if self.nameField.text!.isEmpty
        {
            Tools.showAlert(self, alertTitle: "Empty Field!", alertMessage: "Please, provide a name for this job.")
            return false
        }
        if !checkPickerViewInfo()
        {
            return false
        }
        
        return true
    }
    func checkPickerViewInfo()-> Bool
    {
        let fromFormat = NSDateFormatter()
        fromFormat.dateFormat = "yyyy-MM-dd"
        let fromString = fromFormat.stringFromDate(fromPickerView.date)
        
        let toFormat = NSDateFormatter()
        toFormat.dateFormat = "yyyy-MM-dd"
        let toString = toFormat.stringFromDate(toPickerView.date)
        
        
        if fromString > toString
        {
            Tools.showAlert(self, alertTitle: "Wrong Dates!", alertMessage: "The last day of job has to be after the first day of job.")
            return false
        }
        
        return true
    }

    
    
   /****************************************************************/
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return nameArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        
        let oneCell: NewJobCell = tableView.dequeueReusableCellWithIdentifier("IdentifierNewJobCell") as! NewJobCell
        
        if oneCell.accessoryType == UITableViewCellAccessoryType.Checkmark
        {
            //OJO I need to remove all the checkmark in the cells that I am not use now.
            oneCell.accessoryType = UITableViewCellAccessoryType.None

        }
        oneCell.textLabel?.text = self.nameArray[indexPath.row]
        
        
        return oneCell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        
        let selectedCell: UITableViewCell = tableView.cellForRowAtIndexPath(indexPath)!
    
        if selectedCell.accessoryType != UITableViewCellAccessoryType.Checkmark
        {
            // selectedCell.backgroundColor = Tools.green
            selectedCell.textLabel?.backgroundColor = Tools.green
            //selectedCell.tintColor = UIColor.whiteColor()
            selectedCell.accessoryType = UITableViewCellAccessoryType.Checkmark
            // selectedCell.textLabel?.textColor = UIColor.whiteColor()
            
            selectedAvailableEmployees.append(availableEmployees[nameArray.indexOf(selectedCell.textLabel!.text!)!])
        }
        else
        {
            selectedCell.accessoryType = UITableViewCellAccessoryType.None
            
            selectedAvailableEmployees.removeAtIndex(selectedAvailableEmployees.indexOf(availableEmployees[nameArray.indexOf(selectedCell.textLabel!.text!)!])!)
            
        }

    }
    /*************************************************************/
   
    
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "BackToMainScreenFromNewJob"
        {
            let svc = segue.destinationViewController as! MainScreenViewController
            let role: String = PFUser.currentUser()!["role"] as! String
            svc.selectedRole = Tools.getUserRole(role)
        }
        else if segue.identifier == "FromNewJobViewToMainScreenViewAfterCreateAJob"
        {
            let svc = segue.destinationViewController as! MainScreenViewController
            let role: String = PFUser.currentUser()!["role"] as! String
            svc.selectedRole = Tools.getUserRole(role)
        }

    }
    
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        // Avoid the cells' seperator lines.
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None
    }


}
