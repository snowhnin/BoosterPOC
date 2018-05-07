//
//  SumitViewController.swift
//  BoosterPOC
//
//  Created by Hnin Lai Wai Oo on 6/2/17.
//  Copyright © 2017 HninLaiWaiOo. All rights reserved.
//

import UIKit
import MessageUI

class SumitViewController: UIViewController, MFMailComposeViewControllerDelegate {

    @IBOutlet weak var menuButton:UIBarButtonItem!
    @IBOutlet weak var txtName:UITextField!
    @IBOutlet weak var txtPhone:UITextField!
    @IBOutlet weak var txtEmail:UITextField!
    
    @IBOutlet weak var mytextView:UITextView!
    
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

        if (UserDefaults.standard.value(forKey: Constants.SUBMIT) != nil ) {
            let isSubmit:String = UserDefaults.standard.value(forKey: Constants.SUBMIT) as! String
            if  isSubmit != "" {
                if isSubmit == "false" {
                    mytextView.isHidden = true
                }
                else {
                    mytextView.isHidden = false
                }
            }
            else {
                mytextView.isHidden = true
            }
        }
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
    
    func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
    // MARK: - IBAction
    
    @IBAction func sendEmailButtonTapped(sender: AnyObject) {
        
        //Checking the textfields
        var message:String = ""
        if txtName.text == "" {
            message += "Name is required\n"
        }
        if txtEmail.text == "" {
            message += "Email is required\n"
        }
        else {
            if isValidEmail(testStr: txtEmail.text!) == false {
                message += "Email is invalid\n"
            }
        }
        if txtPhone.text == "" {
            message += "Phone is required\n"
        }
        
        if message != "" {
            let errorAlert = UIAlertView(title: "Error", message: "The error:\n" + message, delegate: self, cancelButtonTitle: "OK")
            errorAlert.show()
        }
        else {
            let mailComposeViewController = configuredMailComposeViewController()
            if MFMailComposeViewController.canSendMail() {
                self.present(mailComposeViewController, animated: true, completion: nil)
                NSLog("Email Sent");
                UserDefaults.standard.set("true", forKey: Constants.SUBMIT)
                mytextView.isHidden = false;
            } else {
                self.showSendMailErrorAlert()
            }
        }
    }
    
    func configuredMailComposeViewController() -> MFMailComposeViewController {
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self // Extremely important to set the --mailComposeDelegate-- property, NOT the --delegate-- property
        
        mailComposerVC.setToRecipients(["snow@basetwo.co.nz"])
        mailComposerVC.setSubject("Submission of booster inverstor app")
        let totalScore:String = UserDefaults.standard.value(forKey: Constants.TOTALSCORE) as! String
        let type:String = UserDefaults.standard.value(forKey: Constants.INVESTORTYPE) as! String
        let emailBody:String = String(format: "Name: %@\nEmail: %@\nPhone: %@\nTotal Score: %@\nInvestor Type: %@", txtName.text!, txtEmail.text!, txtPhone.text!, totalScore, type)
        mailComposerVC.setMessageBody(emailBody, isHTML: false)
        
        return mailComposerVC
    }
    
    func showSendMailErrorAlert() {
        let sendMailErrorAlert = UIAlertView(title: "Could Not Send Email", message: "Your device could not send e-mail.  Please check e-mail configuration and try again.", delegate: self, cancelButtonTitle: "OK")
        sendMailErrorAlert.show()
    }
    
    // MARK: MFMailComposeViewControllerDelegate Method
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }

}
