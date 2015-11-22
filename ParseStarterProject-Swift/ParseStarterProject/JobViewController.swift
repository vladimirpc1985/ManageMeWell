import UIKit
import Parse

class JobViewController: UIViewController
{
    var jobsArray = [PFObject]()

    // Table View Variable
    @IBOutlet weak var tableView: UITableView!
    
    
    
    
    
    
    
    
    /*************************************************************/
    
    
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "BackToMainScreenFromJobs"
        {
            let svc = segue.destinationViewController as! MainScreenViewController
            let role: String = PFUser.currentUser()!["role"] as! String
            svc.selectedRole = Tools.getUserRole(role)
        }
//        else if segue.identifier == "FromNewJobViewToMainScreenViewAfterCreateAJob"
//        {
//            let svc = segue.destinationViewController as! MainScreenViewController
//            let role: String = PFUser.currentUser()!["role"] as! String
//            svc.selectedRole = Tools.getUserRole(role)
//        }
        
    }
    
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Avoid the cells' seperator lines.
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        
        let query = PFQuery(className: "Job")
        query.orderByAscending("jobStartTime")
        query.findObjectsInBackgroundWithBlock { (posts: [PFObject]?, error: NSError?) -> Void in
            if error == nil
            {
                // Success fitching objects
                for post in posts!
                {
                    self.jobsArray.append(post)
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
    
    
    
//    /****************************************************************/
//    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
//    {
//        return self.jobsArray.count
//    }
//    
//    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
//    {
//        
//        let oneCell: JobsCell = tableView.dequeueReusableCellWithIdentifier("IdentifierJobsCell") as! JobsCell
//        
//        
//        oneCell.textLabel?.text = self.jobsArray[indexPath.row]["jobName"] as? String
//        
//        
//        return oneCell
//    }
//    
//    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
//    {
//        
//        let selectedCell: UITableViewCell = tableView.cellForRowAtIndexPath(indexPath)!
//        
//
//        
//    }


}
