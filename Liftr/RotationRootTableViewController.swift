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
        
        rotationGroups[1].addElement(element: RotationGroup(name:"Warm Ups"))
        // rotationGroups[1].toAnyObject()
        let longpress = UILongPressGestureRecognizer(target: self, action: #selector(RotationRootTableViewController.longPressGestureRecognized(gestureRecognizer:)))
        self.tableView.addGestureRecognizer(longpress)
        //self.tableView.editing = true
    }
    
    func snapshopOfCell(inputView: UIView) -> UIView {
        UIGraphicsBeginImageContextWithOptions(inputView.bounds.size, false, 0.0)
        inputView.layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()! as UIImage
        UIGraphicsEndImageContext()
        let cellSnapshot : UIView = UIImageView(image: image)
        cellSnapshot.layer.masksToBounds = false
        cellSnapshot.layer.cornerRadius = 0.0
        cellSnapshot.layer.shadowOffset = CGSize(width: -5.0, height: 0.0)
        cellSnapshot.layer.shadowRadius = 5.0
        cellSnapshot.layer.shadowOpacity = 0.4
        return cellSnapshot
    }
    
    func longPressGestureRecognized(gestureRecognizer: UIGestureRecognizer) {
        let longPress = gestureRecognizer as! UILongPressGestureRecognizer
        let state = longPress.state
        let locationInView = longPress.location(in: self.tableView)
        var indexPath = self.tableView.indexPathForRow(at: locationInView)
        
        struct My {
            static var cellSnapshot : UIView? = nil
        }
        struct Path {
            static var initialIndexPath : IndexPath? = nil
        }
        
        switch state {
            case UIGestureRecognizerState.began:
                if indexPath != nil {
                    Path.initialIndexPath = indexPath as IndexPath?
                    let cell = self.tableView.cellForRow(at: indexPath!) as UITableViewCell!
                    My.cellSnapshot = snapshopOfCell(inputView: cell!)
                    var center = cell?.center
                    My.cellSnapshot!.center = center!
                    My.cellSnapshot!.alpha = 0.0
                    self.tableView.addSubview(My.cellSnapshot!)
                    
                    UIView.animate(withDuration: 0.25,
                        animations: { () -> Void in
                            center?.y = locationInView.y
                            My.cellSnapshot!.center = center!
                            My.cellSnapshot!.transform = CGAffineTransform(scaleX: 1.05, y: 1.05)
                            My.cellSnapshot!.alpha = 0.98
                            cell?.alpha = 0.0
                        
                        }, completion: { (finished) -> Void in
                            if finished {
                                cell?.isHidden = true
                            }
                        }
                    )
                }
            case UIGestureRecognizerState.changed:
                var center = My.cellSnapshot?.center
                if center != nil {
                    center?.y = locationInView.y
                    My.cellSnapshot!.center = center!
                    if ((indexPath != nil) && (indexPath != Path.initialIndexPath)) {
                        swap(&rotationGroups[indexPath!.row], &rotationGroups[Path.initialIndexPath!.row])
                        self.tableView.moveRow(at: Path.initialIndexPath!, to: indexPath!)
                        Path.initialIndexPath = indexPath
                    }
                }
            
            default:
                if let initialPath = Path.initialIndexPath {
                    let cell = self.tableView.cellForRow(at: initialPath) as UITableViewCell!
                    cell?.isHidden = false
                    cell?.alpha = 0.0
                    UIView.animate(withDuration: 0.25, animations: { () -> Void in
                        My.cellSnapshot!.center = (cell?.center)!
                        My.cellSnapshot!.transform = CGAffineTransform.identity
                        My.cellSnapshot!.alpha = 0.0
                        cell?.alpha = 1.0
                        }, completion: { (finished) -> Void in
                            if finished {
                                Path.initialIndexPath = nil
                                My.cellSnapshot!.removeFromSuperview()
                                My.cellSnapshot = nil
                            }
                    })
                }
            
        }
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
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to toIndexPath: IndexPath) {
        let rotationGroup = rotationGroups[fromIndexPath.row]
        rotationGroups.remove(at: fromIndexPath.row)
        rotationGroups.insert(rotationGroup, at: toIndexPath.row)
    }
    */
    

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
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
