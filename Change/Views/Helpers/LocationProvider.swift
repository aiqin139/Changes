//
//  LocationProvider.swift
//  Change
//
//  Created by aiqin139 on 2021/2/17.
//

import SwiftUI
import CoreLocation
import Combine

public class LocationProvider: NSObject, CLLocationManagerDelegate, ObservableObject {
    private let locationManager: CLLocationManager
    public let heading = PassthroughSubject<CGFloat, Never>()

    @Published var currentHeading: CGFloat {
        willSet {
            heading.send(newValue)
        }
    }

    public override init() {
        currentHeading = 0
        locationManager = CLLocationManager()
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingHeading()
        locationManager.requestWhenInUseAuthorization()
    }

    public func updateHeading() {
        locationManager.startUpdatingHeading()
    }

    public func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        DispatchQueue.main.async {
            self.currentHeading = CGFloat(newHeading.trueHeading)
        }
    }
}
