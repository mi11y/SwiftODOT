//
//  ServiceLocator.swift
//  
//
//  Created by Milly Guitron on 4/4/22.
//

import Foundation

/// A class that provides ODOT API URLComponents
///
/// Use this class in combination with the TripCheckClient to access API Endpoints from Oregon Department of Transportation.
public class ServiceLocator {
    
    /// An API Endpoint for Highway Drive times.
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
