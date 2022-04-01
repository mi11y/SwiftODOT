//
//  ServiceLocator.swift
//  
//
//  Created by Milly Guitron on 4/4/22.
//

import Foundation

public class ServiceLocator {
    public static func driveTimeConfig() -> URLComponents {
        var components =  initURLComponents()
        components.host = "tripcheck.com"
        components.path = "/Scripts/map/data/traveltime.js"
        return components
    }
    
    private static func initURLComponents() -> URLComponents {
        var components = URLComponents()
        components.scheme = "http"
        return components
    }
}
