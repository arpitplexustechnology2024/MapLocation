//
//  ViewController.swift
//  MapLocation
//
//  Created by Arpit iOS Dev. on 24/06/24.
//

import UIKit
import CoreLocation
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate {

    let locationManager = CLLocationManager()
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var latitudeLabel: UILabel!
    @IBOutlet weak var longitudeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
           guard let location = locations.last else { return }
           let coordinate = location.coordinate
           
           latitudeLabel.text = "Latitude: \(coordinate.latitude)"
           longitudeLabel.text = "Longitude: \(coordinate.longitude)"
           
           let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
           mapView.setRegion(region, animated: true)
           
           let annotation = MKPointAnnotation()
           annotation.coordinate = coordinate
           annotation.title = "Your Location"
           mapView.addAnnotation(annotation)
           
           manager.stopUpdatingLocation()
       }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .denied {
            print("Location access denied")
        } else if status == .notDetermined {
            print("Location status not determined")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location manager failed with error: \(error.localizedDescription)")
    }
}
