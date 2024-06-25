//
//  GoogleMapViewController.swift
//  MapLocation
//
//  Created by Arpit iOS Dev. on 25/06/24.
//

import UIKit
import WebKit
import CoreLocation

class GoogleMapViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var webView: WKWebView!
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        
        let latitude = location.coordinate.latitude
        let longitude = location.coordinate.longitude
        
//        let urlString = "https://www.google.com/maps?q=\(latitude),\(longitude)&z=15&output=embed"
//        if let url = URL(string: urlString) {
//            let request = URLRequest(url: url)
//            webView.load(request)
//        }
        
        let iframeHTML = """
               <html>
               <head>
               <meta name="viewport" content="initial-scale=1.0, user-scalable=no" />
               <meta charset="utf-8">
               <style>
                 html, body {
                   height: 100%;
                   margin: 0;
                   padding: 0;
                 }
                 #map {
                   height: 100%;
                 }
               </style>
               </head>
               <body>
                 <iframe
                   width="100%"
                   height="100%"
                   frameborder="0" style="border:0"
                   src="https://www.google.com/maps/embed/v1/view?key=YOUR_API_KEY&center=\(latitude),\(longitude)&zoom=15" allowfullscreen>
                 </iframe>
               </body>
               </html>
               """
               
               // Load the iframe HTML in the WKWebView
               webView.loadHTMLString(iframeHTML, baseURL: nil)
        
        locationManager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse || status == .authorizedAlways {
            locationManager.startUpdatingLocation()
        } else {
            print("Location services are not authorized")
        }
    }
}
