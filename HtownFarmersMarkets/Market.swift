//
//  Market.swift
//  HtownFarmersMarkets
//
//  Created by Michael Dichiara on 2/23/21.
//

import Foundation
import MapKit


struct Market: Codable, Identifiable {
    
    struct fmVendor: Codable{
        let id: String
        let products: String
    }
    
    let id: String
    let vendors: [fmVendor]
    let description: String
    let address: String
    let xcoord: Double
    let ycoord: Double
    let open: String
    let time: String
}




