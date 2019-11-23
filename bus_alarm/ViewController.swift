//
//  ViewController.swift
//  LBUS
//
//  Created by Zisheng Wang on 11/11/19.
//  Copyright © 2019 Zisheng Wang. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import SwiftyJSON
import DrawerView
import AudioToolbox
import CoreLocation
import UserNotifications
import Foundation

struct busstation {
    var busHasVisited = false
    var lat = 0.0
    var long = 0.0
    var uniqueKey = ""
    var name = ""
    var sacu_dir_next = ""
    var parkard_dir_next = ""
}

var remoteServerIP = "13.82.222.199:5000"

class ViewController: UIViewController, MKMapViewDelegate, UIGestureRecognizerDelegate,CLLocationManagerDelegate{
    
    var timer_count = 0
    
    var mainMapView: MKMapView!
    let locationManager: CLLocationManager = CLLocationManager()
    let tableView = UITableView()
    @IBOutlet weak var searchBar: UISearchBar!
    private var items: [Int] = Array(0...15)
    var busStationAnnotation: [MKAnnotation] = []
    
    var all_bus_station : [busstation] = []
    @IBOutlet weak var drawerView: DrawerView!
    var current_bus: [busClass] = []
    var bus_annotation: [MKPointAnnotation] = []
    var start_to_track = false
    var track_target : [busstation] = []
    var current_custom_choice: [busClass] = []
    var polylineCCRoute : [MKPolyline] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //tableView.contentInsetAdjustmentBehavior = .never
        //tableView.keyboardDismissMode = .onDrag
        
        
        Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(GCD_timer_callback), userInfo: "", repeats: true)
        
        self.mainMapView = MKMapView(frame:self.view.frame)
        self.view.addSubview(self.mainMapView)
        
        self.mainMapView.mapType = MKMapType.standard
        self.mainMapView.delegate = self
        
        let latDelta = 0.05
        let longDelta = 0.05
        let currentLocationSpan:MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: latDelta,longitudeDelta: longDelta)
        
        let center:CLLocation = CLLocation(latitude: 40.600174, longitude: -75.374135)
        let currentRegion:MKCoordinateRegion = MKCoordinateRegion(center: center.coordinate, span: currentLocationSpan)
        
        let screenSize = self.view.bounds
        let viewWidth = screenSize.width
        let viewHeight = screenSize.height
        self.mainMapView.setRegion(currentRegion, animated: true)
        let leftMargin:CGFloat = 0.01*viewWidth//10
        let topMargin:CGFloat = 0.15*viewHeight//94
        let mapWidth:CGFloat = 0.98*viewWidth//343
        let mapHeight:CGFloat = 0.80*viewHeight//532
        
        self.mainMapView.frame = CGRect(x: leftMargin, y: topMargin, width: mapWidth, height: mapHeight)
        // show all annotation
        GCD_timer_callback()
        
        initalBusStation()
        // setupCCRouteOverlay()
        
        // init drawer
        drawerView = setupProgrammaticDrawerView()
        
        //get your location
        locationManager.requestAlwaysAuthorization()
        locationManager.delegate = self
        locationManager.allowsBackgroundLocationUpdates = true
        
        // add map tapping functionweb
        let gestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(handleTap))
        gestureRecognizer.minimumPressDuration = 0.7
        gestureRecognizer.delegate = self
        self.mainMapView.addGestureRecognizer(gestureRecognizer)
        
        
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        return true
    }
    
    @objc func handleTap(gestureRecognizer: UITapGestureRecognizer){
        let location = gestureRecognizer.location(in: self.mainMapView)
        let coordinate = self.mainMapView.convert(location, toCoordinateFrom: self.mainMapView)
        if (gestureRecognizer.state == .ended){
            print("adding custom pin")
            self.current_custom_choice.append(busClass(name: "Custom Location "+String(current_custom_choice.count+1), coordinate: coordinate, mapview: self.mainMapView))
        }
    }
    
    func setupCCRouteOverlay(){
        let polylineCoor = [CLLocationCoordinate2D(latitude: 40.602185, longitude: -75.358352), CLLocationCoordinate2D(latitude: 40.601918, longitude: -75.360385)]
        let polyline = MKPolyline(coordinates: polylineCoor, count: 2)
        
        self.polylineCCRoute.append(polyline)
        self.mainMapView.addOverlays(polylineCCRoute)
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let polylineView = MKPolylineRenderer(overlay: overlay)
        polylineView.strokeColor = UIColor.green
        polylineView.fillColor = UIColor.green
        return polylineView
    }
    
    func setupProgrammaticDrawerView() -> DrawerView {
        // Create the drawer programmatically.
        let drawerView = DrawerView()
        drawerView.attachTo(view: self.view)
        drawerView.delegate = self
        drawerView.snapPositions = [.closed, .open]
        drawerView.insetAdjustmentBehavior = .automatic
        drawerView.position = .closed
        drawerView.addSubview(self.tableView)
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        self.tableView.topAnchor.constraint(equalTo: drawerView.topAnchor).isActive = true
        self.tableView.leftAnchor.constraint(equalTo: drawerView.leftAnchor).isActive = true
        self.tableView.bottomAnchor.constraint(equalTo: drawerView.bottomAnchor).isActive = true
        self.tableView.rightAnchor.constraint(equalTo: drawerView.rightAnchor).isActive = true
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        return drawerView
    }
    
    var currentlyTappedBusFleetNum: String!
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView){
        print("mapView tapped!"+String(current_custom_choice.count))
        self.tableView.reloadData()
        if (self.current_custom_choice.count != 0){
            
            let localAnnotation = view.annotation!
            let str = localAnnotation.title ?? "default"
            let substr = str?.prefix(6)
            if substr == "Custom"{
                // do nothing
                print("tap custom pin")
            }else{
                currentlyTappedBusFleetNum = view.annotation?.subtitle! ?? ""
                drawerView.setPosition(.open, animated: true)
            }
        }else{
            currentlyTappedBusFleetNum = view.annotation?.subtitle! ?? ""
            drawerView.setPosition(.open, animated: true)
        }
    }
        
    @objc func GCD_timer_callback(){
        timer_count += 1
        print("timer_trigger"+String(timer_count))
        let url = URL(string: "https://bus.lehigh.edu/scripts/busdata.php?format=json")!
        let task = URLSession.shared.dataTask(with: url) {data, response, error in
            let dataout = data
            do{
                let json = try JSON(data:dataout!)
                // make all bus not ok
                for bus in self.current_bus{
                    bus.used = false
                }
                // save only compus connector
                for n in 0...json.count-1{
                    if (json[String(n)]["name"].string != nil){
                        if json[String(n)]["name"].string! == "Campus Connector"{
                            var bus_in_list = false
                            // search it the bus is added
                            for bus in self.current_bus{
                                if (json[String(n)]["fleetnum"].string != nil){
                                    if ( Int(json[String(n)]["fleetnum"].string!) == bus.fleetnum){
                                        bus_in_list = true
                                        bus.updateBus(j: json[String(n)])
                                        bus.used = true
                                    }
                                }
                            }
                            if (bus_in_list != true){
                                self.current_bus.append(busClass(j: json[String(n)],mapview: self.mainMapView))
                            }
                        }
                    }
                }
            }
            catch{
                print("error")
            }
        }
        task.resume()
        DispatchQueue.main.async {
            for bus in self.current_bus{
                if (bus.used == true){
                    self.mainMapView.removeAnnotation(bus.busAnnotation)
                    if (bus.busAnnotation.coordinate.latitude != bus.lat){
                        bus.busAnnotation.coordinate = CLLocation(latitude: bus.lat, longitude:bus.long).coordinate
                    }
                    self.mainMapView.addAnnotation(bus.busAnnotation)
                }else{
                    self.mainMapView.removeAnnotation(bus.busAnnotation)
                }
            }
        }
    }
    
    @IBAction func cancellAllButton(){
        // pop a notification in app
        var alertController : UIAlertController
        if start_to_track == true {
            track_target = [] // clear the array
            alertController = UIAlertController(title:"Cancel the appointment", message: nil, preferredStyle: .alert)
        }else{
            alertController = UIAlertController(title:"No appointment scheduled", message: nil, preferredStyle: .alert)
        }
        // run this pop in other thread
        self.present(alertController, animated: true, completion: nil)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+2){
            self.presentedViewController?.dismiss(animated: false, completion: nil)
        }
        // send a all clear command to the remote server
        start_to_track = false
        var emptyBus: [busstation] = [busstation()]
        let json = JsonPackageToServer.packageJson(fleetnum: 0, command: "CancelAppoinment", locationUserWant: &emptyBus)
        JsonPackageToServer.sendJsonToServer(json: json)
    }
    
    func initalBusStation(){
        // all bus-station
        all_bus_station.append(busstation(lat: 40.602185, long: -75.358352, name : "Iacocca C Wing", sacu_dir_next : "", parkard_dir_next : ""))
        all_bus_station.append( busstation(lat: 40.601918, long: -75.360385, name: "Iacocca Hall", sacu_dir_next: "", parkard_dir_next: "") )
        all_bus_station.append( busstation(lat: 40.604164, long: -75.361237, name: "ATLSS", sacu_dir_next: "", parkard_dir_next: "") )
        all_bus_station.append( busstation(lat: 40.599815, long: -75.362966, name: "Building C", sacu_dir_next: "", parkard_dir_next: "") )
        all_bus_station.append(busstation(lat: 40.599839, long: -75.365485, name : "Jordan Hall", sacu_dir_next : "", parkard_dir_next : ""))
        all_bus_station.append( busstation(lat: 40.603105, long: -75.375352, name: "Alpha Tau Omega", sacu_dir_next: "", parkard_dir_next: "") )
        all_bus_station.append( busstation(lat: 40.602295, long: -75.376625, name: "Alpha Phi", sacu_dir_next: "", parkard_dir_next: "") )
        all_bus_station.append( busstation(lat: 40.602018, long: -75.379275, name: "House 93", sacu_dir_next: "", parkard_dir_next: "") )
        all_bus_station.append(busstation(lat: 40.602979, long: -75.380922, name : "Sigma Phi Epsilon", sacu_dir_next : "", parkard_dir_next : ""))
        all_bus_station.append( busstation(lat: 40.603603, long: -75.379039, name: "Pi Beta Phi", sacu_dir_next: "", parkard_dir_next: "") )
        all_bus_station.append( busstation(lat: 40.604059, long: -75.377000, name: "Gamma Phi Beta", sacu_dir_next: "", parkard_dir_next: "") )
        all_bus_station.append( busstation(lat: 40.605138, long: -75.378926, name: "Taylor College", sacu_dir_next: "", parkard_dir_next: "") )
        all_bus_station.append(busstation(lat: 40.605562, long: -75.377499, name : "Drown Hall", sacu_dir_next : "", parkard_dir_next : ""))
        all_bus_station.append( busstation(lat: 40.607011, long: -75.381029, name: "Alumni Memorial Building", sacu_dir_next: "", parkard_dir_next: "") )
        all_bus_station.append( busstation(lat: 40.608205, long: -75.379624, name: "Steps", sacu_dir_next: "", parkard_dir_next: "") )
        all_bus_station.append( busstation(lat: 40.609812, long: -75.378367, name: "Farrington Square", sacu_dir_next: "", parkard_dir_next: "") )
        all_bus_station.append(busstation(lat: 40.611466, long: -75.378517, name : "SouthSide", sacu_dir_next : "", parkard_dir_next : ""))
        all_bus_station.append( busstation(lat: 40.608383, long: -75.375737, name: "Whitaker Lab", sacu_dir_next: "", parkard_dir_next: "") )
        all_bus_station.append( busstation(lat: 40.606945, long: -75.374846, name: "Williams Hall", sacu_dir_next: "", parkard_dir_next: "") )
        all_bus_station.append( busstation(lat: 40.585807, long: -75.358557, name: "Stabler Arena", sacu_dir_next: "", parkard_dir_next: "") )
        all_bus_station.append(busstation(lat: 40.586118, long: -75.355045, name : "Goodman Campus", sacu_dir_next : "", parkard_dir_next : ""))
        all_bus_station.append( busstation(lat: 40.579414, long: -75.355351, name: "Saucon Village", sacu_dir_next: "", parkard_dir_next: "") )
        for bus in all_bus_station{
            let annotation = MKPointAnnotation()
            annotation.coordinate = CLLocation(latitude: bus.lat, longitude:    bus.long).coordinate
            annotation.title = bus.name
            busStationAnnotation.append(annotation)
        }
    }
}

extension ViewController: DrawerViewDelegate{
    
    func drawer(_ drawerView: DrawerView, willTransitionFrom startPosition: DrawerPosition, to targetPosition: DrawerPosition) {
        print("drawer(_:willTransitionFrom: \(startPosition) to: \(targetPosition))")
    }

    func drawer(_ drawerView: DrawerView, didTransitionTo position: DrawerPosition) {
        print("drawerView(_:didTransitionTo: \(position))")
    }

    func drawerWillBeginDragging(_ drawerView: DrawerView) {
        print("drawerWillBeginDragging")
    }

    func drawerWillEndDragging(_ drawerView: DrawerView) {
        print("drawerWillEndDragging")
    }

    func drawerDidMove(_ drawerView: DrawerView, drawerOffset: CGFloat) {

    }
    
}

extension ViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return all_bus_station.count+current_custom_choice.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") ?? UITableViewCell(style: .default, reuseIdentifier: "Cell")
        
        if ( current_custom_choice.count == 0 ){
            cell.textLabel?.text = all_bus_station[indexPath.row].name
        }else{
            if indexPath.row < current_custom_choice.count {
                cell.textLabel?.text = "Custom Location "+String(indexPath.row+1)
            }else{
                cell.textLabel?.text = all_bus_station[indexPath.row - current_custom_choice.count ].name
            }
        }
        cell.backgroundColor = UIColor.clear
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        // make the drawer go back
        drawerView?.setPosition(.closed, animated: true)
        // if there is no custom location
        if (current_custom_choice.count == 0){
            let uniqueKey = all_bus_station[indexPath.row].name+String(Int(all_bus_station[indexPath.row].lat*1000000))+String(Int(all_bus_station[indexPath.row].long*1000000))
            track_target.append(busstation(lat: all_bus_station[indexPath.row].lat, long: all_bus_station[indexPath.row].long, uniqueKey: uniqueKey, name: all_bus_station[indexPath.row].name))
        }else{// if there is custom location and we tap a custom one
            if (indexPath.row < current_custom_choice.count){
                let uniqueKey = current_custom_choice[indexPath.row].name+String(Int(current_custom_choice[indexPath.row].lat*1000000))+String(Int(current_custom_choice[indexPath.row].long*1000000))
                track_target.append(busstation( lat: current_custom_choice[indexPath.row].lat, long: current_custom_choice[indexPath.row].long, uniqueKey: uniqueKey, name: current_custom_choice[indexPath.row].name))
            }else{//if we tap a preset one
                let uniqueKey = all_bus_station[indexPath.row - current_custom_choice.count].name+String(Int(all_bus_station[indexPath.row - current_custom_choice.count].lat*1000000))+String(Int(all_bus_station[indexPath.row - current_custom_choice.count].long*1000000))
                track_target.append(busstation(lat: all_bus_station[indexPath.row - current_custom_choice.count].lat, long: all_bus_station[indexPath.row - current_custom_choice.count].long, uniqueKey: uniqueKey, name: all_bus_station[indexPath.row - current_custom_choice.count].name))
            }
        }
        if track_target.count <= 5 {
            // send json to server to set this notification
            let jsonToServer = JsonPackageToServer.packageJson(fleetnum: Int(currentlyTappedBusFleetNum) ?? 0, command: "trackBus", locationUserWant: &track_target)
            JsonPackageToServer.sendJsonToServer(json: jsonToServer)
            //        if (start_to_track == false){
            let alertController = UIAlertController(title:"Will alarm when bus arrive/close to selected location", message: nil, preferredStyle: .alert)
            self.present(alertController, animated: true, completion: nil)
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+2){
                self.presentedViewController?.dismiss(animated: false, completion: nil)
            }
        }else{
            let alertController = UIAlertController(title:"Can not select locations for more than 5", message: nil, preferredStyle: .alert)
            self.present(alertController, animated: true, completion: nil)
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+2){
                self.presentedViewController?.dismiss(animated: false, completion: nil)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return false
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            items.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}
