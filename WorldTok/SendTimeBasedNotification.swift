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
    func setNotificationWith(givenTimeZone: TimeZone, cityName: String, date: Int, hour: Int, minute: Int)
    {
        let center = UNUserNotificationCenter.current()

        let content = UNMutableNotificationContent()
        content.title = "Alert for \(cityName)"
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
                print("Notification Set")
                print(request.content.body)
                self.notificationGenerator.notificationOccurred(.success)
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
