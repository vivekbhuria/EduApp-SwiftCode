//
//  ViewController.swift
//  Drawing App
//
//  Created by Vivek on 11/11/14.
//  Copyright (c) 2014 Vivek. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var moveToController=UIButton();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
//        var image = UIImage(named: "playBtn_iPad.png") as UIImage!
        var buttonimage = UIImage(named: "playBtn_iPad.png")  as UIImage!
        
        moveToController.layer.cornerRadius = 25.0;
        moveToController.layer.shadowRadius = 25.0;
        moveToController.frame = CGRectMake(384, 353, 256, 256)
        moveToController.layer.shadowColor = UIColor.blackColor().CGColor;
        moveToController.layer.shadowOffset = CGSizeMake(5.0, 5.0);
        moveToController.layer.shadowOpacity = 1.0;
        moveToController.layer.masksToBounds = false;
        moveToController.setImage(buttonimage, forState: .Normal)
        moveToController.addTarget(self, action: "buttonAction:", forControlEvents: UIControlEvents.TouchUpInside)
        
        var pulseAnimation:(CABasicAnimation) = CABasicAnimation()
        pulseAnimation.keyPath="transform.scale";
        pulseAnimation.duration = 1.0;
        pulseAnimation.toValue = 0.9;
        pulseAnimation.autoreverses = true;
        pulseAnimation.repeatCount = FLT_MAX;
        
        moveToController.layer.addAnimation(pulseAnimation, forKey: nil)
        
        self.view.addSubview(moveToController);
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func buttonAction(sender:UIButton!)
    {
        self.performSegueWithIdentifier("moveToCanvas", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!)
    {
        if segue.identifier == "moveToCanvas"
        {
            
        }
    }
}

