//
//  HomeScreen.swift
//  WorldTok
//
//  Created by Swapnanil Dhol on 10/17/19.
//  Copyright © 2019 Swapnanil Dhol. All rights reserved.

import UIKit
import MapKit

var finalListOfTimes = ["Europe/Paris"]
var cities = ["Paris, Europe"]

class HomeScreen: UITableViewController {
    
    let reuseIdentifier  = "timeCell"
    let generator = UIImpactFeedbackGenerator()
    let timer = Timer()
    var favTimeZone = UserDefaults.standard.value(forKey: "favTimeZone") as? String ?? ""
    var favCity = UserDefaults.standard.value(forKey: "favCity") as? String ?? ""
    
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
    
    override func numberOfSections(in tableView: UITableView) -> Int {
    
        if favTimeZone != ""
        {
            return 2
        }
        else
        {
            return 1
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if favTimeZone != ""
        {
            switch section
            {
            case 0:
                return 1
            case 1:
                return finalListOfTimes.count
            default:
                break
            }
        }
        else
        {
            return finalListOfTimes.count
        }
        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        if favTimeZone == ""
        {
        let cell = tableView.dequeueReusableCell(withIdentifier: "timeCell", for: indexPath) as! TimeTableViewCell
        cell.cityLabel.text = cities[indexPath.row]
        cell.timeZoneLabel.text = finalListOfTimes[indexPath.row]
        cell.dayDifferenceLabel.text = "Loading"
        return cell
        }
        else
        {
            if indexPath.section == 0 {
            let favCell = tableView.dequeueReusableCell(withIdentifier: "favCell", for: indexPath) as! TimeTableViewCell
            favCell.cityLabel.text = favCity
            favCell.timeZoneLabel.text = favTimeZone
            favCell.dayDifferenceLabel.text = "Loading"
                return favCell
            }
            else
            {
                let cell = tableView.dequeueReusableCell(withIdentifier: "timeCell", for: indexPath) as! TimeTableViewCell
                cell.cityLabel.text = cities[indexPath.row]
                cell.timeZoneLabel.text = finalListOfTimes[indexPath.row]
                cell.dayDifferenceLabel.text = "Loading"
                return cell
            }
        }
        
        
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        globalIndex = indexPath.row
        self.performSegue(withIdentifier: "showTimeSegue", sender: self)
       // self.performSegue(withIdentifier: "searchSegue", sender: self)
        generator.impactOccurred()
        tableView.deselectRow(at: indexPath, animated: true)
    }
   
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if (favCity != "")
        {
            if (section == 0)
            {
                return "Favourite City"
            }
        }
        return nil
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

