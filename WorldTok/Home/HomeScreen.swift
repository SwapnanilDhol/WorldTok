//
//  HomeScreen.swift
//  WorldTok
//
//  Created by Swapnanil Dhol on 10/17/19.
//  Copyright © 2019 Swapnanil Dhol. All rights reserved.

import UIKit
import MapKit



var finalListOfTimes = UserDefaults.standard.value(forKey: "finalListOfTimes") as? [String] ?? []
var cities = UserDefaults.standard.value(forKey: "cities") as? [String] ?? []
var savedLocation = UserDefaults.standard.value(forKey: "savedLocation") as? [CLLocationCoordinate2D] ?? []
var savedLat = UserDefaults.standard.value(forKey: "savedLat") as? [Double] ?? []
var savedLong = UserDefaults.standard.value(forKey: "savedLong") as? [Double] ?? []


class HomeScreen: UITableViewController {
    
    //MARK: Variables
    
    let userDefaults = UserDefaults.standard
    let reuseIdentifier  = "timeCell"
    let generator = UIImpactFeedbackGenerator()
    let timer = Timer()
    var favTimeZone = UserDefaults.standard.value(forKey: "favTimeZone") as? String ?? ""
    var favCity = UserDefaults.standard.value(forKey: "favCity") as? String ?? ""
    let notificationGenerator = UINotificationFeedbackGenerator()
    let feedbackGenerator = UIImpactFeedbackGenerator()
    let center = UNUserNotificationCenter.current()
    let pickerView = UIDatePicker(frame: CGRect(x: 0, y: 0, width: 250, height: 300))
    var realTimeComp = DateComponents()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        requestNotificationPermission()
        checkNotifAndSetBadge()

        
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Edit", style: UIBarButtonItem.Style.plain, target: self, action: #selector(editButtonPressed))
        
        self.refreshControl?.addTarget(self, action: #selector(refresh), for: UIControl.Event.valueChanged)
        
        NotificationCenter.default.addObserver(self, selector: #selector(reloadTableView), name: .init("dismissParent"), object: nil)
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        
        finalListOfTimes = UserDefaults.standard.value(forKey: "finalListOfTimes") as? [String] ?? []
        cities = UserDefaults.standard.value(forKey: "cities") as? [String] ?? []
        savedLat = UserDefaults.standard.value(forKey: "savedLat") as? [Double] ?? []
        savedLong = UserDefaults.standard.value(forKey: "savedLong") as? [Double] ?? []
        
        tableView.reloadData()
        tableView.tableFooterView = UIView()
        
        
    }
    
    func checkNotifAndSetBadge()
    {
        
        UNUserNotificationCenter.current().getPendingNotificationRequests { (requests) in
            
            let count = requests.count
            DispatchQueue.main.async {
                if let tabItems = self.tabBarController?.tabBar.items {
                    // In this case we want to modify the badge number of the third tab:
                    let tabItem = tabItems[1]
                    if count != 0
                    {tabItem.badgeValue = String(count)}
                    else {tabItem.badgeValue = nil}
                    
                }
            }
            
        }
    }
    
    @objc func reloadTableView()
    {
        print(finalListOfTimes, cities, savedLong)
        tableView.reloadData()

    }
    
    @objc func refresh(sender:AnyObject)
    {
        
        //Refreshing all the values
        generator.impactOccurred()
        self.tableView.reloadData()
        self.refreshControl?.endRefreshing()
        
        
        UNUserNotificationCenter.current().getPendingNotificationRequests(completionHandler: { (requests) in

            for request in requests {
                if requests.isEmpty == false
                {
                    print(request.content.body)
                }
                else
                {print("No notifications available")}
            }
        })
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
            savedLat.remove(at: indexPath.row)
            savedLong.remove(at: indexPath.row)
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
        
        //Refreshing all the values
//
//              finalListOfTimes = UserDefaults.standard.value(forKey: "finalListOfTimes") as? [String] ?? []
//              cities = UserDefaults.standard.value(forKey: "cities") as? [String] ?? []
//              savedLat = UserDefaults.standard.value(forKey: "savedLat") as? [Double] ?? []
//              savedLong = UserDefaults.standard.value(forKey: "savedLong") as? [Double] ?? []
              
        
        print(finalListOfTimes)
        NotificationCenter.default.post(name: .init("startTimer"), object: nil)
        
        
        
        
        self.tableView.reloadData()
    }
    
    func presentationController(_ presentationController: UIPresentationController, willPresentWithAdaptiveStyle style: UIModalPresentationStyle, transitionCoordinator: UIViewControllerTransitionCoordinator?) {
        
        NotificationCenter.default.post(name: .init("invalidate"), object: nil)
    }
    
    
}

