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
    @IBOutlet weak var topAnimationView : LottieView!
    
    var realTimeComp = DateComponents()
    var timer = Timer()

    let notificationGenerator = UINotificationFeedbackGenerator()
    let feedbackGenerator = UIImpactFeedbackGenerator()
    let center = UNUserNotificationCenter.current()
    let pickerView = UIDatePicker(frame: CGRect(x: 0, y: 0, width: 250, height: 300))
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.backgroundColor = .clear
        print(finalListOfTimes[globalIndex], cities[globalIndex])
        cityLabel.text = cities[globalIndex]
        pickerView.addTarget(self, action: #selector(valueDidChange), for: .valueChanged)
        
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(setTime), userInfo: nil, repeats: true)
        RunLoop.current.add(timer, forMode: .common)

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupLottie()
    }
    @objc func valueDidChange()
    {
        let pd = self.pickerView.date
        let calender = Calendar.current
        realTimeComp = calender.dateComponents([.day,.hour, .minute], from: pd)
        print(realTimeComp)
    }
    
    func setupLottie()
    {
        let animationView = AnimationView(name: "2222-slow-clock")
        animationView.frame = topAnimationView.bounds
        animationView.center = self.topAnimationView.center
            
        animationView.loopMode = .autoReverse
        animationView.contentMode = .scaleAspectFit
        animationView.animationSpeed = 1.0
        
        topAnimationView.addSubview(animationView)
        
            animationView.play()
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
        
        
        let editRadiusAlert = UIAlertController(title: "At what time?", message: "", preferredStyle: UIAlertController.Style.alert)
        editRadiusAlert.setValue(vc, forKey: "contentViewController")
        editRadiusAlert.addAction(UIAlertAction(title: "Set Notification", style: .default, handler: { (_) in

            self.setNotificationWith(givenTimeZone: TimeZone(identifier: finalListOfTimes[globalIndex])!, cityName: cities[globalIndex],date: self.realTimeComp.day! ,hour: self.realTimeComp.hour!, minute: self.realTimeComp.minute! )
            
        }))
        editRadiusAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(editRadiusAlert, animated: true)

        notificationGenerator.notificationOccurred(.success)

    }
    
}

extension CityTimeScreen: UIPickerViewDelegate
{
    
}

