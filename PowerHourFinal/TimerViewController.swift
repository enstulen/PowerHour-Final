//
//  TimerViewController.swift
//  PowerHourFinal
//
//  Created by Morten Stulen on 23.01.15.
//  Copyright (c) 2015 Morten Stulen. All rights reserved.
//

import UIKit


class TimerViewController: UIViewController{
    var endDate:NSDate = NSDate()

    //Timers
    @IBOutlet weak var minuteTimerControl: DDHTimerControl!
    @IBOutlet weak var secondTimerControl: DDHTimerControl!
    
    //Buttons
    @IBOutlet weak var hardcoreChallengeButton: SHFlatButton!
    @IBOutlet weak var challengeButton: SHFlatButton!
    @IBOutlet weak var truthButton: SHFlatButton!
    @IBOutlet weak var exitButton: UIButton!

    //Button actions
    @IBAction func hardcoreChallengePressed(sender: SHFlatButton) {
        var hardcoreAlert:MLAlertView = MLAlertView(title: "Hard challenge", message: "Suck the dick of the person next to you for 5 seconds. Sed ante justo, tincidunt fringilla neque in, facilisis consequat tellus. Mauris maximus facilisis mi nec rutrum. ", cancelButtonTitle: "Got it", otherButtonTitles: nil)
        hardcoreAlert.titleBackgroundColor = UIColor(red:0.1, green:0.74, blue:0.61, alpha:1)
        hardcoreAlert.show()
        
    }
    @IBAction func challengeButtonPressed(sender: SHFlatButton) {
        var challengeAlert:MLAlertView = MLAlertView(title: "Normal challenge", message: "Sed ante justo, tincidunt fringilla neque in, facilisis consequat tellus. Mauris maximus facilisis mi nec rutrum. Cras fermentum in odio ac vulputate. ", cancelButtonTitle: "Got it", otherButtonTitles: nil)
        challengeAlert.titleBackgroundColor = UIColor(red:0.1, green:0.74, blue:0.61, alpha:1)
        challengeAlert.show()
        
    }
    @IBAction func truthButtonPressed(sender: SHFlatButton) {
        var truthAlert:MLAlertView = MLAlertView(title: "Truth", message: "Sed ante justo, tincidunt fringilla neque in, facilisis consequat tellus. Mauris maximus facilisis mi nec rutrum. Cras fermentum in odio ac vulputate.", cancelButtonTitle: "Got it", otherButtonTitles: nil)
        truthAlert.titleBackgroundColor = UIColor(red:0.1, green:0.74, blue:0.61, alpha:1)
        truthAlert.show()
        
    }
    
    @IBAction func exitButtonPressed(sender: UIButton) {
        performSegueWithIdentifier("exitSegue", sender: self)
        UIApplication.sharedApplication().cancelAllLocalNotifications()
        
    }
    
    
    //VIEW DID LOAD
    override func viewDidLoad() {
        
        exitButton.backgroundColor = UIColor(red:0.1, green:0.74, blue:0.61, alpha:1)
        exitButton.titleLabel?.textColor = UIColor.whiteColor()
        
        self.minuteTimerControl.type = DDHTimerType.EqualElements
        self.minuteTimerControl.color = UIColor.orangeColor()
        self.minuteTimerControl.highlightColor = UIColor.redColor()
        self.minuteTimerControl.minutesOrSeconds = 59
        self.minuteTimerControl.titleLabel.text = "min"
        self.minuteTimerControl.userInteractionEnabled = false
        
        self.secondTimerControl.type = DDHTimerType.Solid
        self.secondTimerControl.color = UIColor.orangeColor()
        self.secondTimerControl.highlightColor = UIColor.redColor()
        self.secondTimerControl.minutesOrSeconds = 59
        self.secondTimerControl.titleLabel.text = "sec"
        self.secondTimerControl.userInteractionEnabled = false
        
        
        NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: "changeTimer", userInfo: nil, repeats: true)
        
        endDate = NSDate(timeIntervalSinceNow: 60*60)
        
        
        //Notifications
        println(secondTimerControl.minutesOrSeconds)
        
        var localNotification:UILocalNotification = UILocalNotification()
        localNotification.alertAction = "DRINK!"
        localNotification.alertBody = "DRINK!"
        localNotification.fireDate = NSDate(timeIntervalSinceNow: NSTimeInterval(secondTimerControl.minutesOrSeconds))
        //localNotification.fireDate = NSDate(timeIntervalSinceNow: 5)
        localNotification.repeatInterval = NSCalendarUnit.MinuteCalendarUnit
        
        UIApplication.sharedApplication().scheduleLocalNotification(localNotification)
        
        //println(UIApplication.sharedApplication().scheduledLocalNotifications)
    }
    
    func changeTimer() {
        var timeInterval:NSTimeInterval = self.endDate.timeIntervalSinceNow
        
        self.minuteTimerControl.minutesOrSeconds = NSInteger(timeInterval/60.0)
        self.secondTimerControl.minutesOrSeconds = NSInteger(timeInterval%60)
//        println(secondTimerControl.minutesOrSeconds)
    }
    
    func valueChanged(sender: DDHTimerControl){
        println(sender.minutesOrSeconds)
    }
    

    
}
