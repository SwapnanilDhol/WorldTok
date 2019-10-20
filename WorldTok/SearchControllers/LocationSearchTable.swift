//
//  LocationSearchTable.swift
//  Saviourth
//
//  Created by Swapnanil Dhol on 10/20/19.
//  Copyright © 2019 Swapnanil Dhol. All rights reserved.
//

import UIKit
import MapKit

class LocationSearchTable: UITableViewController {
    

    var matchingItems:[MKMapItem] = []
    var mapView: MKMapView? = nil
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        tableView.tableFooterView = UIView()
    }

}

extension LocationSearchTable : UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {

        guard let mapView = mapView,
               let searchBarText = searchController.searchBar.text else { return }
        let request = MKLocalSearch.Request()
           request.naturalLanguageQuery = searchBarText
           request.region = mapView.region
           let search = MKLocalSearch(request: request)
        search.start { response, _ in
               guard let response = response else {
                   return
               }
               self.matchingItems = response.mapItems
               self.tableView.reloadData()

    }
    }
    

    func updateSearchResultsForSearchController(searchController: UISearchController) {
        
}
    
    
    func parseAddress(selectedItem:MKPlacemark) -> String {
        // put a space between "4" and "Melrose Place"
        let firstSpace = (selectedItem.subThoroughfare != nil && selectedItem.thoroughfare != nil) ? " " : ""
        // put a comma between street and city/state
        let comma = (selectedItem.subThoroughfare != nil || selectedItem.thoroughfare != nil) && (selectedItem.subAdministrativeArea != nil || selectedItem.administrativeArea != nil) ? ", " : ""
        // put a space between "Washington" and "DC"
        let secondSpace = (selectedItem.subAdministrativeArea != nil && selectedItem.administrativeArea != nil) ? " " : ""
        let addressLine = String(
            format:"%@%@%@%@%@%@%@",
            // street number
            selectedItem.subThoroughfare ?? "",
            firstSpace,
            // street name
            selectedItem.thoroughfare ?? "",
            comma,
            // city
            selectedItem.locality ?? "",
            secondSpace,
            // state
            selectedItem.administrativeArea ?? ""
        )
        print(addressLine)
        return addressLine
    }
    
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
                let timeString = formatter.string(from: timeNow)
                print(timeString)
                let tzString : String = "\(timeZone)"
                finalListOfTimes.append(tzString.replacingOccurrences(of: " (fixed)", with: ""))
                self.dismiss(animated: true, completion: nil)
                
            }
        })

    }

}

extension LocationSearchTable {

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return matchingItems.count
    }

   
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        let selectedItem = matchingItems[indexPath.row].placemark
        cell.textLabel?.text = selectedItem.name
        cell.detailTextLabel?.text = parseAddress(selectedItem: selectedItem)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        getCoordinateFrom(address: matchingItems[indexPath.row].placemark.name ?? "Moscow, Russia") { (locationCoordinates, error) in
            
            if error == nil
            {
                self.convertLatLongToAddress(latitude: locationCoordinates!.latitude, longitude: locationCoordinates!.longitude)
            }
        }
       
        
        
    }
    
    func getCoordinateFrom(address: String, completion: @escaping(_ coordinate: CLLocationCoordinate2D?, _ error: Error?) -> () ) {
               CLGeocoder().geocodeAddressString(address) { completion($0?.first?.location?.coordinate, $1) }
           }
    
    


    
}

