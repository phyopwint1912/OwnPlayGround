//
//  DetailViewController.swift
//  OwnPlayground
//
//  Created by Phyo Pwint  on 26/4/16.
//  Copyright © 2016 Phyo Pwint . All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    var detailWord: String!
    var detailType: String!
    var detailDesc: String!
    
    @IBOutlet weak var wordText: UILabel!
    @IBOutlet weak var typeText: UILabel!
    @IBOutlet weak var descText: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        wordText.text! = detailWord
        typeText.text! = detailType
        descText.text! = detailDesc
        self.title = detailWord
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
