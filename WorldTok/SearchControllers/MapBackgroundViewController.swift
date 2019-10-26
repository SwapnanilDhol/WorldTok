
//
//  MapBackgroundController.swift
//  Saviourth
//
//  Created by Swapnanil Dhol on 10/18/19.
//  Copyright © 2019 Swapnanil Dhol. All rights reserved.
//

import UIKit
import MapKit


protocol HandleMapSearch {
    func dropPinZoomIn(placemark:MKPlacemark)
    func currentTimeThere(timezone:String)
}

class MapBackgroundController: UIViewController, UIGestureRecognizerDelegate {
    
    @IBOutlet weak var mapView : MKMapView!

    let locationManager = CLLocationManager()
    var resultSearchController:UISearchController? = nil
    var selectedPin:MKPlacemark? = nil
    let notificationGenerator = UINotificationFeedbackGenerator()
    var locationCoordinate = CLLocationCoordinate2D(latitude: 0, longitude: 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
        let gestureZ = UILongPressGestureRecognizer(target: self, action: #selector(revealRegionDetailsWithLongPressOnMap(sender:)))
        mapView.addGestureRecognizer(gestureZ)
        
        
        let locationSearchTable = storyboard?.instantiateViewController(identifier: "LocationSearchTable") as! LocationSearchTable
        resultSearchController = UISearchController(searchResultsController: locationSearchTable)
        resultSearchController?.searchResultsUpdater = locationSearchTable
        locationSearchTable.mapView = mapView
        locationSearchTable.handleMapSearchDelegate = self
        
        let searchBar = resultSearchController!.searchBar
        searchBar.sizeToFit()
        searchBar.placeholder = "Search for places"
        navigationItem.searchController = resultSearchController
        
        
        resultSearchController?.hidesNavigationBarDuringPresentation = false
        resultSearchController?.obscuresBackgroundDuringPresentation = true
        definesPresentationContext = true
        
        NotificationCenter.default.addObserver(self, selector: #selector(dismissAll), name: .init("dismissParent"), object: nil)
    }
    
    @IBAction func revealRegionDetailsWithLongPressOnMap(sender: UILongPressGestureRecognizer) {
        if sender.state != UIGestureRecognizer.State.began { return }
        let touchLocation = sender.location(in: mapView)
         locationCoordinate = mapView.convert(touchLocation, toCoordinateFrom: mapView)
        addAnnotation(location: locationCoordinate)
        
        notificationGenerator.notificationOccurred(.success)
    }
    
    @IBAction func dismissVc(_ sender: Any) {
       
        dismissAll()
    }
    
    @objc func dismissAll()
    {
        self.dismiss(animated: true, completion: {
                   self.presentingViewController?.dismiss(animated: true, completion: nil)
               })
    }
    

}

extension MapBackgroundController : CLLocationManagerDelegate
{
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        if status == .authorizedWhenInUse
        {locationManager.requestLocation()}
        
    }
    
    
    
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {

    }
    
    func addAnnotation(location: CLLocationCoordinate2D){
            let annotation = MKPointAnnotation()
            annotation.coordinate = location
            annotation.title = "Dropped Pin"
            annotation.subtitle = "Select this?"
            self.mapView.addAnnotation(annotation)
            self.mapView.showAnnotations([annotation], animated: true)
    }
    
    
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error:: \(error)")
    }
}
extension MapBackgroundController: HandleMapSearch {
    func currentTimeThere(timezone: String) {
        
        
        
    }
    
    
    func dropPinZoomIn(placemark:MKPlacemark){
        // cache the pin
        selectedPin = placemark
        // clear existing pins
        mapView.removeAnnotations(mapView.annotations)
        let annotation = MKPointAnnotation()
        annotation.coordinate = placemark.coordinate
        annotation.title = placemark.name
        if let city = placemark.locality,
        let state = placemark.administrativeArea {
            annotation.subtitle = "\(city) \(state)"
        }
        mapView.addAnnotation(annotation)
        let span = MKCoordinateSpan(latitudeDelta: 0.10, longitudeDelta: 0.10)
        
        let region = MKCoordinateRegion(center: placemark.coordinate, span: span)
        mapView.setRegion(region, animated: true)
    }
}

extension MapBackgroundController : MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView?{
        if annotation is MKUserLocation {
    
            return nil
        }
        let reuseId = "pin"
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView
        pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
        pinView?.pinTintColor = .systemRed
        pinView?.canShowCallout = true
        
        let smallSquare = CGSize(width: 30, height: 30)
        let button = UIButton(frame: CGRect(origin: .zero, size: smallSquare))
        button.setBackgroundImage(UIImage(systemName: "plus"), for: .normal)
        button.addTarget(self, action: #selector(getTime), for: .touchUpInside)
        pinView?.leftCalloutAccessoryView = button
        return pinView
    }
    
    
    
    @objc func getTime(){
        
        convertLatLongToAddress(latitude: locationCoordinate.latitude, longitude: locationCoordinate.longitude)
    }
}

extension MapBackgroundController {
    
    func convertLatLongToAddress(latitude:Double,longitude:Double){

          let geoCoder = CLGeocoder()
          let location = CLLocation(latitude: latitude, longitude: longitude)
          geoCoder.reverseGeocodeLocation(location, completionHandler: { (placemarks, error) -> Void in

              // Place details
              var placeMark: CLPlacemark!
              placeMark = placemarks?[0]
              
              if let timeZone = placeMark.timeZone
              {
                 let formatter = DateFormatter()
                  formatter.timeStyle = .long
                  formatter.timeZone = timeZone

                  let timeNow = Date()
                _ = formatter.string(from: timeNow)
                  
                let ac = UIAlertController(title: "Do you want to add this?", message: "Do you want to add \((placeMark.administrativeArea) ?? "Unknown Area") who is following \(placeMark.timeZone ?? timeZone)", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (_) in
                    let tzString : String = "\(timeZone)"
                    let editedTime = tzString.replacingOccurrences(of: " (current)", with: "")
                    finalListOfTimes.append(editedTime.replacingOccurrences(of: " (fixed)", with: ""))
                    cities.append((placeMark.administrativeArea ?? "Unknown") + ", " + (placeMark.country ?? "Unknown"))
                    
                    NotificationCenter.default.post(name: .init("dismissParent"), object: nil)
                }))
                ac.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                self.present(ac, animated: true, completion: nil)
                  
              }
          })

      }
}


