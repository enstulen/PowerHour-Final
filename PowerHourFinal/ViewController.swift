//
//  ViewController.swift
//  PowerHourFinal
//
//  Created by Morten Stulen on 23.01.15.
//  Copyright (c) 2015 Morten Stulen. All rights reserved.
//

import UIKit

class ViewController: UIViewController, SRFSurfboardDelegate {

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        var accordion = AccordionView(frame: CGRect(x: 0, y: 0, width: UIScreen.mainScreen().bounds.size.width, height: UIScreen.mainScreen().bounds.size.height))
        
        self.view.addSubview(accordion)

        self.view.backgroundColor = UIColor(red: 0.925, green: 0.941, blue: 0.945, alpha: 1)
        
        var easyHeader:UIButton = UIButton(frame: CGRect(x: 0, y: 0, width: 0, height: 100))
        easyHeader.setTitle("Without challenges", forState: UIControlState.Normal)
        easyHeader.backgroundColor = UIColor(red: 0.086, green: 0.627, blue: 0.522, alpha: 1)
        //easyHeader.backgroundColor = UIColor(red:0.1, green:0.74, blue:0.61, alpha:1)
        var easyView:UIView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 200))
        easyView.backgroundColor = UIColor(red: 0.102, green: 0.737, blue: 0.612, alpha: 1)
        
        //Play button
        var easyPlayButton:UIButton = UIButton(frame: CGRect(x: UIScreen.mainScreen().bounds.size.width/2 - 100, y: 75, width: 200, height: 50))
        easyPlayButton.setTitle("Play", forState: UIControlState.Normal)
        easyPlayButton.backgroundColor = UIColor(red: 0.906, green: 0.298, blue: 0.235, alpha: 1)
        easyPlayButton.addTarget(self, action: "easyPlay", forControlEvents: UIControlEvents.TouchDown)
        easyView.addSubview(easyPlayButton)
        
        var mediumHeader:UIButton = UIButton(frame: CGRect(x: 0, y: 0, width: 0, height: 100))
        mediumHeader.setTitle("With challenges", forState: UIControlState.Normal)
        mediumHeader.backgroundColor = UIColor(red:0.56, green:0.29, blue:0.67, alpha:1)
        
        var mediumView:UIView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 200))
        mediumView.backgroundColor = UIColor(red: 0.102, green: 0.737, blue: 0.612, alpha: 1)
        
        var howToPlayHeader:UIButton = UIButton(frame: CGRect(x: 0, y: 0, width: 0, height: 100))
        howToPlayHeader.setTitle("How to play", forState: UIControlState.Normal)
        howToPlayHeader.backgroundColor = UIColor(red:0.82, green:0.33, blue:0.1, alpha:1)
        
        var howToPlayView:UIView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 200))
        howToPlayView.backgroundColor = UIColor(red: 0.102, green: 0.737, blue: 0.612, alpha: 1)
        
        //How to play button
        var howToPlayButton:UIButton = UIButton(frame: CGRect(x: UIScreen.mainScreen().bounds.size.width/2 - 100, y: 75, width: 200, height: 50))
        howToPlayButton.setTitle("How to Play", forState: UIControlState.Normal)
        howToPlayButton.backgroundColor = UIColor(red: 0.906, green: 0.298, blue: 0.235, alpha: 1)
        howToPlayButton.addTarget(self, action: "howToPlay", forControlEvents: UIControlEvents.TouchDown)
        howToPlayView.addSubview(howToPlayButton)
        
        accordion.addHeader(easyHeader, withView: easyView)
        accordion.addHeader(mediumHeader, withView: mediumView)
        accordion.addHeader(howToPlayHeader, withView: howToPlayView)
        accordion.setNeedsLayout()
        
        accordion.allowsMultipleSelection = false
        accordion.allowsEmptySelection = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
    func easyPlay (){
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
    func surfboard(surfboard: SRFSurfboardViewController!, didTapButtonAtIndexPath indexPath: NSIndexPath!) {
        surfboard.dismissViewControllerAnimated(true, completion: nil)
    }

}

