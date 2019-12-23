//
//  busClass.swift
//  bus_alarm
//
//  Created by Zisheng Wang on 11/14/19.
//  Copyright © 2019 Zisheng Wang. All rights reserved.
//

import Foundation
import MapKit
import UIKit
import SwiftyJSON

class busClass {
    var lat = 0.0
    var long = 0.0
    var name = "CC"
    var bound = true
    var currentstop = ""
    var laststop = ""
    var fleetnum = 0
    var used = true
    var busAnnotation = MKPointAnnotation()
    init(j: JSON, mapview: MKMapView) {
        if ( j["lat"].string != nil){
            self.lat = Double(j["lat"].string!)!
        }
        if ( j["long"].string != nil){
            self.long = Double(j["long"].string!)!
        }
        if ( j["currentstop"].string != nil ){
            self.currentstop = j["currentstop"].string!
        }
        if ( j["laststop"].string != nil){
            self.laststop = j["laststop"].string!
        }
        if ( j["fleetnum"].string != nil ){
            self.fleetnum = Int(j["fleetnum"].string!)!
        }
        if (j["name"].string != nil){
            self.name = j["name"].string!;
        }
        busAnnotation.coordinate = CLLocation(latitude: self.lat, longitude: self.long).coordinate
        busAnnotation.title = self.name
        busAnnotation.subtitle = String(self.fleetnum)
        mapview.addAnnotation(busAnnotation)
    }
    init(name: String, coordinate: CLLocationCoordinate2D, mapview: MKMapView){
        busAnnotation.coordinate = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude).coordinate
        self.lat = coordinate.latitude
        self.long = coordinate.longitude
        self.name = name
        busAnnotation.title = name
        busAnnotation.subtitle = String(self.fleetnum)
        mapview.addAnnotation(busAnnotation)
        self.used = false
    }
    func updateBus(coordinate: CLLocationCoordinate2D, mapview: MKMapView){
        mapview.removeAnnotation(self.busAnnotation)
        busAnnotation.coordinate = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude).coordinate
        self.lat = busAnnotation.coordinate.latitude
        self.long = busAnnotation.coordinate.longitude
        mapview.addAnnotation(self.busAnnotation)
    }
    func updateBus(j: JSON){
        if ( j["lat"].string != nil)  { self.lat = Double(j["lat"].string!)! }
        if ( j["long"].string != nil) { self.long = Double(j["long"].string!)! }
        if ( j["currentstop"].string != nil ) { self.currentstop = j["currentstop"].string! }
        if ( j["laststop"].string != nil){ self.laststop = j["laststop"].string! }
        if ( j["fleetnum"].string != nil ){ self.fleetnum = Int(j["fleetnum"].string!)!}
        //mapview.removeAnnotation(self.busAnnotation)
        //busAnnotation.coordinate = CLLocation(latitude: self.lat, longitude: self.long).coordinate
        //busAnnotation.title = self.name
        //busAnnotation.subtitle = self.name
        //mapview.addAnnotation(busAnnotation)
    }
}
