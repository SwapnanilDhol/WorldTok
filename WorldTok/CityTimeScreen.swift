//
//  CityTimeScreen.swift
//  WorldTok
//
//  Created by Swapnanil Dhol on 10/18/19.
//  Copyright © 2019 Swapnanil Dhol. All rights reserved.
//

import UIKit
import MapKit
import Lottie


var globalIndex = 0

class CityTimeScreen: UIViewController, MKMapViewDelegate{
    
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var placeDateLabel: UILabel!
    var realTimeComp = DateComponents()
    var timer = Timer()
    
    let notificationGenerator = UINotificationFeedbackGenerator()
    let feedbackGenerator = UIImpactFeedbackGenerator()
    let center = UNUserNotificationCenter.current()
    let pickerView = UIDatePicker(frame: CGRect(x: 0, y: 0, width: 250, height: 300))
    var message = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.backgroundColor = .clear
        self.title = cities[globalIndex]
        cityLabel.text = cities[globalIndex]
        pickerView.addTarget(self, action: #selector(valueDidChange), for: .valueChanged)
        cityLabel.alpha = 0
        mapView.mapType = .satellite
        setMap()
        placeDateLabel.text = getDayDifference()
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(setTime), userInfo: nil, repeats: true)
        RunLoop.current.add(timer, forMode: .common)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setAnimations()
        
    }
    @objc func valueDidChange()
    {
        let pd = self.pickerView.date
        let calender = Calendar.current
        realTimeComp = calender.dateComponents([.day,.hour, .minute], from: pd)
    }
    
    func setMap()
    {
        
        let center = CLLocationCoordinate2D(latitude: savedLat[globalIndex], longitude: savedLong[globalIndex])
        mapView.setCenter(center, animated: true)
        mapView.layer.cornerRadius = 8
        
    }
    
    func getDayDifference() -> String
    {
        let timeNow = Date()
        
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(identifier: finalListOfTimes[globalIndex])
        dateFormatter.dateFormat = "dd-MM-yyyy"
        return dateFormatter.string(from: timeNow)
        
        
    }
    
    func setAnimations()
    {
        UIView.animate(withDuration: 1) {
            self.mapView.alpha = 0.4
            self.cityLabel.alpha = 1
            
        }
    }
    @objc func setTime()
    {
        timeLabel.text = getTime()
        // feedbackGenerator.impactOccurred(intensity: 0.4)
        
    }
    override func viewDidDisappear(_ animated: Bool) {
        timer.invalidate()
        
    }
    
    func getTime() -> String
    {
        var timeString = ""
        
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        formatter.timeZone = TimeZone(identifier: finalListOfTimes[globalIndex])
        
        let timeNow = Date()
        timeString = formatter.string(from: timeNow)
        
        return timeString
    }
    
    @IBAction func setNotification(_ sender: Any) {
        
        let vc = UIViewController()
        vc.preferredContentSize = CGSize(width: 250,height: 300)
        pickerView.datePickerMode = .dateAndTime
        vc.view.addSubview(pickerView)
        feedbackGenerator.impactOccurred(intensity: 0.5)
        
        let editRadiusAlert = UIAlertController(title: "At what time?\nThe time right now at \(cityLabel.text!) is \(getTime())", message: "", preferredStyle: UIAlertController.Style.alert)
        editRadiusAlert.setValue(vc, forKey: "contentViewController")
        editRadiusAlert.addAction(UIAlertAction(title: "Set Notification", style: .default, handler: { (_) in

            let messageAlert = UIAlertController(title: "Enter Message", message: "What is this alert about?", preferredStyle: .alert)
            messageAlert.addTextField()
            
            let submitAction = UIAlertAction(title: "Submit", style: .default) { [unowned messageAlert] _ in
                
                let answer = messageAlert.textFields![0]
                if answer.text != ""
                {
                    self.message = answer.text!
                }
                
                //DEBUG:
                
                //print("Picker Value: Set, Message Value is \(self.message)")
                
                self.dismiss(animated: true, completion: nil)
                self.setNotificationWith(givenTimeZone: TimeZone(identifier: finalListOfTimes[globalIndex])!,message: self.message, cityName: cities[globalIndex],date: self.realTimeComp.day! ,hour: self.realTimeComp.hour!, minute: self.realTimeComp.minute! )
                
            }
            messageAlert.addAction(submitAction)
            self.present(messageAlert, animated: true, completion: nil)
        }))
        editRadiusAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(editRadiusAlert, animated: true)
        feedbackGenerator.impactOccurred()
        
    }
    
}

extension CityTimeScreen: UIPickerViewDelegate
{
    
    
    
    
}

