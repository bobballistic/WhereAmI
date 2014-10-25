//
//  ViewController.swift
//  WhereAmI
//
//  Created by Bob on 25/10/2014.
//  Copyright (c) 2014 BallisticSoft. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {

    
    var manager = CLLocationManager()
    
    @IBOutlet var latitudeLable: UILabel!
    @IBOutlet var longitudeLable: UILabel!
    @IBOutlet var courseLable: UILabel!
    @IBOutlet var speedLable: UILabel!
    @IBOutlet var altitudeLable: UILabel!
    @IBOutlet var nearestAddressLable: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        let userLocation:CLLocation = locations[0] as CLLocation
        let latitudeByLocation = userLocation.coordinate.latitude
        let longitudeByLocation = userLocation.coordinate.longitude
        let courseByLocation = userLocation.course
        let altitudeByLocation = userLocation.altitude
        let speedByLocation = userLocation.speed
        
        CLGeocoder().reverseGeocodeLocation(userLocation, completionHandler: {(placemarks, error)->Void in
            if error != nil {println(error)}
            else {

                let p = CLPlacemark(placemark: placemarks?[0] as CLPlacemark)
                var subThoroughfare = ""
                var thoroughfare = ""
                var subLocality = ""
                var subAdministrativeArea = ""
                if (p.subThoroughfare? != nil) {
                    subThoroughfare = p.subThoroughfare
                } else {
                    subThoroughfare = ""
                }
                
                if (p.thoroughfare? != nil) {
                    thoroughfare = p.thoroughfare
                } else {
                    thoroughfare = ""
                }
                
                if (p.subLocality != nil) {
                    subLocality = p.subLocality
                } else {
                    subLocality = ""
                }
                
                if (p.subAdministrativeArea != nil) {
                    subAdministrativeArea = p.subAdministrativeArea
                } else {
                    subAdministrativeArea = ""
                }
                
                self.nearestAddressLable.text = "\(subThoroughfare) \(p.thoroughfare) \n \(p.subLocality) \n \(p.subAdministrativeArea) \n \(p.postalCode) \n \(p.country))"
            
                
            }
            
        
        
        })
        
        // --------- location to screen -------
       
        latitudeLable.text = "\(latitudeByLocation)"
        longitudeLable.text = "\(longitudeByLocation)"
        courseLable.text = "\(courseByLocation)"
        speedLable.text = "\(speedByLocation)"
        altitudeLable.text = "\(altitudeByLocation)"
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

