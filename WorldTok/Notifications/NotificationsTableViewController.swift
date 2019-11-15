//
//  NotificationsTableViewController.swift
//  WorldTok
//
//  Created by Swapnanil Dhol on 11/15/19.
//  Copyright © 2019 Swapnanil Dhol. All rights reserved.
//

import UIKit
import NotificationCenter

class NotificationsTableViewController: UITableViewController {
    
    let notificationCenter = UNUserNotificationCenter.current()
    var notifTitles = [String]()
    var notifID = [String]()
    let notificationGenerator = UINotificationFeedbackGenerator()
    let generator = UIImpactFeedbackGenerator()
    
    let reuseID = "cell"

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
    }
    override func viewDidAppear(_ animated: Bool) {
        getterFunc()
        tableView.reloadData()
    }
    
    func getterFunc()
    {
        notificationCenter.getPendingNotificationRequests { (requests) in
        
            if requests.isEmpty == false
            {
            for request in requests
            {

                self.notifTitles.append(request.content.body)
                self.notifID.append(request.identifier)
            }
            }
            else
            {
                print("No pending Notifications")
            }
            
            print(self.notifTitles.count)
            DispatchQueue.main.async {
                 self.tableView.reloadData()
            }
            
           
        }
        
        print(self.notifTitles.count)
        
        
    }
    
    @IBAction func deleteAll(_ sender: Any) {
        notificationCenter.removeAllPendingNotificationRequests()
        notifTitles.removeAll()
        notifID.removeAll()
        if let tabItems = tabBarController?.tabBar.items {
            // In this case we want to modify the badge number of the third tab:
            let tabItem = tabItems[1]
            tabItem.badgeValue = nil
        }
        notificationGenerator.notificationOccurred(.success)
        tableView.reloadData()
    }
    
    
    


}
extension NotificationsTableViewController
{
    
    override func numberOfSections(in tableView: UITableView) -> Int {1}

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
       if notifTitles.count == 0 {
            self.tableView.setEmptyMessage("No Notifications Set Yet.")
        } else {
            self.tableView.restore()
        }

        return notifTitles.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseID, for: indexPath)
        cell.textLabel?.text = notifTitles[indexPath.row]
        cell.detailTextLabel?.text = notifID[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    
}
