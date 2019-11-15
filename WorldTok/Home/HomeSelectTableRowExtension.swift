//
//  HomeSelectTableRowExtension.swift
//  WorldTok
//
//  Created by Swapnanil Dhol on 10/27/19.
//  Copyright © 2019 Swapnanil Dhol. All rights reserved.
//

import UIKit

extension HomeScreen
{
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
           globalIndex = indexPath.row
           self.performSegue(withIdentifier: "showTimeSegue", sender: self)
          // self.performSegue(withIdentifier: "searchSegue", sender: self)
           generator.impactOccurred()
           tableView.deselectRow(at: indexPath, animated: true)
        
        //Show Action Sheet
        
        let actionSheet = UIAlertController(title: "You tapped on \(cities[indexPath.row])", message: "What would you like to do?", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Send Notification", style: .default, handler: { (_) in
            
            let vc = UIViewController()
            vc.preferredContentSize = CGSize(width: 250,height: 300)
            self.pickerView.datePickerMode = .dateAndTime
            vc.view.addSubview(self.pickerView)
            
            let editRadiusAlert = UIAlertController(title: "At what time?", message: "", preferredStyle: UIAlertController.Style.alert)
            editRadiusAlert.setValue(vc, forKey: "contentViewController")
            editRadiusAlert.addAction(UIAlertAction(title: "Set Notification", style: .default, handler: { (_) in
            }))
            
            editRadiusAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            self.present(editRadiusAlert, animated: true)

            self.notificationGenerator.notificationOccurred(.success)
            
            
            
            
        }))
        actionSheet.addAction(UIAlertAction(title: "Delete \(cities[indexPath.row])", style: .destructive, handler: { (_) in
            
            finalListOfTimes.remove(at: indexPath.row)
            cities.remove(at: indexPath.row)
            savedLocation.remove(at: indexPath.row)
            UserDefaults.standard.setValue(finalListOfTimes, forKey: "finalListOfTimes")
            UserDefaults.standard.set(cities, forKey: "cities")
            UserDefaults.standard.set(savedLocation, forKey: "savedLocation")
            
            tableView.reloadData()
        }))
      //  self.present(actionSheet, animated: true, completion: nil)
        
        
       }
    
    
    func showPickerAndSendNotification()
    {
        
    }
    
    @objc func valueDidChange()
    {
        let pd = self.pickerView.date
        let calender = Calendar.current
        realTimeComp = calender.dateComponents([.day,.hour, .minute], from: pd)
        
    }
    
    func getTimeWith(timeZone: TimeZone) -> String
    {
        var timeString = ""

            let formatter = DateFormatter()
            formatter.timeStyle = .short
            formatter.timeZone = timeZone
            
            let timeNow = Date()
            timeString = formatter.string(from: timeNow)

        return timeString
    }
    
    
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
    
}
