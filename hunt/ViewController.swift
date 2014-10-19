//
//  ViewController.swift
//  hunt
//
//  Created by Yi Qin on 10/16/14.
//  Copyright (c) 2014 Yi Qin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var createdItem: ScavengerHuntItem?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //cancel button with animation
    @IBAction func cancel(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }

    //link from textfield
    @IBOutlet weak var textField: UITextField!
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "DoneItem" {
            if let name = textField.text {
                if !name.isEmpty {
                    createdItem = ScavengerHuntItem(name: name)
                }
            }
        }
    }
}

