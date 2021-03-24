//
//  VendorView.swift
//  HtownFarmersMarkets
//
//  Created by Michael Dichiara on 2/23/21.
//

import SwiftUI

struct VendorView: View {
    let vendor: Vendor

    var body: some View {
        GeometryReader { geometry in
            ScrollView(.vertical) {
                VStack {
                    Image(self.vendor.id)
                        .resizable()
                        .scaledToFit()
                        .frame(width: geometry.size.width)
                    
                    Link(vendor.website, destination: URL(string: "https://\(vendor.website)")!)
                        .padding()
                    Text(self.vendor.description)
                        .padding()
                        .layoutPriority(1)
                        .foregroundColor(Color("BodyFontColor"))
                    
                
                }
            }
        }
        .navigationBarTitle(Text(vendor.id), displayMode: .inline)
    }
    
        
    
}


struct VendorView_Previews: PreviewProvider {
    static let vendors: [Vendor] = Bundle.main.decode("vendors.json")
    static var previews: some View {
        VendorView(vendor: vendors[0])
    }
}
