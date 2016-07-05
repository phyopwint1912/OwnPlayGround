//
//  SliderViewController.swift
//  OwnPlayground
//
//  Created by Phyo Pwint  on 29/4/16.
//  Copyright © 2016 Phyo Pwint . All rights reserved.
//

import UIKit

class SliderViewController: UIViewController, UIPageViewControllerDataSource {

    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    var pageViewController: UIPageViewController!
    var pageTitles: NSArray!
    var pageImages: NSArray!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.pageTitles = ["Kitty1", "Kitty2", "Kitty3"]
        self.pageImages = ["1.jpg", "2.jpg", "3.jpg"]
        
        self.pageViewController = self.storyboard?.instantiateViewControllerWithIdentifier("PageViewController") as! UIPageViewController
        
        self.pageViewController.dataSource = self
        
        
        let startVC = self.viewControllerAtIndex(0) as PageContentViewController
        
        let viewControllers = NSArray(object: startVC)
        
        self.pageViewController.setViewControllers(viewControllers as? [UIViewController], direction: .Forward, animated: true, completion: nil)

        self.addChildViewController(self.pageViewController)
        
        self.view.addSubview(self.pageViewController.view)
        
        self.pageViewController.didMoveToParentViewController(self)
        //Implement the Slider navigation bar.
        if revealViewController() != nil {
            menuButton.target = revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
    }
    
    @IBAction func btnRestart(sender: AnyObject) {
        
        let startVC = self.viewControllerAtIndex(0) as PageContentViewController
        
        let viewControllers = NSArray(object: startVC)
        self.pageViewController.setViewControllers(viewControllers as? [UIViewController], direction: .Forward, animated: true, completion: nil)
    }
    
    
    func viewControllerAtIndex(index: Int) -> PageContentViewController {
        
        if ((self.pageTitles.count == 0) || (index >= self.pageTitles.count)) {
            
            return PageContentViewController()
            
        }
        
        let vc: PageContentViewController = self.storyboard?.instantiateViewControllerWithIdentifier("ContentViewController") as! PageContentViewController
        
        vc.strPhotoName = self.pageImages[index]as! String
        vc.strTitle = self.pageTitles[index]as! String
        vc.pageIndex = index
        
        
        return vc
        
        
    }
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController?
        
    {
        
        let vc = viewController as! PageContentViewController
        
        var index = vc.pageIndex as Int
        
        if (index == 0 || index == NSNotFound)
            
        {
            
            return nil
            
        }
        
        index -= 1
        
        return self.viewControllerAtIndex(index)
        
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController?{
        
        
        let vc = viewController as! PageContentViewController
        var index = vc.pageIndex as Int
        
        if (index == NSNotFound){
            return nil
        }
        
        index += 1
        
        if (index == self.pageTitles.count){
            return nil
        }
        
        return self.viewControllerAtIndex(index)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

}
