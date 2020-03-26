//
//  Address.swift
//  COVID19UE
//
//  Created by Linus Geffarth on 26.03.20.
//  Copyright © 2020 Linus Geffarth. All rights reserved.
//

import Foundation
import CoreLocation

struct Address {
    var street: String
    var house: String
    var zip: String
    var city: String
    var country: String
    
    var string: String {
        return "\(street) \(house), \(zip) \(city), \(country)"
    }
    
    func getCoordinate(_ completion: @escaping (CLLocation?) -> Void) {
        CLGeocoder().geocodeAddressString(string) {
            placemarks, error in
            guard
                let lat = placemarks?.first?.location?.coordinate.latitude,
                let lng = placemarks?.first?.location?.coordinate.longitude
                else { completion(nil); return }
            completion(CLLocation(latitude: lat, longitude: lng))
        }
    }
    
    /// Returns the distance between given location (current user location by default) to this address' location in METERS.
    func getDistance(from location: CLLocation? = currentUserLocation, _ completion: @escaping (Int?) -> Void) {
        getCoordinate { (location2) in
            guard let l1 = location, let l2 = location2 else {
                completion(nil)
                return
            }
            completion(Int(l1.distance(from: l2)))
        }
    }
}
