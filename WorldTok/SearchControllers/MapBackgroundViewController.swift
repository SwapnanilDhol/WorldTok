
//
//  MapBackgroundController.swift
//  Saviourth
//
//  Created by Swapnanil Dhol on 10/18/19.
//  Copyright © 2019 Swapnanil Dhol. All rights reserved.
//

import UIKit
import MapKit

class MapBackgroundController: UIViewController {
    
    @IBOutlet weak var mapView : MKMapView!
    
    
    let locationManager = CLLocationManager()
    var resultSearchController:UISearchController? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
        
        let locationSearchTable = storyboard?.instantiateViewController(identifier: "LocationSearchTable") as! LocationSearchTable
        resultSearchController = UISearchController(searchResultsController: locationSearchTable)
        resultSearchController?.searchResultsUpdater = locationSearchTable
        locationSearchTable.mapView = mapView
        
        let searchBar = resultSearchController!.searchBar
        searchBar.sizeToFit()
        searchBar.placeholder = "Search for places"
        navigationItem.titleView = resultSearchController?.searchBar
        
        resultSearchController?.hidesNavigationBarDuringPresentation = false
        resultSearchController?.obscuresBackgroundDuringPresentation = true
        definesPresentationContext = true
    }
    
    @IBAction func dismissVc(_ sender: Any) {
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
        if let location = locations.last{
            let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
            self.mapView.setRegion(region, animated: true)
        }
    }
    
    
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error:: \(error)")
    }
}


