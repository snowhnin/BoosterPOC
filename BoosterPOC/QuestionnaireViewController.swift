//
//  QuestionnaireViewController.swift
//  BoosterPOC
//
//  Created by Hnin Lai Wai Oo on 5/2/17.
//  Copyright © 2017 HninLaiWaiOo. All rights reserved.
//

import UIKit

class QuestionnaireViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var menuButton:UIBarButtonItem!
    @IBOutlet weak var questionNoLabel:UILabel!
    @IBOutlet weak var questionLabel:UILabel!
    @IBOutlet weak var answerTextField:UITextField!
    @IBOutlet weak var nextButton:UIButton!
    @IBOutlet weak var finishButton:UIButton!
    
    @IBOutlet weak var tableAnswerList:UITableView!
    
    var repo:QuestionnaireRepo!
    var dataItem:Questionnaire!
    var answerItem:UserAnswer!
    
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
        
        tableAnswerList.layer.borderWidth = 1.0
        tableAnswerList.layer.borderColor = UIColor.gray.cgColor
        tableAnswerList.layer.cornerRadius = 8
        
        repo = QuestionnaireRepo()
        answerItem = UserAnswer()
        loadQuestionnaire()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadQuestionnaire() {
        dataItem = repo.getNext();
        if dataItem != nil {
            NSLog("obj value %@", dataItem.question)
            questionLabel.text = dataItem.question
            tableAnswerList.reloadData()
        }
        else {
            
            NSLog("TotalScore %i", answerItem.getTotalScore())
            self.performSegue(withIdentifier: "totalscore", sender: finishButton)
            /*let totaScoreViewController = TotalScoreViewController()
            totaScoreViewController.answer = answerItem
            present(totaScoreViewController, animated: true, completion: nil)*/
        }
    }
    
    func saveAnswer() -> Bool {
        let selectedAnswerIndex = tableAnswerList.indexPathForSelectedRow?.row
        if selectedAnswerIndex != nil {
            answerItem.add(item: dataItem.answers[selectedAnswerIndex!])
            return true
        }
        return false
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        let navigationController = segue.destination as! UINavigationController
        
        if segue.identifier == "totalscore" {
            let nextScene = navigationController.topViewController as! TotalScoreViewController
            nextScene.answer = answerItem
        }
    }
    
    
    //MARK: - Delegates and data sources
    //MARK: Data Sources
    /*func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return dataItem.answers.count
    }
    //MARK: Delegates
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return dataItem.answers[row].title
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
    }*/
    
    //MARK: - Actions
    @IBAction func clickNext(sender: UIButton) {
        if saveAnswer() {
            loadQuestionnaire()
        }
    }
    
    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40.0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataItem.answers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "ElementCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)
            ?? UITableViewCell(style: .subtitle, reuseIdentifier: cellIdentifier)
        
        // Adding the right informations
        cell.textLabel?.font = UIFont(name: "Avenir Next Medium", size: 10.0)
        cell.textLabel?.textColor = UIColor.darkGray
        cell.textLabel?.text = dataItem.answers[indexPath.row].title
        cell.textLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
        
        // Returning the cell
        return cell
    }

}
