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
         CLLocationCoordinate2D(latitude: 40.585407, longitude: -75.361840),CLLocationCoordinate2D(latitude: 40.584802, longitude: -75.362280)],
        [CLLocationCoordinate2D(latitude: 40.600151, longitude: -75.366865),CLLocationCoordinate2D(latitude: 40.600054, longitude: -75.368207),
         CLLocationCoordinate2D(latitude: 40.599754, longitude: -75.367721),CLLocationCoordinate2D(latitude: 40.599298, longitude: -75.367338)],
        [CLLocationCoordinate2D(latitude: 40.600035, longitude: -75.368296),CLLocationCoordinate2D(latitude: 40.600685, longitude: -75.371936),
         CLLocationCoordinate2D(latitude: 40.600597, longitude: -75.371540),CLLocationCoordinate2D(latitude: 40.601422, longitude: -75.373660),
         CLLocationCoordinate2D(latitude: 40.602120, longitude: -75.374146),CLLocationCoordinate2D(latitude: 40.602808, longitude: -75.374146),
         CLLocationCoordinate2D(latitude: 40.603342, longitude: -75.373916),CLLocationCoordinate2D(latitude: 40.603807, longitude: -75.373481)],
        [CLLocationCoordinate2D(latitude: 40.602149, longitude: -75.374153),CLLocationCoordinate2D(latitude: 40.601799, longitude: -75.374703),
         CLLocationCoordinate2D(latitude: 40.601628, longitude: -75.375001),CLLocationCoordinate2D(latitude: 40.601656, longitude: -75.375190),
         CLLocationCoordinate2D(latitude: 40.601991, longitude: -75.375542),CLLocationCoordinate2D(latitude: 40.602245, longitude: -75.376300),
         CLLocationCoordinate2D(latitude: 40.602402, longitude: -75.377617),CLLocationCoordinate2D(latitude: 40.602375, longitude: -75.377996),
         CLLocationCoordinate2D(latitude: 40.602067, longitude: -75.378889),CLLocationCoordinate2D(latitude: 40.602005, longitude: -75.379377),
         CLLocationCoordinate2D(latitude: 40.602128, longitude: -75.379918),CLLocationCoordinate2D(latitude: 40.603026, longitude: -75.380956),
         CLLocationCoordinate2D(latitude: 40.603313, longitude: -75.381605),CLLocationCoordinate2D(latitude: 40.603423, longitude: -75.382092),
         CLLocationCoordinate2D(latitude: 40.603560, longitude: -75.382137),CLLocationCoordinate2D(latitude: 40.603676, longitude: -75.382011),
         CLLocationCoordinate2D(latitude: 40.603861, longitude: -75.380992),CLLocationCoordinate2D(latitude: 40.604005, longitude: -75.380712),
         CLLocationCoordinate2D(latitude: 40.603786, longitude: -75.380577),CLLocationCoordinate2D(latitude: 40.603505, longitude: -75.380098),
         CLLocationCoordinate2D(latitude: 40.603416, longitude: -75.379837),CLLocationCoordinate2D(latitude: 40.603464, longitude: -75.379223),
         CLLocationCoordinate2D(latitude: 40.603724, longitude: -75.378799),CLLocationCoordinate2D(latitude: 40.603882, longitude: -75.378312),
         CLLocationCoordinate2D(latitude: 40.604101, longitude: -75.376580),CLLocationCoordinate2D(latitude: 40.604019, longitude: -75.376192),
         CLLocationCoordinate2D(latitude: 40.603135, longitude: -75.375551),CLLocationCoordinate2D(latitude: 40.603080, longitude: -75.375091),
         CLLocationCoordinate2D(latitude: 40.603258, longitude: -75.374784),CLLocationCoordinate2D(latitude: 40.603663, longitude: -75.374378),
         CLLocationCoordinate2D(latitude: 40.603813, longitude: -75.374054),CLLocationCoordinate2D(latitude: 40.603806, longitude: -75.373503)],
        [CLLocationCoordinate2D(latitude: 40.604028, longitude: -75.380694),CLLocationCoordinate2D(latitude: 40.604163, longitude: -75.380489),
         CLLocationCoordinate2D(latitude: 40.604066, longitude: -75.379935),CLLocationCoordinate2D(latitude: 40.604077, longitude: -75.379730),
         CLLocationCoordinate2D(latitude: 40.604187, longitude: -75.379434),CLLocationCoordinate2D(latitude: 40.604423, longitude: -75.379002),
         CLLocationCoordinate2D(latitude: 40.604480, longitude: -75.378812),CLLocationCoordinate2D(latitude: 40.605148, longitude: -75.378934),
         CLLocationCoordinate2D(latitude: 40.605068, longitude: -75.379639),CLLocationCoordinate2D(latitude: 40.605327, longitude: -75.380678),
         CLLocationCoordinate2D(latitude: 40.605730, longitude: -75.381012),CLLocationCoordinate2D(latitude: 40.607953, longitude: -75.381103),
         CLLocationCoordinate2D(latitude: 40.608115, longitude: -75.379609),CLLocationCoordinate2D(latitude: 40.609779, longitude: -75.379692),
         CLLocationCoordinate2D(latitude: 40.609802, longitude: -75.378403),CLLocationCoordinate2D(latitude: 40.611461, longitude: -75.378486),
         CLLocationCoordinate2D(latitude: 40.611513, longitude: -75.375914),CLLocationCoordinate2D(latitude: 40.609905, longitude: -75.375841),
//         CLLocationCoordinate2D(latitude: 40.610476, longitude: -75.378425),CLLocationCoordinate2D(latitude: 40.609905, longitude: -75.375841),
         CLLocationCoordinate2D(latitude: 40.609823, longitude: -75.378430),CLLocationCoordinate2D(latitude: 40.609905, longitude: -75.375841),
         CLLocationCoordinate2D(latitude: 40.608367, longitude: -75.375732),CLLocationCoordinate2D(latitude: 40.608419, longitude: -75.374420),
         CLLocationCoordinate2D(latitude: 40.607216, longitude: -75.374374),CLLocationCoordinate2D(latitude: 40.607164, longitude: -75.374602),
         CLLocationCoordinate2D(latitude: 40.606951, longitude: -75.374829),CLLocationCoordinate2D(latitude: 40.606721, longitude: -75.374913),
         CLLocationCoordinate2D(latitude: 40.606623, longitude: -75.374981),CLLocationCoordinate2D(latitude: 40.606392, longitude: -75.375391),
         CLLocationCoordinate2D(latitude: 40.606202, longitude: -75.376142),CLLocationCoordinate2D(latitude: 40.605978, longitude: -75.376172),
         CLLocationCoordinate2D(latitude: 40.605773, longitude: -75.376398),CLLocationCoordinate2D(latitude: 40.605629, longitude: -75.376750),
         CLLocationCoordinate2D(latitude: 40.605533, longitude: -75.377932),CLLocationCoordinate2D(latitude: 40.605471, longitude: -75.378424),
         CLLocationCoordinate2D(latitude: 40.605389, longitude: -75.378722),CLLocationCoordinate2D(latitude: 40.605280, longitude: -75.378889),
         CLLocationCoordinate2D(latitude: 40.605153, longitude: -75.378925)]
    ]
}
