//
//  ContextMenuExtension.swift
//  WorldTok
//
//  Created by Swapnanil Dhol on 10/17/19.
//  Copyright © 2019 Swapnanil Dhol. All rights reserved.
//

import UIKit
import UserNotifications

extension HomeScreen
{
    override func tableView(_ tableView: UITableView,
    contextMenuConfigurationForRowAt indexPath: IndexPath,
    point: CGPoint) -> UIContextMenuConfiguration? {
        
        
        let configuration = UIContextMenuConfiguration(identifier: nil, previewProvider: nil){ action in
                let sendNotif = UIAction(title: "Send Notfication", image: UIImage(systemName: "eye.fill"), identifier: UIAction.Identifier(rawValue: "view")) {_ in
                    
                    self.sendNotification(location: self.timeZones[indexPath.row], indexPath: indexPath.row)
                }
                return UIMenu(title: "Actions", image: nil, identifier: nil, children: [sendNotif])
            }
            
            return configuration
    }
    
    
    func sendNotification(location: String, indexPath: Int)
    {
        
        let center = UNUserNotificationCenter.current()
        
        
        
        let content = UNMutableNotificationContent()
        
        let formatter = DateFormatter()
               formatter.timeStyle = .long
               formatter.timeZone = TimeZone(identifier: timeZones[indexPath])
               formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let alertTime = formatter.string(from: Date())
        
        content.title = "Alert for \(location)!"
        content.body = "It's now \(alertTime) at \(location)"
        content.categoryIdentifier = "customIdentifier"
        content.sound = UNNotificationSound.default
        
        
        var dateComponents = DateComponents()
           dateComponents.hour = 10
           dateComponents.minute = 30
//let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
         let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)

           let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
           center.add(request)
    }
    
    func requestNotificationPermission()
    
    {
        let center = UNUserNotificationCenter.current()

         center.requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in
            if granted {
                print("Yay!")
            } else {
                print("D'oh")
            }
        }
    }
}
