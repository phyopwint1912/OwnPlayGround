//
//  FaceViewController.swift
//  OwnPlayground
//
//  Created by Phyo Pwint  on 3/5/16.
//  Copyright © 2016 Phyo Pwint . All rights reserved.
//

import UIKit

class FaceViewController: UIViewController {
    
    @IBAction func toggleEyes(recognizer: UITapGestureRecognizer) {
        if recognizer.state == .Ended {
            switch expression.eyes {
            case .Open:
                expression.eyes = .Closed
            case .Closed:
                expression.eyes = .Open
            case .Squinting: break
                
            }
        }
    
    }
    @IBOutlet weak var faceView: FaceView!{
        didSet {
            faceView.addGestureRecognizer(UIPinchGestureRecognizer(target: faceView, action: #selector(FaceView.changeScale(_:))
            ))
            let happierSwipeGestureRecognizer = UISwipeGestureRecognizer(target: self,action: #selector(FaceViewController.increaseHappiness))
            happierSwipeGestureRecognizer.direction = .Up
            faceView.addGestureRecognizer(happierSwipeGestureRecognizer)
            
            let saddedSwipeGestureRecognizer = UISwipeGestureRecognizer(target: self,action: #selector(FaceViewController.decreaseHappiness))
            saddedSwipeGestureRecognizer.direction = .Down
            faceView.addGestureRecognizer(saddedSwipeGestureRecognizer)
            
            updateUI()
        }
    }

    func increaseHappiness() {
        expression.mouth = expression.mouth.happierMouth()
    }
    
    func decreaseHappiness() {
        expression.mouth = expression.mouth.saddedMouth()
    }
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    var expression = FaceExpression(eyes: .Closed, eyeBrows: .Normal, mouth: .Smile) {
        didSet {
            updateUI()
        }
    }
    
    private var mouthCurvatures = [FaceExpression.Mouth.Frown: -1.0,.Grin: 0.5,.Smile:1.0,.Smirk:-0.5,.Neutral:0.0]
    
    private var eyeBrowTilts = [FaceExpression.EyeBrows.Relaxed: 0.5,.Furrowed:-0.5,.Normal:0.0]
    private func updateUI() {
        switch expression.eyes {
        case .Open: faceView.eyesOpen = true
        case .Closed: faceView.eyesOpen = false
        case .Squinting: faceView.eyesOpen = false
        }
        faceView.mouthCurvature = mouthCurvatures[expression.mouth] ?? 0.0
        faceView.eyeBrowTilt = eyeBrowTilts[expression.eyeBrows] ?? 0.0
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Drawing"
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
