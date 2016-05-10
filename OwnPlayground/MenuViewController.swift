//
//  MenuViewController.swift
//  OwnPlayground
//
//  Created by Phyo Pwint  on 29/4/16.
//  Copyright © 2016 Phyo Pwint . All rights reserved.
//

import UIKit

class MenuViewController: UITableViewController {
    
    @IBOutlet weak var logoutLabel: UILabel!
    @IBOutlet weak var userName: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let defaults = NSUserDefaults.standardUserDefaults()
        if let name = defaults.stringForKey("userNameKey") {
            userName.text = name
        }
        _ = UITapGestureRecognizer(target: self, action: #selector(MenuViewController.logOutPlay(_:)))
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func logOutPlay(sender:UITapGestureRecognizer){
        self.performSegueWithIdentifier("loginView", sender: self)
    }
}
