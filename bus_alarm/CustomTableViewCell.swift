//
//  CustomTableViewCell.swift
//  LBUS
//
//  Created by Zisheng Wang on 11/13/19.
//  Copyright © 2019 Zisheng Wang. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON

struct LehighBusJson{
    var key: String = ""
    var time: String = ""
    //var timestamp: String
    //var lat: String = ""
    //var long: String = ""
    //var icon: String
    //var retinaicon: String
    //var tv_icon:String
    var name: String = ""
    var heading: String = ""
    //var speed: String = ""
    //var rid: String = ""
    //var vid: String = ""
    //var fleetnum: String = ""
    var stops: String = ""
    var currentstop: String = ""
    var laststop: String = ""
}

class CustomTableViewCell: UITableViewCell {
    var count = 0
    override func awakeFromNib() {
        super.awakeFromNib()
        let notiCen = NotificationCenter.default
        notiCen.addObserver(self, selector: #selector(timer_runout_custom_cell), name: NSNotification.Name(rawValue: "GlobalTableUpdae"), object: nil)
    }
    @objc func timer_runout_custom_cell(){
        count += 1
        self.textLabel?.text = String(count)
        self.detailTextLabel?.text = String(count)
        getLehighBusInformation()
    }
    
    func getLehighBusInformation() -> [LehighBusJson]{
        var buses: [LehighBusJson] = []
        let url = URL(string: "https://bus.lehigh.edu/scripts/busdata.php?format=json")!
        let task = URLSession.shared.dataTask(with: url) {data, response, error in
            let dataout = data
            do{
                let json = try JSON(data:dataout!)
                // save only compus connector
                for n in 1...json.count{
                    if (json[String(n)]["name"].string != nil){
                        print(json[String(n)]["name"].string!)
                        if json[String(n)]["name"].string! == "Campus Connector"{
                            print(n)
                            
                        }
                    }
                }
                
                
                print("success")
            }
            catch{
                print("error")
            }
        }
        
        task.resume()
        return buses
    }
}
