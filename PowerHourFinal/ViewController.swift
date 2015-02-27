//
//  ViewController.swift
//  PowerHourFinal
//
//  Created by Morten Stulen on 23.01.15.
//  Copyright (c) 2015 Morten Stulen. All rights reserved.
//

import UIKit

class ViewController: UIViewController, SRFSurfboardDelegate {
    
    var withChallenge:Int?

    override func viewDidLoad() {
        
        super.viewDidLoad()
                
        let screenWidth = UIScreen.mainScreen().bounds.size.width
        let screenHeight = UIScreen.mainScreen().bounds.size.height
        
        var accordion = AccordionView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight))
        
        self.view.addSubview(accordion)

        self.view.backgroundColor = UIColor(red: 0.925, green: 0.941, blue: 0.945, alpha: 1)
        
        
        //With Challenges
        var withChallengeHeader:UIButton = UIButton(frame: CGRect(x: 0, y: 0, width: 0, height: screenHeight/5))
        withChallengeHeader.setTitle("With challenges", forState: UIControlState.Normal)
        withChallengeHeader.backgroundColor = UIColor(red: 0.086, green: 0.627, blue: 0.522, alpha: 1)
        var withChallengeView:UIView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: (screenHeight/5)*2))
        withChallengeView.backgroundColor = UIColor(red: 0.102, green: 0.737, blue: 0.612, alpha: 1)
        
        var withChallengeButton:UIButton = UIButton(frame: CGRect(x: screenWidth/2 - 100, y: 75, width: 200, height: 50))
        withChallengeButton.setTitle("Play", forState: UIControlState.Normal)
        withChallengeButton.backgroundColor = UIColor(red: 0.906, green: 0.298, blue: 0.235, alpha: 1)
        withChallengeButton.addTarget(self, action: "withChallengePlay", forControlEvents: UIControlEvents.TouchDown)
        withChallengeView.addSubview(withChallengeButton)
        
        
        //Without challenges
        var withoutChallengesHeader:UIButton = UIButton(frame: CGRect(x: 0, y: 0, width: 0, height: screenHeight/5+1))
        withoutChallengesHeader.setTitle("Without challenges", forState: UIControlState.Normal)
        withoutChallengesHeader.backgroundColor = UIColor(red:0.56, green:0.29, blue:0.67, alpha:1)
        
        var withoutChallengesView:UIView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: (screenHeight/5)*2))
        withoutChallengesView.backgroundColor = UIColor(red:0.61, green:0.35, blue:0.71, alpha:1)
        
        var withoutChallengesButton:UIButton = UIButton(frame: CGRect(x: screenWidth/2 - 100, y: 75, width: 200, height: 50))
        withoutChallengesButton.setTitle("Play", forState: UIControlState.Normal)
        withoutChallengesButton.backgroundColor = UIColor(red: 0.906, green: 0.298, blue: 0.235, alpha: 1)
        withoutChallengesButton.addTarget(self, action: "withoutChallengePlay", forControlEvents: UIControlEvents.TouchDown)
        withoutChallengesView.addSubview(withoutChallengesButton)
        
        
        var howToPlayHeader:UIButton = UIButton(frame: CGRect(x: 0, y: 0, width: 0, height: screenHeight/5+2))
        howToPlayHeader.setTitle("How to play", forState: UIControlState.Normal)
        howToPlayHeader.backgroundColor = UIColor(red:0.82, green:0.33, blue:0.1, alpha:1)
        
        var howToPlayView:UIView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: (screenHeight/5)*2+3))
        howToPlayView.backgroundColor = UIColor(red:0.9, green:0.49, blue:0.13, alpha:1)
        
        //How to play button
        var howToPlayButton:UIButton = UIButton(frame: CGRect(x: screenWidth/2 - 100, y: 25, width: 200, height: 50))
        howToPlayButton.setTitle("Rules", forState: UIControlState.Normal)
        howToPlayButton.backgroundColor = UIColor(red: 0.906, green: 0.298, blue: 0.235, alpha: 1)
        howToPlayButton.addTarget(self, action: "howToPlay", forControlEvents: UIControlEvents.TouchDown)
        howToPlayView.addSubview(howToPlayButton)
        
        //Settings button
        var settingsButton:UIButton = UIButton(frame: CGRect(x: screenWidth/2 - 100, y: 100, width: 200, height: 50))
        settingsButton.setTitle("Settings", forState: UIControlState.Normal)
        settingsButton.backgroundColor = UIColor(red: 0.906, green: 0.298, blue: 0.235, alpha: 1)
        settingsButton.addTarget(self, action: "settings", forControlEvents: UIControlEvents.TouchDown)
        howToPlayView.addSubview(settingsButton)
        
        accordion.addHeader(withChallengeHeader, withView: withChallengeView)
        accordion.addHeader(withoutChallengesHeader, withView: withoutChallengesView)
        accordion.addHeader(howToPlayHeader, withView: howToPlayView)
        accordion.setNeedsLayout()
        
        accordion.allowsMultipleSelection = false
        accordion.allowsEmptySelection = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
    func withChallengePlay (){
        self.withChallenge = 1
        performSegueWithIdentifier("playSegue", sender: self)
    }
    func withoutChallengePlay (){
        self.withChallenge = 0
        performSegueWithIdentifier("playSegue", sender: self)
    }
    func howToPlay (){
        var path = NSBundle.mainBundle().pathForResource("panels", ofType: "json")
        var panels = SRFSurfboardViewController.panelsFromConfigurationAtPath(path)
        var surfBoard:SRFSurfboardViewController = SRFSurfboardViewController(pathToConfiguration: path)
    
        surfBoard.setPanels(panels)
        surfBoard.delegate = self
        surfBoard.backgroundColor = UIColor(red: 0.086, green: 0.627, blue: 0.522, alpha: 1)
        
        presentViewController(surfBoard, animated: true, completion: nil)
    }
    
    func settings (){
        performSegueWithIdentifier("settings", sender: self)
    }
    func surfboard(surfboard: SRFSurfboardViewController!, didTapButtonAtIndexPath indexPath: NSIndexPath!) {
        surfboard.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if (segue.identifier == "playSegue") {
            let timerViewController = segue.destinationViewController as TimerViewController
            if (self.withChallenge == 0){
                timerViewController.setWithChallenges(0)
            }
            else{
                timerViewController.setWithChallenges(1)

            }
        }
    }


}

