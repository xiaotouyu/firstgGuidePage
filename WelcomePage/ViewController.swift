//
//  ViewController.swift
//  WelcomePage
//
//  Created by dashuios126 on 16/7/28.
//  Copyright © 2016年 dashuios126. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UIScrollViewDelegate {

    let btn = UIButton()
    let scrollView = UIScrollView()
    let pageControl = UIPageControl()
    

    override func viewDidLoad() {
        super.viewDidLoad()
    
        pageControl.center = CGPointMake(view.frame.width/2, view.frame.height - 30)
        pageControl.currentPageIndicatorTintColor = UIColor.redColor()
        pageControl.pageIndicatorTintColor = UIColor.whiteColor()
        pageControl.numberOfPages = 4
        pageControl.addTarget(self, action: #selector(scrollViewDidEndDecelerating), forControlEvents: .ValueChanged)
        
        scrollView.frame = view.bounds
        scrollView.contentSize = CGSizeMake(4 * view.bounds.width, 0)
        scrollView.pagingEnabled = true
        scrollView.bounces = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.delegate = self
        view.addSubview(scrollView)
        
        for i in 0...3 {
            let image = UIImage(named: "\(i + 1)")
            let imageView = UIImageView(frame: CGRectMake(0, 0, view.bounds.width, view.bounds.height))
            imageView.image = image
            var frame = imageView.frame
            frame.origin.x = CGFloat(i) * imageView.bounds.width
            imageView.frame = frame
            scrollView.addSubview(imageView)
            
        }
        view.addSubview(pageControl)

    }

    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        let index = Int(scrollView.contentOffset.x / view.frame.size.width)    //获取当前页数
        pageControl.currentPage = index
        //在这里添加按钮的渐入效果,当页面滑到第4页时出现
        if(index == 3)
        {
            btn.frame = CGRectMake(3*self.view.frame.width, self.view.frame.height, self.view.frame.width, 50)
            btn.setTitle("开启Swift之旅", forState: UIControlState.Normal)
            btn.titleLabel?.font = UIFont.systemFontOfSize(20)
            btn.setTitleColor(UIColor.grayColor(), forState: UIControlState.Highlighted)
            btn.backgroundColor = UIColor.orangeColor()
            btn.alpha = 0
            btn.addTarget(self, action: #selector(buttonClick), forControlEvents: UIControlEvents.TouchUpInside)
            UIView.animateWithDuration(1, delay: 0.5, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
                self.btn.frame = CGRectMake(3*self.view.frame.width, self.view.frame.height-100, self.view.frame.width, 50)
          
                self.btn.alpha = 1
                //注意把按钮添加到scrollView上,不要添加到imageView上,会无法点击
                scrollView.addSubview(self.btn)
                }, completion: nil)
        }else{
            btn.removeFromSuperview()
        }
    }
    //按钮点击事件
    func buttonClick(button:UIButton)
    {
        //界面的跳转
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let rootVC = sb.instantiateViewControllerWithIdentifier("root")
        self.presentViewController(rootVC, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

