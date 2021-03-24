//
//  VendorsView.swift
//  HtownFarmersMarkets
//
//  Created by Michael Dichiara on 3/3/21.
//

import SwiftUI

struct VendorsView: View {
    let vendors: [Vendor] = Bundle.main.decode("vendors.json")
    let markets: [Market] = Bundle.main.decode("markets.json")

    
    var body: some View {
            List(vendors) {
                vendor in
                VStack{
                NavigationLink(destination: VendorView(vendor: vendor)){
                    VStack(alignment: .leading){
                    Text(vendor.id)
                        .font(.headline)
                        .foregroundColor(Color("BodyFontColor"))
                    }
                }
                    Image("\(vendor.id)")
                       .resizable()
                       .scaledToFit()
                }
            }
            .navigationBarTitle("Vendors")
    }
}


struct VendorsView_Previews: PreviewProvider {
    static var previews: some View {
        VendorsView()
    }
}
