//
//  MarketsView.swift
//  HtownFarmersMarkets
//
//  Created by Michael Dichiara on 3/3/21.
//

import SwiftUI
import MapKit



struct MarketsView: View {
    let vendors: [Vendor] = Bundle.main.decode("vendors.json")
    let markets: [Market] = Bundle.main.decode("markets.json")
    var body: some View {
            List(markets) {
                market in
                VStack{
                NavigationLink(destination: MarketView(market: market, vendors: self.vendors)){
                VStack(alignment: .leading){
                Text(market.id)
                    .font(.headline)
                    .foregroundColor(Color("BodyFontColor"))
                    }
                }
                Image("\(market.id) 0")
                    .resizable()
                    .scaledToFit()
                }
            }
            .navigationBarTitle("Markets")
    }
}


struct MarketsView_Previews: PreviewProvider {
    static var previews: some View {
        MarketsView()
    }
}
