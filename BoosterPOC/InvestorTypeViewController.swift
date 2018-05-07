//
//  InvestorTypeViewController.swift
//  BoosterPOC
//
//  Created by Hnin Lai Wai Oo on 5/2/17.
//  Copyright © 2017 HninLaiWaiOo. All rights reserved.
//

import UIKit

class InvestorTypeViewController: UIViewController {

    @IBOutlet weak var webView:UIWebView!
    @IBOutlet weak var menuButton:UIBarButtonItem!
    @IBOutlet weak var myImageView:UIImageView!
    var inverstorType:String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if inverstorType != nil {
            NSLog("data Value: %@", inverstorType!)
            //self.title = inverstorType!
            
            let htmlFile = Bundle.main.path(forResource: inverstorType, ofType: "html")
            let html = try? String(contentsOfFile: htmlFile!, encoding: String.Encoding.utf8)
            let baseURL = URL.init(fileURLWithPath: Bundle.main.bundlePath)
            webView.loadHTMLString(html!, baseURL: baseURL)
            
            //self.myImageView.image = UIImage(named: inverstorType! + ".png")
            self.myImageView.isHidden = true;
        }
        
        revealViewController().frontViewPosition = FrontViewPosition.right
        revealViewController().rightViewRevealWidth = 250
        
        if self.revealViewController() != nil {
            self.revealViewController().rightViewRevealOverdraw = 0.0
            menuButton.target = self.revealViewController()
            menuButton.action = #selector(SWRevealViewController.rightRevealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
        let logo = UIImage(named: "booster-logo-small.jpg")
        let imageView = UIImageView(image:logo)
        self.navigationItem.titleView = imageView
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
