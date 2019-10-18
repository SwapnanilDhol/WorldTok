//
//  HomeScreen.swift
//  WorldTok
//
//  Created by Swapnanil Dhol on 10/17/19.
//  Copyright © 2019 Swapnanil Dhol. All rights reserved.
//

import UIKit
import MapKit

class HomeScreen: UITableViewController {
    
    let reuseIdentifier  = "timeCell"
    var timeZones = UserDefaults.standard.value(forKey: "selectedTimeZones") as? [String] ?? ["Europe/Paris", "Asia/Dubai"]
    let generator = UIImpactFeedbackGenerator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController!.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-Medium", size: 45)!]
        self.navigationController!.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-Medium", size: 20)!]
        requestNotificationPermission()
       // networkRequest()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Edit", style: UIBarButtonItem.Style.plain, target: self, action: #selector(editButtonPressed))
        
       
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        tableView.tableFooterView = UIView()
    }

    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int { 1 }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { timeZones.count }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

            let cell = tableView.dequeueReusableCell(withIdentifier: "timeCell", for: indexPath) as! TimeTableViewCell
            cell.cityLabel.text = timeZones[indexPath.row]
            return cell
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "showTimeSegue", sender: self)
        generator.impactOccurred()
        tableView.deselectRow(at: indexPath, animated: true)
    }
   
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool { true }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
           
            timeZones.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.reloadData()
            
            
        }
    }
    
 @objc func editButtonPressed(){
     tableView.setEditing(!tableView.isEditing, animated: true)
     if tableView.isEditing == true{
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.plain, target: self, action: #selector(editButtonPressed))
     }else{
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Edit", style: UIBarButtonItem.Style.plain, target: self, action: #selector(editButtonPressed))
     }
 }
    
    
 
}

