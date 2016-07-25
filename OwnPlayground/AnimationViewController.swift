//
//  AnimationViewController.swift
//  OwnPlayground
//
//  Created by Phyo Pwint  on 10/5/16.
//  Copyright © 2016 Phyo Pwint . All rights reserved.
//

import UIKit
import MapKit

class AnimationViewController: UIViewController {
    @IBOutlet var menuButton:UIBarButtonItem!
    @IBOutlet weak var fish: UIImageView!
    @IBOutlet weak var container: UIView!
    
    let redSquare = UIView()
    let blueSquare = UIView()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Implement the Slider navigation bar.
        if revealViewController() != nil {
            menuButton.target = revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            
            //Combine the Container and Red Blue View
            self.redSquare.frame = container.frame
            self.blueSquare.frame = redSquare.frame
            self.redSquare.backgroundColor = UIColor.redColor()
            self.blueSquare.backgroundColor = UIColor.blueColor()
            self.container.addSubview(self.redSquare)

        }
        // Do any additional setup after loading the view.
    }
    @IBAction func doAnimate(sender: AnyObject) {
        var views : (frontView: UIView, backView: UIView)
        
        if((self.redSquare.superview) != nil){
            views = (frontView: self.redSquare, backView: self.blueSquare)
        }
        else {
            views = (frontView: self.blueSquare, backView: self.redSquare)
        }
        
        let transitionOptions = UIViewAnimationOptions.TransitionCrossDissolve
        UIView.transitionFromView(views.frontView, toView: views.backView, duration: 1.0, options: transitionOptions, completion: nil)
        
        
        //adding fish animation
        // angles in iOS are measured as radians PI is 180 degrees so PI × 2 is 360 degrees
        let fullRotation = CGFloat(M_PI * 2)

        let duration = 2.0
        let delay = 0.0
        let options = UIViewKeyframeAnimationOptions.CalculationModeLinear
        
        UIView.animateKeyframesWithDuration(duration, delay: delay, options: options, animations: {
            
            UIView.addKeyframeWithRelativeStartTime(0, relativeDuration: 1/3, animations: {
                self.fish.transform = CGAffineTransformMakeRotation(1/3 * fullRotation)
            })
            UIView.addKeyframeWithRelativeStartTime(1/3, relativeDuration: 1/3, animations: {
                self.fish.transform = CGAffineTransformMakeRotation(2/3 * fullRotation)
            })
            UIView.addKeyframeWithRelativeStartTime(2/3, relativeDuration: 1/3, animations: {
                self.fish.transform = CGAffineTransformMakeRotation(3/3 * fullRotation)
             })
            
            }, completion: nil)
        }
    


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
