//
//  MainScreenViewController.swift
//  BoosterPOC
//
//  Created by Hnin Lai Wai Oo on 5/2/17.
//  Copyright © 2017 HninLaiWaiOo. All rights reserved.
//

import UIKit

class MainScreenViewController: UIViewController {

    @IBOutlet weak var menuButton:UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
        
        UserDefaults.standard.removeObject(forKey: Constants.TOTALSCORE)
        UserDefaults.standard.removeObject(forKey: Constants.INVESTORTYPE)
        UserDefaults.standard.removeObject(forKey: Constants.SUBMIT)
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
