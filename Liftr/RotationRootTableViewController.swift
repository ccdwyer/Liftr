//
//  RotationRootTableViewController.swift
//  Liftr
//
//  Created by Christopher Dwyer on 8/27/16.
//  Copyright © 2016 Christopher Dwyer. All rights reserved.
//

import UIKit

class RotationRootTableViewController: UITableViewController {
    
    var rotationGroups = [RotationGroup]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        setupUI()
        rotationGroups += [
            RotationGroup(name: "Week One"),
            RotationGroup(name: "Week Two"),
            RotationGroup(name: "Week Three"),
            RotationGroup(name: "Week Four")
        ]
        //self.tableView.editing = true
    }
    
    func setupUI() {
        setupNavigationBar()
        setupStatusBar()
        setupTabBar()
    }
    
    func setupNavigationBar() {
        let addIcon = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(RotationRootTableViewController.addButtonClicked))
        addIcon.tintColor = UIColor.orange
        
        let resetButton = UIBarButtonItem(title: "Reset", style: .plain, target: self, action: #selector(RotationRootTableViewController.resetButtonClicked))
        

        resetButton.tintColor = UIColor.orange
        
        self.navigationItem.leftBarButtonItems = [
            resetButton
        ]
        self.navigationItem.rightBarButtonItems = [
            addIcon
        ]
        self.navigationItem.title = "Rotation"
        self.navigationController?.navigationBar.barTintColor = UIColor.darkGray
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.orange]
        
    }
    
    func setupStatusBar() {
        UIApplication.shared.isStatusBarHidden = false
        UIApplication.shared.statusBarStyle = .lightContent
    }
    
    func setupTabBar() {
        self.tabBarController?.tabBar.barTintColor = UIColor.black
        self.tabBarController?.tabBar.tintColor = UIColor.orange
    }
    
    func addButtonClicked() {
        print("Add Button Click Detected")
    }
    
    func resetButtonClicked() {
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return rotationGroups.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "RotationGroupTableViewCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! RotationGroupTableViewCell
        let rotationGroup = rotationGroups[(indexPath as NSIndexPath).row]
        cell.titleLabel.text = rotationGroup.name

        // Configure the cell...
        if (indexPath as NSIndexPath).row == 0 {
            cell.statusLabel.text = "Complete"
            cell.setControlsAlpha(CGFloat(0.4))
        } else if (indexPath as NSIndexPath).row == 1 {
            cell.statusLabel.text = "In Progress"
        } else {
            cell.statusLabel.text = "Not Started"
            cell.setControlsAlpha(CGFloat(0.8))
        }
        
        let cellBGView = UIView()
        cellBGView.backgroundColor = UIColor(red: 255.0/255.0, green: 127.0/255.0, blue: 0, alpha: 0.15)
        cell.selectedBackgroundView = cellBGView

        return cell
    }
    

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            rotationGroups.remove(at: (indexPath as NSIndexPath).row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
        rotationGroups.removeAtIndex(fromIndexPath.row)
    }
    */
    

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
