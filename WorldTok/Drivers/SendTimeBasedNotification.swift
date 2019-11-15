//
//  SendTimeBasedNotification.swift
//  WorldTok
//
//  Created by Swapnanil Dhol on 10/26/19.
//  Copyright © 2019 Swapnanil Dhol. All rights reserved.
//

import UIKit
import UserNotifications



extension CityTimeScreen
{
    func setNotificationWith(givenTimeZone: TimeZone,message: String, cityName: String, date: Int, hour: Int, minute: Int)
    {
        let center = UNUserNotificationCenter.current()
        
        let content = UNMutableNotificationContent()
        
        if message != ""
        {
            content.title = message
        }
        else
        {content.title = "Alert for \(cityName)"}
        content.body = "It is now \(hour):\(minute) at \(cityName)"
        content.sound = .default
        
        //MARK: Testing!!
        
        let calendar = Calendar.current
        let testDate = DateComponents(calendar: calendar, timeZone: givenTimeZone, day: date, hour: hour, minute: minute)
        print("Time Zone set")
        let trigger = UNCalendarNotificationTrigger(dateMatching: testDate, repeats: false)
        print(trigger)
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        center.add(request) { (error) in
            if error == nil
            {
                //MARK: Notification has been set
                
                self.notificationGenerator.notificationOccurred(.success)
                
                UNUserNotificationCenter.current().getPendingNotificationRequests { (requests) in
                    
                    let count = requests.count
                    DispatchQueue.main.async {
                        if let tabItems = self.tabBarController?.tabBar.items {
                            // In this case we want to modify the badge number of the third tab:
                            let tabItem = tabItems[1]
                            tabItem.badgeValue = String(count)
                        }
                    }
                    
                }
                
                
            }
            else
            {
                print(error?.localizedDescription)
            }
        }
    }
    
    func fetchTimeFor(givenTimeZone: TimeZone) -> String
    {
        var timeString = ""
        
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        formatter.timeZone = givenTimeZone
        let timeNow = Date()
        timeString = formatter.string(from: timeNow)
        print(timeString)
        return timeString
    }
}
