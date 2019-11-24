//
//  RouteOverlay.swift
//  bus_alarm
//
//  Created by Zisheng Wang on 11/23/19.
//  Copyright © 2019 Zisheng Wang. All rights reserved.
//

import Foundation
import MapKit
import UIKit

class RouteOverlayRenderer: MKPolylineRenderer {
    
    var overlayHolder: MKOverlay!
    
    override init(overlay: MKOverlay){
        super.init(overlay: overlay)
        self.overlayHolder = overlay
    }
    
    override func draw(_ mapRect: MKMapRect, zoomScale: MKZoomScale, in context: CGContext) {
        if zoomScale < 0.125 {
            self.lineWidth = 5
        }else{
            self.lineWidth = 10
        }
//        print(zoomScale)
//        print(self.lineWidth)
        super.draw(mapRect, zoomScale: zoomScale, in: context)
    }
}

class CCRouteData {
    static let data = [
        // iccoca loop
        [CLLocationCoordinate2D(latitude: 40.599860, longitude: -75.361796), CLLocationCoordinate2D(latitude: 40.600901, longitude: -75.357721),
        CLLocationCoordinate2D(latitude: 40.601127, longitude: -75.357360), CLLocationCoordinate2D(latitude: 40.601511, longitude: -75.357080),
        CLLocationCoordinate2D(latitude: 40.601880, longitude: -75.357188), CLLocationCoordinate2D(latitude: 40.602038, longitude: -75.357495),
        CLLocationCoordinate2D(latitude: 40.602175, longitude: -75.358316), CLLocationCoordinate2D(latitude: 40.602648, longitude: -75.359101),
        CLLocationCoordinate2D(latitude: 40.602613, longitude: -75.359471), CLLocationCoordinate2D(latitude: 40.601675, longitude: -75.360941),
        CLLocationCoordinate2D(latitude: 40.601456, longitude: -75.362268), CLLocationCoordinate2D(latitude: 40.601380, longitude: -75.362980),
        CLLocationCoordinate2D(latitude: 40.601216, longitude: -75.363919), CLLocationCoordinate2D(latitude: 40.600442, longitude: -75.365684),
        CLLocationCoordinate2D(latitude: 40.599483, longitude: -75.365335), CLLocationCoordinate2D(latitude: 40.599367, longitude: -75.365028),
        CLLocationCoordinate2D(latitude: 40.599846, longitude: -75.363296), CLLocationCoordinate2D(latitude: 40.599846, longitude: -75.361934)],
        [CLLocationCoordinate2D(latitude: 40.601196, longitude: -75.363928), CLLocationCoordinate2D(latitude: 40.601593, longitude: -75.363188),
         CLLocationCoordinate2D(latitude: 40.601949, longitude: -75.362168), CLLocationCoordinate2D(latitude: 40.602565, longitude: -75.361347),
         CLLocationCoordinate2D(latitude: 40.603079, longitude: -75.361131), CLLocationCoordinate2D(latitude: 40.604148, longitude: -75.361257),
         CLLocationCoordinate2D(latitude: 40.604203, longitude: -75.360860)],
        [CLLocationCoordinate2D(latitude: 40.601593, longitude: -75.363188), CLLocationCoordinate2D(latitude: 40.601374, longitude: -75.363107)],
        [CLLocationCoordinate2D(latitude: 40.600415, longitude: -75.365696),CLLocationCoordinate2D(latitude: 40.600157, longitude: -75.366860),
         CLLocationCoordinate2D(latitude: 40.599821, longitude: -75.367254),CLLocationCoordinate2D(latitude: 40.599399, longitude: -75.367369),
         CLLocationCoordinate2D(latitude: 40.598731, longitude: -75.366756),CLLocationCoordinate2D(latitude: 40.598547, longitude: -75.365232),
         CLLocationCoordinate2D(latitude: 40.598862, longitude: -75.363592),CLLocationCoordinate2D(latitude: 40.598692, longitude: -75.362546),
         CLLocationCoordinate2D(latitude: 40.598081, longitude: -75.361963),CLLocationCoordinate2D(latitude: 40.597519, longitude: -75.362131),
         CLLocationCoordinate2D(latitude: 40.596869, longitude: -75.362935),CLLocationCoordinate2D(latitude: 40.595852, longitude: -75.365231),
         CLLocationCoordinate2D(latitude: 40.595009, longitude: -75.366571),CLLocationCoordinate2D(latitude: 40.593798, longitude: -75.367898),
         CLLocationCoordinate2D(latitude: 40.592519, longitude: -75.368536),CLLocationCoordinate2D(latitude: 40.591531, longitude: -75.368587),
         CLLocationCoordinate2D(latitude: 40.590010, longitude: -75.368217),CLLocationCoordinate2D(latitude: 40.588528, longitude: -75.367426),
         CLLocationCoordinate2D(latitude: 40.586619, longitude: -75.365525),CLLocationCoordinate2D(latitude: 40.585582, longitude: -75.364415),
         CLLocationCoordinate2D(latitude: 40.584323, longitude: -75.363432),CLLocationCoordinate2D(latitude: 40.583499, longitude: -75.363050),
         CLLocationCoordinate2D(latitude: 40.581842, longitude: -75.362756),CLLocationCoordinate2D(latitude: 40.580999, longitude: -75.362782),
         CLLocationCoordinate2D(latitude: 40.580020, longitude: -75.363203),CLLocationCoordinate2D(latitude: 40.579245, longitude: -75.360370),
         CLLocationCoordinate2D(latitude: 40.578072, longitude: -75.358788),CLLocationCoordinate2D(latitude: 40.578489, longitude: -75.352587),
         CLLocationCoordinate2D(latitude: 40.578896, longitude: -75.352996),CLLocationCoordinate2D(latitude: 40.579167, longitude: -75.353991),
         CLLocationCoordinate2D(latitude: 40.579284, longitude: -75.355560),CLLocationCoordinate2D(latitude: 40.579167, longitude: -75.356441),
         CLLocationCoordinate2D(latitude: 40.578751, longitude: -75.357525),CLLocationCoordinate2D(latitude: 40.578333, longitude: -75.357883),
         CLLocationCoordinate2D(latitude: 40.578086, longitude: -75.357928)],
        [CLLocationCoordinate2D(latitude: 40.584312, longitude: -75.363440),CLLocationCoordinate2D(latitude: 40.584792, longitude: -75.362226),
         CLLocationCoordinate2D(latitude: 40.584779, longitude: -75.362272),CLLocationCoordinate2D(latitude: 40.585078, longitude: -75.361817),
         CLLocationCoordinate2D(latitude: 40.585378, longitude: -75.361612),CLLocationCoordinate2D(latitude: 40.585499, longitude: -75.361362),
         CLLocationCoordinate2D(latitude: 40.586040, longitude: -75.355459),
         CLLocationCoordinate2D(latitude: 40.586156, longitude: -75.355490),CLLocationCoordinate2D(latitude: 40.585602, longitude: -75.361437),
         CLLocationCoordinate2D(latitude: 40.585407, longitude: -75.361840),CLLocationCoordinate2D(latitude: 40.584802, longitude: -75.362280)]
    ]
}
