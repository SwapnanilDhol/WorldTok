//
//  CityTimeScreen.swift
//  WorldTok
//
//  Created by Swapnanil Dhol on 10/18/19.
//  Copyright © 2019 Swapnanil Dhol. All rights reserved.
//

import UIKit
import MapKit


class CityTimeScreen: UIViewController, MKMapViewDelegate{

    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var timePicker: UIDatePicker!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var timeLabel: UILabel!
    var timer = Timer()
    
    let notificationGenerator = UINotificationFeedbackGenerator()
    let feedbackGenerator = UIImpactFeedbackGenerator()
    let blurEffect = UIBlurEffect(style: .dark)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.backgroundColor = .clear
        let blurredEffectView = UIVisualEffectView(effect: blurEffect)
        blurredEffectView.frame = mapView.bounds
       // view.addSubview(blurredEffectView)
        
        
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(setTime), userInfo: nil, repeats: true)
        RunLoop.current.add(timer, forMode: .common)
        self.timePicker.datePickerMode = .time
        self.timePicker.timeZone = TimeZone(identifier: "Europe/Paris")
        mapView.alpha = 0.5
        
        
        setupMapAnnotation()
        
    }
    

    
    func setupMapAnnotation()
    {
        let london = MKPointAnnotation()
        let coordianteSpan = MKCoordinateSpan(latitudeDelta: 100,longitudeDelta: 100)
        let coordinateRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 19.0760, longitude: 72.8777), span: coordianteSpan)
        london.title = "Mumbai"
        london.coordinate = CLLocationCoordinate2D(latitude: 19.0760, longitude: 72.8777)
        self.mapView.setRegion(coordinateRegion, animated: true)
        mapView.addAnnotation(london)
    }
    
    
    @objc func setTime()
    {
        timeLabel.text = getTime()
        feedbackGenerator.impactOccurred(intensity: 0.4)
        
    }
    override func viewDidDisappear(_ animated: Bool) {
        timer.invalidate()
        
    }
    
    func getTime() -> String
    {
        var timeString = ""
        
        if cityLabel.text != ""
        {
            let formatter = DateFormatter()
            formatter.timeStyle = .long
            formatter.timeZone = TimeZone(identifier: "Europe/Paris")
            
            let timeNow = Date()
            timeString = formatter.string(from: timeNow)
              
        }
        let time = timeString.strstr(needle: "M",beforeNeedle: true)
       
        
        timeString = time!
        
        return timeString + "M"
    }
    
    @IBAction func setNotification(_ sender: Any) {
        notificationGenerator.notificationOccurred(.success)
    }
    
}

extension CityTimeScreen
{
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is MKPointAnnotation else { return nil }

        let identifier = "Annotation"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)

        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView!.canShowCallout = true
        } else {
            annotationView!.annotation = annotation
        }

        return annotationView
    }
}
