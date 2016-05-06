//
//  LoginViewController.swift
//  OwnPlayground
//
//  Created by Phyo Pwint  on 6/5/16.
//  Copyright © 2016 Phyo Pwint . All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var btnSignIn: UIButton!
    @IBOutlet weak var txtUsername: UITextField!
    let usernameKey = "ppt"
    let passwordKey = "ppt"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        assignBackground()
        designingCompnent()
    }
    
    func printMessage(msgTitle: String, msg:String) {
        let alertPopUp:UIAlertController = UIAlertController(title: msgTitle, message: msg, preferredStyle: UIAlertControllerStyle.Alert);
        
        let cancelAction = UIAlertAction(title: "OK", style: .Cancel) {
            action -> Void in }
        
        alertPopUp.addAction(cancelAction);
        
        self.presentViewController(alertPopUp, animated: true, completion: nil)
        
    }
    
    
    func checkLogin(username: String, password: String ) -> Bool {
        if password == MyKeychainWrapper.myObjectForKey("v_Data") as? String &&
            username == NSUserDefaults.standardUserDefaults().valueForKey("username") as? String {
            return true
        } else {
            return false
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    let MyKeychainWrapper = KeychainWrapper()
    let createLoginButtonTag = 0
    let loginButtonTag = 1
    
    @IBAction func makeLogin(sender: UIButton) {
        if(txtPassword.text == "" && txtUsername.text == "")
        {
            printMessage("Login Problem", msg: "UserName or Password Fill")
        }
        
        txtUsername.resignFirstResponder()
        txtPassword.resignFirstResponder()
        
        if sender.tag == createLoginButtonTag {
            
            let hasLoginKey = NSUserDefaults.standardUserDefaults().boolForKey("hasLoginKey")
            if hasLoginKey == false {
                NSUserDefaults.standardUserDefaults().setValue(self.txtUsername.text, forKey: "username")
            }
            
            MyKeychainWrapper.mySetObject(txtPassword.text, forKey:kSecValueData)
            MyKeychainWrapper.writeToKeychain()
            NSUserDefaults.standardUserDefaults().setBool(true, forKey: "hasLoginKey")
            NSUserDefaults.standardUserDefaults().synchronize()
            btnSignIn.tag = loginButtonTag
            
            performSegueWithIdentifier("userLoginSegue", sender: self)
        }
        else if sender.tag == loginButtonTag {
            if checkLogin(txtUsername.text!, password: txtPassword.text!) {
                performSegueWithIdentifier("userLoginSegue", sender: self)
            } else {
                printMessage("Login Problem", msg: "Wrong username or password")
            }
        }
    }
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "userLoginSegue") {
            
        }
    }
    
    func designingCompnent() {
        
        let paddingView = UIView(frame: CGRectMake(0, 0, 10, self.txtUsername.frame.height))
        txtUsername.leftView = paddingView
        txtUsername.leftViewMode = UITextFieldViewMode.Always
        
        let paddingView2 = UIView(frame: CGRectMake(0, 0, 10, self.txtPassword.frame.height))
        txtPassword.leftView = paddingView2
        txtPassword.leftViewMode = UITextFieldViewMode.Always
        
        txtUsername.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.3)
        txtPassword.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.3)
        
        txtUsername.layer.cornerRadius = 5
        txtUsername.layer.borderWidth = 1
        txtUsername.layer.borderColor = UIColor.grayColor().CGColor
        
        txtPassword.layer.cornerRadius = 5
        txtPassword.layer.borderWidth = 1
        txtPassword.layer.borderColor = UIColor.grayColor().CGColor
        
        btnSignIn.layer.cornerRadius = 5
        btnSignIn.layer.borderWidth = 1
        btnSignIn.layer.borderColor = UIColor.clearColor().CGColor
    }
    
    
    func assignBackground(){
        let background = UIImage(named: "4.jpg")
        var imageView : UIImageView!
        imageView = UIImageView(frame: view.bounds)
        imageView.contentMode =  UIViewContentMode.ScaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = background
        imageView.center = view.center
        let overlay: UIView = UIView(frame: CGRectMake(0, 0, imageView.frame.size.width, imageView.frame.size.height));
        overlay.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.5)
        imageView.addSubview(overlay)
        view.addSubview(imageView)
        self.view.sendSubviewToBack(imageView)
    }
}