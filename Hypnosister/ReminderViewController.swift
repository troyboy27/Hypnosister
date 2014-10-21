//
//  ReminderViewController.swift
//  Hypnosister
//
//  Created by Troy Abel on 10/21/14.
//  Copyright (c) 2014 Troy Abel. All rights reserved.
//

import UIKit

class ReminderViewController: UIViewController {
    
    //Set up the tabbed controller
    override init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        // Set the tab bar item's title
        tabBarItem.title = "Reminder"
        // Put an image on the tab bar item
        tabBarItem.image = UIImage(named: "Time.png")
    }
    convenience override init() {
        self.init(nibName: "ReminderViewController", bundle: nil)
    }
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBAction func addReminder(sender: AnyObject) {
        let date = datePicker.date
        println("Setting a reminder for \(date)")
        
        let note = UILocalNotification()
        note.alertBody = "Hypnotize me!"
        note.fireDate = date
        UIApplication.sharedApplication().scheduleLocalNotification(note)
    }
    
    override func viewDidLoad() {
    // Always call the super implementation of viewDidLoad
    super.viewDidLoad()
    println("ReminderViewController loaded its view.")
    }
    
    //only allow time in the future
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        datePicker.minimumDate = NSDate(timeIntervalSinceNow: 60)
    }
    
}
