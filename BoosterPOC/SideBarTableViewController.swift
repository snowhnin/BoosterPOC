//
//  SideBarTableViewController.swift
//  BoosterPOC
//
//  Created by Hnin Lai Wai Oo on 5/2/17.
//  Copyright © 2017 HninLaiWaiOo. All rights reserved.
//

import UIKit

class SideBarTableViewController: UITableViewController {
    
    var menuItems = TypeMapRepo()
    var rowCount:Int!
    var submitLabelTest:String!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let answer = UserDefaults.standard.value(forKey: Constants.TOTALSCORE)
        if answer != nil {
            rowCount = menuItems.dataItems.count
        }
        else {
            rowCount = menuItems.dataItems.count-1
        }
        
        tableView.reloadData()
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
 
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let navigationController = segue.destination as! UINavigationController
        
        if segue.identifier == "type" {
            //let nextScene = segue.destination as? InvestorTypeViewController
            let nextScene = navigationController.topViewController as! InvestorTypeViewController
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let selectedMenu = menuItems.dataItems[indexPath.row].fileName
                nextScene.inverstorType = selectedMenu
            }
        }
    }
    
    
    // MARK: - UITableViewDataSource
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rowCount //menuItems.dataItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = menuItems.dataItems[indexPath.row].key
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier!, for: indexPath)
        
        //cell.textLabel?.textAlignment = NSTextAlignment.right
        cell.textLabel?.font = UIFont(name: "Avenir Next Medium", size: 22.0)
        cell.textLabel?.textColor = UIColor.darkGray
        
        if cellIdentifier == "submit" && UserDefaults.standard.value(forKey: Constants.SUBMIT) != nil {
            let isSubmit:String = UserDefaults.standard.value(forKey: Constants.SUBMIT) as! String
            
            if isSubmit != "" && isSubmit == "true" {
                cell.textLabel?.text = "Submitted"
            }
            else {
                cell.textLabel?.text = "Submit"
            }
        }
        
        return cell
    }

}
