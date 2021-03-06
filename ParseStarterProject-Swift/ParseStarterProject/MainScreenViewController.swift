//
//  MainScreenViewController.swift
//  ParseStarterProject-Swift
//
//  Created by Lisbeth Cardoso on 11/6/15.
//  Copyright © 2015 Parse. All rights reserved.
//

import UIKit
import Parse

var selectedRole : Role!

class MainScreenViewController: UIViewController, UITableViewDelegate , UITableViewDataSource {

<<<<<<< HEAD
    @IBOutlet weak var tableView: UITableView!
    
    var selectedRole : Role!
=======
>>>>>>> 45ad2da3e49a34b97126d00aaecf7829d537cfad
    var options : [String!] = []
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Avoid the cells' seperator lines.
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        
        
        //selectedRole = Role.Client //set this in the previous view (successful sign in / sign up)
        
        do
        {
            try self.options = Tools.setOptions(selectedRole)
        }
        catch
        {
            print("Invalid role.")
        }
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "mainScreenCell")
        cell.textLabel?.text = options[indexPath.row]
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.count
    }
    
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        let selectedCell: UITableViewCell = tableView.cellForRowAtIndexPath(indexPath)!
        
        
        if selectedRole == Role.Employee
        {
            let option = Tools.getEmployeeOption(indexPath.row)
            
            var identifier = ""
            
            switch option
            {
            case EmployeeOptions.MySchedule:
                break
            case EmployeeOptions.GiveUpShift:
                identifier = "mainScreenToGiveUpShift"
                break
            case EmployeeOptions.RequestTimeOff:
                break
            default://option == EmployeeOptions.Availability
                break
            }
            
            self.performSegueWithIdentifier(identifier, sender: self)
            
            return
        }
        
        if selectedRole == Role.Client
        {
            return
        }
        
        if selectedRole == Role.Vendor
        {

            selectedOptionRow(selectedCell)
            return
        }
    }
    
    func selectedOptionRow(selectedCell: UITableViewCell)
    {
        if selectedCell.textLabel!.text == options[0]
        {
            self.performSegueWithIdentifier("IdentifierFromMainScreenToNewJob", sender: self)
        }
        else if selectedCell.textLabel!.text == options[1]
        {
            self.performSegueWithIdentifier("IdentifierFromMainScreenToJobs", sender: self)
        }
        else if selectedCell.textLabel!.text == options[2]
        {}
        else if selectedCell.textLabel!.text == options[3]
        {}
        else if selectedCell.textLabel!.text == options[4]
        {}
        else
        {}
    }
    
    

}
