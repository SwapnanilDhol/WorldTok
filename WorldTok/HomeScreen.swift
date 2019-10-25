//
//  HomeScreen.swift
//  WorldTok
//
//  Created by Swapnanil Dhol on 10/17/19.
//  Copyright © 2019 Swapnanil Dhol. All rights reserved.

import UIKit
import MapKit

var finalListOfTimes = ["Asia/Hong_Kong"]
var cities = ["Hong Kong"]

class HomeScreen: UITableViewController {
    
    let reuseIdentifier  = "timeCell"
    let generator = UIImpactFeedbackGenerator()
    let timer = Timer()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        requestNotificationPermission()

        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Edit", style: UIBarButtonItem.Style.plain, target: self, action: #selector(editButtonPressed))
        
        self.refreshControl?.addTarget(self, action: #selector(refresh), for: UIControl.Event.valueChanged)
        
        NotificationCenter.default.addObserver(self, selector: #selector(reloadTableView), name: .init("dismissParent"), object: nil)
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        
        tableView.reloadData()
        tableView.tableFooterView = UIView()

    }
    
    @objc func reloadTableView()
    {
        tableView.reloadData()
    }
    
    @objc func refresh(sender:AnyObject)
    {
        generator.impactOccurred()

        self.tableView.reloadData()
        self.refreshControl?.endRefreshing()
    }

    
    @IBAction func searchButton(_ sender: UIBarButtonItem) {
        self.performSegue(withIdentifier: "searchSegue", sender: self)
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int { 1 }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { finalListOfTimes.count }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "timeCell", for: indexPath) as! TimeTableViewCell
        
        cell.cityLabel.text = cities[indexPath.row]
        cell.timeZoneLabel.text = finalListOfTimes[indexPath.row]
        cell.dayDifferenceLabel.text = "Loading"
        
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "showTimeSegue", sender: self)
       // self.performSegue(withIdentifier: "searchSegue", sender: self)
        generator.impactOccurred()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool { true }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            
            finalListOfTimes.remove(at: indexPath.row)
            cities.remove(at: indexPath.row)
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

extension HomeScreen : UIAdaptivePresentationControllerDelegate {
    public override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
      if segue.identifier == "searchSegue" {
        segue.destination.presentationController?.delegate = self;
      }
}
    public func presentationControllerDidDismiss(
      _ presentationController: UIPresentationController)
    {
         print(finalListOfTimes)
        NotificationCenter.default.post(name: .init("startTimer"), object: nil)
        self.tableView.reloadData()
    }
    
    func presentationController(_ presentationController: UIPresentationController, willPresentWithAdaptiveStyle style: UIModalPresentationStyle, transitionCoordinator: UIViewControllerTransitionCoordinator?) {
        
        NotificationCenter.default.post(name: .init("invalidate"), object: nil)
    }
    
    
}

