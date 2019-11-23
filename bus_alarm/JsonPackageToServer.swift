//
//  JsonPackageToServer.swift
//  bus_alarm
//
//  Created by Zisheng Wang on 11/20/19.
//  Copyright © 2019 Zisheng Wang. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire

struct jsonLocation {
    let name:String
    let lat: Double
    let long: Double
}

struct jsonRemoteServerDefinition {
    let appleToken: String
    let fleetnum: Int
    let command: String
    let locationUserWant: [jsonLocation]
}

extension String {
    public init(deviceToken: Data) {
        self = deviceToken.map {String(format: "%.2hhx", $0)}.joined()
    }
}

class JsonPackageToServer {
    
    
    // prepare a json package
    // note that we will not send the data that has been sent
    public static func packageJson(fleetnum: Int, command: String, locationUserWant: inout [busstation])->JSON {
        
        var jsonPackage: [JSON] = []
        var count = 0
        for ii in 0...locationUserWant.count-1 {
            if locationUserWant[ii].busHasVisited == false {
                let jsonTmp: JSON = [
                    "appleToken": String(deviceToken: appleTokenForThisApp[0]),
                    "fleetnum": String(fleetnum),
                    "command": command,
                    "locationUserWant": [
                        String(count): [
                            "uniqueKey": locationUserWant[ii].uniqueKey,
                            "name": locationUserWant[ii].name,
                            "lat": String(locationUserWant[ii].lat),
                            "long": String(locationUserWant[ii].long)
                        ]
                    ]
                ]
                count += 1
                jsonPackage.append(jsonTmp)
                locationUserWant[ii].busHasVisited = true
            }
        }
        var jsonOutput = jsonPackage[0]
        if jsonPackage.count > 1 {
            for i in 1...jsonPackage.count-1 {
                do{
                    try jsonOutput.merge(with: jsonPackage[i])
                }catch{
                    print("json construction has error")
                }
            }
        }
        return jsonOutput
    }
    
    public static func sendJsonToServer(json: JSON){
        AF.request("http://13.82.222.199:5000/", method: .put, parameters: json, encoder: JSONParameterEncoder.default).response {response in
            print(response)
        }
    }
}
