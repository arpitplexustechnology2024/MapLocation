//
//  GoogleMapViewController.swift
//  MapLocation
//
//  Created by Arpit iOS Dev. on 25/06/24.
//

import UIKit
import GoogleMaps
import CoreLocation

class GoogleMapViewController: UIViewController, CLLocationManagerDelegate {
    
    var locationManager: CLLocationManager?
    var mapView: GMSMapView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.requestWhenInUseAuthorization()
        
        let camera = GMSCameraPosition.camera(withLatitude: 0, longitude: 0, zoom: 15.0)
        mapView = GMSMapView.map(withFrame: view.bounds, camera: camera)
        mapView?.isMyLocationEnabled = true
        view.addSubview(mapView!)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            let latitude = location.coordinate.latitude
            let longitude = location.coordinate.longitude
            
            mapView?.camera = GMSCameraPosition.camera(withLatitude: latitude, longitude: longitude, zoom: 15.0)
            
            let marker = GMSMarker()
            marker.position = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
            marker.title = "Current Location"
            marker.map = mapView
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            locationManager?.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed to find user's location: \(error.localizedDescription)")
    }
}
