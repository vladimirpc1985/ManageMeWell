//
//  MainScreenViewController.swift
//  ParseStarterProject-Swift
//
//  Created by Lisbeth Cardoso on 11/6/15.
//  Copyright © 2015 Parse. All rights reserved.
//

import UIKit
import Parse

class MainScreenViewController: UIViewController, UITableViewDelegate , UITableViewDataSource {

    var selectedRole : Role!
    var options : [String!] = []
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
        if selectedRole == Role.Employee
        {
            return
        }
        
        if selectedRole == Role.Client
        {
            return
        }
        
        if selectedRole == Role.Vendor
        {
            return
        }
    }

}
