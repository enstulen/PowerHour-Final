//
//  SettingsViewController.swift
//  PowerHourFinal
//
//  Created by Morten Stulen on 27.01.15.
//  Copyright (c) 2015 Morten Stulen. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController, BFPaperCheckboxDelegate {

    @IBOutlet weak var checkBox: BFPaperCheckbox!
    @IBAction func extiButton(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewDidLoad() {
        self.checkBox.tag = 1001;
        self.checkBox.delegate = self
        

//        
//        // Set up first checkbox label:
//        self.paperCheckboxLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 31)];
//        self.paperCheckboxLabel.text = @"BFPaperCheckbox [OFF]";
//        self.paperCheckboxLabel.backgroundColor = [UIColor clearColor];
//        self.paperCheckboxLabel.center = CGPointMake(self.paperCheckbox.center.x + ((2 * self.paperCheckboxLabel.frame.size.width) / 3), self.paperCheckbox.center.y);
//        [self.view addSubview:self.paperCheckboxLabel];
    }
}
