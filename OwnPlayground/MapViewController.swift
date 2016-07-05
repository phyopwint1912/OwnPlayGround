//
//  MapViewController.swift
//  OwnPlayground
//
//  Created by Phyo Pwint  on 10/5/16.
//  Copyright © 2016 Phyo Pwint . All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
   @IBOutlet var menuButton:UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Implement the Slider navigation bar.
        if revealViewController() != nil {
            menuButton.target = revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        // Do any additional setup after loading the view.
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
