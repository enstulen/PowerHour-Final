//
//  TimerViewController.swift
//  PowerHourFinal
//
//  Created by Morten Stulen on 23.01.15.
//  Copyright (c) 2015 Morten Stulen. All rights reserved.
//

import UIKit


class TimerViewController: UIViewController, SFSwiftNotificationProtocol {
    var previousNumber = 59
    var firstRun:Bool = true
    var token: dispatch_once_t = 0
    var endDate:NSDate = NSDate()
    var timer:NSTimer = NSTimer()
    var notifyFrame:CGRect?
    var notifyView:SFSwiftNotification?
    var withChallenge:Int?
    var i = 0;

    

    //Timers
    @IBOutlet weak var minuteTimerControl: DDHTimerControl!
    @IBOutlet weak var secondTimerControl: DDHTimerControl!
    
    //Label
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var drunkLabel: UILabel!

    //Buttons
    @IBOutlet weak var challengeButton: SHFlatButton!
    @IBOutlet weak var truthButton: SHFlatButton!
    @IBOutlet weak var exitButton: UIButton!

    //Button actions
    @IBAction func challengeButtonPressed(sender: SHFlatButton) {
        
        
        if(i >= challengeArray.count){
            i = 0
        }

        var challengeAlert:MLAlertView = MLAlertView(title: "Normal challenge", message: challengeArray[randomNumberChallengeArray[i]], cancelButtonTitle: "Got it", otherButtonTitles: nil)
        challengeAlert.titleBackgroundColor = UIColor(red:0.1, green:0.74, blue:0.61, alpha:1)
        challengeAlert.titleForegroundColor = UIColor.whiteColor()
        challengeAlert.highlightedCancelButtonBackgroundColor = UIColor(red:0.1, green:0.74, blue:0.61, alpha:1)
        challengeAlert.highlightedCancelButtonForegroundColor = UIColor.whiteColor()
        challengeAlert.show()
        self.textLabel.text = "Give the phone to the next player."
        i++
        
    }
    @IBAction func truthButtonPressed(sender: SHFlatButton) {
        
        if(i >= truthArray.count - 1){
            i = 0
        }
        
        var truthAlert:MLAlertView = MLAlertView(title: "Truth", message: truthArray[randomNumberTruthArray[i]], cancelButtonTitle: "Got it", otherButtonTitles: nil)
        //truthAlert.titleForegroundColor = UIColor.orangeColor()
        truthAlert.titleBackgroundColor = UIColor(red:0.1, green:0.74, blue:0.61, alpha:1)
        truthAlert.titleForegroundColor = UIColor.whiteColor()
        truthAlert.highlightedCancelButtonBackgroundColor = UIColor(red:0.1, green:0.74, blue:0.61, alpha:1)
        truthAlert.highlightedCancelButtonForegroundColor = UIColor.whiteColor()
        truthAlert.show()
        self.textLabel.text = "Give the phone to the next player."
        i++

    }
    
    @IBAction func exitButtonPressed(sender: UIButton) {
        var exitAlert:MLAlertView = MLAlertView(title: "Exit", message: "Do you really want to quit?", cancelButtonTitle: "No", otherButtonTitles: ["Yes"], usingBlockWhenTapButton:
            { (alertView, buttonIndex) in
                alertView.dismiss()
                UIApplication.sharedApplication().cancelAllLocalNotifications()
                self.timer.invalidate()
                self.dismissViewControllerAnimated(true, completion: nil)
            }
        )
        
        exitAlert.titleBackgroundColor = UIColor(red:0.1, green:0.74, blue:0.61, alpha:1)
        exitAlert.highlightedCancelButtonBackgroundColor = UIColor(red:0.1, green:0.74, blue:0.61, alpha:1)
        exitAlert.highlightedCancelButtonForegroundColor = UIColor.whiteColor()
        exitAlert.highlightedButtonBackgroundColor = UIColor(red:0.1, green:0.74, blue:0.61, alpha:1)
        exitAlert.highlightedButtonForegroundColor = UIColor.whiteColor()

        
        exitAlert.show()
        
    }
    
    
    //VIEW DID LOAD
    override func viewDidLoad() {

        
        if firstRun{
            self.timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: "changeTimer", userInfo: nil, repeats: true)
            firstRun = false
        }
        
        
        //View
        self.view.backgroundColor = UIColor(red: 0.925, green: 0.941, blue: 0.945, alpha: 1)
        
        //Textlabels
        textLabel.textColor = UIColor.whiteColor()
        textLabel.backgroundColor = UIColor(red:0.1, green:0.74, blue:0.61, alpha:1)
        
//        drunkLabel.textColor = UIColor(red:0.1, green:0.74, blue:0.61, alpha:1)
//        drunkLabel.text = "sober"

        //Exitbutton
        exitButton.backgroundColor = UIColor(red:0.1, green:0.74, blue:0.61, alpha:1)
        exitButton.titleLabel?.textColor = UIColor.whiteColor()
        
        //Timers
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
        
      
        endDate = NSDate(timeIntervalSinceNow: 60*60)
        
        //Notification in app
        
        notifyFrame = CGRectMake(0, 0, CGRectGetMaxX(self.view.frame), 50)
        notifyView = SFSwiftNotification(frame: CGRect(x: 0, y: 0, width: CGRectGetMaxX(self.view.frame), height: 50), title: nil, animationType: AnimationType.AnimationTypeBounce, direction: Direction.TopToBottom, delegate: self)
        notifyView!.backgroundColor = UIColor.orangeColor()
        notifyView!.label.textColor = UIColor.whiteColor()
        notifyView!.label.text = "DRINK!"
        self.view.addSubview(notifyView!)
        
        
        //Notifications
        //println(secondTimerControl.minutesOrSeconds)
        
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
        self.secondTimerControl.minutesOrSeconds = NSInteger((timeInterval)%60)
        
        if secondTimerControl.minutesOrSeconds == previousNumber{
            //println(secondTimerControl.minutesOrSeconds)
            if self.previousNumber == 0{
                self.previousNumber = 59
                self.view.bringSubviewToFront(notifyView!)
                self.notifyView!.animate(notifyFrame!, delay: 3)
            }
            self.previousNumber -= 1
        }
    }
    
    
    func didNotifyFinishedAnimation(results: Bool) {
    }
    
    func didTapNotification() {
        
        let tapAlert = UIAlertController(title: "SFSwiftNotification",
            message: "You just tapped the notificatoion",
            preferredStyle: UIAlertControllerStyle.Alert)
        tapAlert.addAction(UIAlertAction(title: "OK", style: .Destructive, handler: nil))
        self.presentViewController(tapAlert, animated: true, completion: nil)
    }
    
    func setWithChallenges(challengeNumber: Int){
        if (challengeNumber == 0){
             self.withChallenge = 0
        }
        else{
             self.withChallenge = 1
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        if withChallenge == 0{
            challengeButton.hidden = true
            truthButton.hidden = true
        }
        else{
            challengeButton.hidden = false
            truthButton.hidden = false
        }
    }


    
}

