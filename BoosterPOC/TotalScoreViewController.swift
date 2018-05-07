//
//  TotalScoreViewController.swift
//  BoosterPOC
//
//  Created by Hnin Lai Wai Oo on 5/2/17.
//  Copyright © 2017 HninLaiWaiOo. All rights reserved.
//

import UIKit

class TotalScoreViewController: UIViewController {
    
    @IBOutlet weak var menuButton:UIBarButtonItem!
    @IBOutlet weak var totalScoreLabel:UILabel!
    @IBOutlet weak var inverstorTypeLabel:UILabel!
    var answer:UserAnswer!
    var inverstorType:TypeMap!

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
        
        let totalScore:Int = answer.getTotalScore()
        self.totalScoreLabel.text = String(totalScore)
        inverstorType = answer.getInvestorType(totalScore: totalScore)
        self.inverstorTypeLabel.text = String(format: "You are a %@ inverstor.", inverstorType.title)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "type" {
            /*let navigationController = segue.destination as! UINavigationController
            let nextScene = navigationController.topViewController as! InvestorTypeViewController
            nextScene.inverstorType = inverstorType.key*/
            
            UserDefaults.standard.set(totalScoreLabel.text, forKey: Constants.TOTALSCORE)
            UserDefaults.standard.set(inverstorType.title, forKey: Constants.INVESTORTYPE)
            
            let destinationVC = segue.destination as! InvestorTypeViewController
            destinationVC.inverstorType = inverstorType.key
        }
    }
}
