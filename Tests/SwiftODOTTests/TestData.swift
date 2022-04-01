//
//  TestData.swift
//  
//
//  Created by Milly Guitron on 4/4/22.
//

import Foundation

import Foundation

public final class TestData {
    public static let driveTimeDataJSON: URL = Bundle.module.url(forResource: "DriveTimesResponse", withExtension: "json")!
}

internal extension URL {
    /// Returns a `Data` representation of the current `URL`. Force unwrapping as it's only used for tests.
    var data: Data {
        return try! Data(contentsOf: self)
    }
}
