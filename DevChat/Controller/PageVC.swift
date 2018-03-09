//
//  PageVC.swift
//  DevChat
//
//  Created by Rex Kung on 3/8/18.
//  Copyright © 2018 Rex Kung. All rights reserved.
//

import UIKit

class PageVC: UIPageViewController, UIPageViewControllerDataSource {
    
    lazy var viewControllerList:[UIViewController] = {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        
        let vc1 = sb.instantiateViewController(withIdentifier: "VideoView")
        let vc2 = sb.instantiateViewController(withIdentifier: "CameraView")
        
        
        return [vc1, vc2]
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSource = self
        // Do any additional setup after loading the view.
        
        if let firstViewController = viewControllerList.last {
            self.setViewControllers([firstViewController], direction: .forward, animated: true, completion: nil)
        }
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let vcIndex = viewControllerList.index(of: viewController) else { return nil }
        
        let previousIndex = vcIndex - 1
        
        guard previousIndex >= 0 else { return nil }
        
        guard viewControllerList.count > previousIndex else { return nil }
        
        return viewControllerList[previousIndex]
        
        
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {

        guard let vcIndex = viewControllerList.index(of: viewController) else { return nil }

        let nextIndex = vcIndex + 1
        
        guard nextIndex <= viewControllerList.count else { return nil }
        
        guard viewControllerList.count > nextIndex else { return nil }
        
        return viewControllerList[nextIndex]
    }

}
