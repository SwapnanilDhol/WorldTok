//
//  HomeScreen.swift
//  WorldTok
//
//  Created by Swapnanil Dhol on 10/17/19.
//  Copyright © 2019 Swapnanil Dhol. All rights reserved.

import UIKit
import MapKit

var finalListOfTimes = ["Asia/Hong_Kong"]

class HomeScreen: UITableViewController {
    
    let reuseIdentifier  = "timeCell"
    let generator = UIImpactFeedbackGenerator()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController!.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-Medium", size: 45)!]
        self.navigationController!.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-Medium", size: 20)!]
        requestNotificationPermission()

        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Edit", style: UIBarButtonItem.Style.plain, target: self, action: #selector(editButtonPressed))
        
        print(finalListOfTimes.count)
        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
        tableView.tableFooterView = UIView()
    }
    
    
    @IBAction func searchButton(_ sender: UIBarButtonItem) {
        self.performSegue(withIdentifier: "searchSegue", sender: self)
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int { 1 }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { finalListOfTimes.count }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "timeCell", for: indexPath) as! TimeTableViewCell
        
        cell.cityLabel.text = finalListOfTimes[indexPath.row]
        cell.dayDifferenceLabel.text = "Sup"
        
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      //  self.performSegue(withIdentifier: "showTimeSegue", sender: self)
        self.performSegue(withIdentifier: "searchSegue", sender: self)
        generator.impactOccurred()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool { true }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            
           // finalListOfTimes.remove(at: indexPath.row)
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

