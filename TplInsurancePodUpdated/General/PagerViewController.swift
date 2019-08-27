//
//  PagerViewController.swift
//  TPLInsurance
//
//  Created by Sajad on 2/7/18.
//  Copyright © 2018 TPLHolding. All rights reserved.
//

import UIKit
@objc protocol PagerViewDelegate {
    func willMoveTo(next controller: UIViewController, completionHandler: @escaping (Bool) -> Void)
    @objc optional func willSkipTo(next controller: UIViewController, completionHandler: @escaping (Bool, UIViewController) -> Void)
}

class PagerViewController: SecondaryViewController {

    // 0 for view controller
    // 1 for Title of controller
    // 2 for is skipable or not
    public var pages: [(UIViewController, String, Bool)?] = [] {
        didSet {
            if pages.count > 0 {
                let page = pages[0]!
                refreshPager(withPage: page.0, title: page.1, isSkipable: page.2)
            }
        }
    }
    var pageViewController: UIPageViewController?
    var currentPageIndex: Int = 0
    
    @IBOutlet weak var backButton: UIBarButtonItem!
    @IBOutlet weak var nextButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        /*
        pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        //pageViewController?.dataSource = self
        
        if let controller = pages[0] {
            pageViewController?.setViewControllers([controller], direction: .forward, animated: true, completion: nil)
        }
        
        pageViewController?.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.height)
        
        addChildViewController(pageViewController!)
        view.addSubview((pageViewController?.view)!)
        pageViewController?.didMove(toParentViewController: self)
        
        */
        
        // Do any additional setup after loading the view.
        
    }

    func refreshPager(withPage: UIViewController, title :String, isSkipable: Bool) {
        if let pager = pageViewController {
            pager.setViewControllers([withPage], direction: .forward, animated: true, completion: nil)
            navigationItem.title = title
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        let index = currentPageIndex - 1
        if index >= 0,
            let controller = pages[index] {
            pageViewController?.setViewControllers([controller.0], direction: .reverse, animated: true, completion: nil)
            navigationItem.title = controller.1
            currentPageIndex = index
            self.nextButton.title = "Next"
            self.nextButton.tintColor = UIColor(red:0.95, green:0.44, blue:0.13, alpha:1.0)

//            if controller.2 {
//                 self.nextButton.title = "Skip"
//            } else {
//                 self.nextButton.title = "Next"
//            }
           
        }
        else{
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    @IBAction func nextButtonPressed(_ sender: Any) {
        print("current page is: \(currentPageIndex)")
        var index = currentPageIndex + 1
        if index == pages.count {
            let currentController = pageViewController?.viewControllers?[0]
            if let pageController = currentController as? PagerViewDelegate {
                pageController.willMoveTo(next: UIViewController(), completionHandler: { (success) in
                    print("Next on last page")
                    //self.nextButton.title = "Submit"
                })
            }
        }
        if index < pages.count,
            var controller = pages[index] {
            
            let currentController = pageViewController?.viewControllers?[0]
            if let pageController = currentController as? PagerViewDelegate {
                    pageController.willMoveTo(next: controller.0, completionHandler: { (success) in
                        if (success) {
                            if currentController is TIDetails3ViewController {
                                if self.pages.index(where: { (page) -> Bool in
                                    return page?.0 is TIFamilyDetailsViewController
                                }) != nil {
                                    print("yes available")
                                    self.pageViewController?.setViewControllers([controller.0], direction: .forward, animated: true, completion: nil)
                                    self.navigationItem.title = controller.1
                                    self.currentPageIndex = index

                                }
                                else {
                                    print(" not available")
//                                    if self.pages.index(where: { (page) -> Bool in
//                                        return page?.0 is TIFamilyDetailsViewController
//                                    }) != nil {
                                        var controller3 = (self.storyboard!.instantiateViewController(withIdentifier: "TIFamilyDetailsViewController"), "Travel Insurance- Family Details", false)
                                        self.pages.insert(controller3, at: 3)
                                        controller = self.pages[3]!
                                        self.pageViewController?.setViewControllers([controller.0], direction: .forward, animated: true, completion: nil)
                                        self.navigationItem.title = controller.1
                                        self.currentPageIndex = index
//                                    }
                                    
                                    
                                }
                            } else {
                                self.pageViewController?.setViewControllers([controller.0], direction: .forward, animated: true, completion: nil)
                                self.navigationItem.title = controller.1
                                self.currentPageIndex = index
                                if self.currentPageIndex+1 == self.pages.count{
                                    self.nextButton.title = "Submit"
                                    self.nextButton.tintColor = UIColor(red:0.95, green:0.44, blue:0.13, alpha:1.0)
                                }
                                    //                            else if controller.2 {
                                    //                                self.nextButton.title = "Skip"
                                    //                            }
                                else {
                                    self.nextButton.title = "Next"
                                    self.nextButton.tintColor = UIColor(red:0.95, green:0.44, blue:0.13, alpha:1.0)
                                }
                            }
                        }
                        else {
                            if currentController is TIDetails3ViewController {
                                print("if you are here then write your logic of removal of array bla bla")
                                if self.isAddFamilyFormPresentInArray() {
                                    self.pages.remove(at: index)
                                }
                                controller = self.pages[index]!
                                pageController.willMoveTo(next: controller.0, completionHandler: { (success) in
                                    self.pageViewController?.setViewControllers([controller.0], direction: .forward, animated: true, completion: nil)
                                    self.navigationItem.title = controller.1
                                    self.currentPageIndex = index
                                })
                                
                            }
                        }
                    })
            } else {
                pageViewController?.setViewControllers([controller.0], direction: .forward, animated: true, completion: nil)
                currentPageIndex = index
                navigationItem.title = controller.1
            }
        }
    }
    
    
    func isAddFamilyFormPresentInArray() -> Bool {
        if self.pages.index(where: {(object) -> Bool in
            return object?.0 is TIFamilyDetailsViewController ? true : false
        }) != nil {
            return true
        }
        return false
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "embedded",
            let pager = segue.destination as? UIPageViewController {
            pageViewController = pager
            if pages.count > 0 {
                let page = pages[0]!
                refreshPager(withPage: page.0, title: page.1, isSkipable: page.2)
            }
        }
    }
}

