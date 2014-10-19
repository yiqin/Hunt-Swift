//
//  ListViewController.swift
//  hunt
//
//  Created by Yi Qin on 10/16/14.
//  Copyright (c) 2014 Yi Qin. All rights reserved.
//

import Foundation
import UIKit

class ListViewController : UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
//    var itemList = [ScavengerHuntItem]()
//    var initItem = ScavengerHuntItem(name: "Yi Qin")
    var itemsManager = ItemsManager();
    
    //initialize the thing appeared on view
    override func viewDidLoad() {
        itemsManager.items += [ScavengerHuntItem]()
        
    }
    
    //override means the super class aleady has it, but want to over write
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemsManager.items.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ListViewCell") as UITableViewCell
        let item = itemsManager.items[indexPath.row]
        cell.textLabel!.text = item.name
        if item.isComplete {
            cell.accessoryType = .Checkmark
            cell.imageView!.image = item.photo
        } else {
            cell.accessoryType = .None
            cell.imageView?.image = nil
        }
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let imagePicker = UIImagePickerController()
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera) {
            imagePicker.sourceType = .Camera
        } else {
            imagePicker.sourceType = .PhotoLibrary
        }
        
        imagePicker.delegate = self
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        let indexPath = tableView.indexPathForSelectedRow()!
        let selectedItem = itemsManager.items[indexPath.row]
        
        let photo = info[UIImagePickerControllerOriginalImage] as UIImage
        selectedItem.photo = photo
        
        //save new image
        itemsManager.save()
        
        dismissViewControllerAnimated(true, completion: {
            self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
            self.tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
        })
    }
    
    @IBAction func unwindToList(segue: UIStoryboardSegue){
        if segue.identifier == "DoneItem" {
            let addItemController = segue.sourceViewController as ViewController
            if let newItem = addItemController.createdItem {
                itemsManager.items += [newItem]
                
                //save new created items
                itemsManager.save()
                let indexPath = NSIndexPath(forRow: itemsManager.items.count-1, inSection: 0)
                tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
            }
        }
        
    }
}