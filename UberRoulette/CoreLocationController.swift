//
//  CoreLocationController.swift
//  UberRoulette
//
//  Created by Samuel Raudabaugh on 9/20/15.
//  Copyright © 2015 Cornell Tech. All rights reserved.
//

import UIKit

class CoreLocationController: NSObject, CLLocationManagerDelegate {
    let locationManager = CLLocationManager()
    
    override init() {
        super.init()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if (CLLocationManager.authorizationStatus() == CLAuthorizationStatus.AuthorizedAlways ||
            CLLocationManager.authorizationStatus() == CLAuthorizationStatus.AuthorizedWhenInUse) {
                print("Authorized")
                manager.startUpdatingLocation()
                
        } else if (CLLocationManager.authorizationStatus() == CLAuthorizationStatus.Denied) {
            print("Denied")
        } else if (CLLocationManager.authorizationStatus() == CLAuthorizationStatus.NotDetermined) {
            print("NotDetermined")
        } else if (CLLocationManager.authorizationStatus() == CLAuthorizationStatus.Restricted) {
            print("Restricted")
        } else {
            print("Unknown")
        }
    }

}
