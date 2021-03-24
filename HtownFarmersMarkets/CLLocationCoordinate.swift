//
//  CLLocationCoordinate.swift
//  HtownFarmersMarkets
//
//  Created by Michael Dichiara on 2/24/21.
//

import Foundation
import MapKit

extension CLLocationCoordinate2D: Identifiable {
    public var id: String {
        "\(latitude)-\(longitude)"
    }
}
