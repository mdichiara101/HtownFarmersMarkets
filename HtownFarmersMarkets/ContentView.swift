//
//  ContentView.swift
//  HtownFarmersMarkets
//
//  Created by Michael Dichiara on 2/23/21.
//

import SwiftUI
import MapKit

struct Location: Identifiable {
    let id = UUID()
    let market: Market
    let coordinate: CLLocationCoordinate2D
}

struct ContentView: View {
    let vendors: [Vendor] = Bundle.main.decode("vendors.json")
    let markets: [Market] = Bundle.main.decode("markets.json")
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 29.7, longitude: -95.5), span: MKCoordinateSpan(latitudeDelta: 0.4, longitudeDelta: 0.4))
    var annotations: [Location] = []
    
    var body: some View {
        NavigationView{
        VStack(spacing: 25){
        VStack{
        ZStack{
        Map(coordinateRegion: $region, annotationItems: annotations) { annotation in
        
        MapAnnotation(coordinate: annotation.coordinate, content: {
        VStack{
        NavigationLink(destination: MarketView(market: annotation.market, vendors: self.vendors)){
        Group {
        Image(systemName: "mappin.circle.fill")
            .resizable()
            .frame(width: 30.0, height: 30.0)
            }
            .foregroundColor(isOpen(market: annotation.market))
            }
            }
            })
            }
            .frame(height: 550)
            }
        HStack(spacing: 15){
            HStack(spacing: 1.5){
            Text("Open")
                .foregroundColor(Color("BodyFontColor"))
            Circle()
                .fill(Color.green)
                .frame(width: 12, height: 12)}
            HStack(spacing: 1.5){
            Text("Close")
                .foregroundColor(Color("BodyFontColor"))
            Circle()
                .fill(Color.red)
                .frame(width: 12, height: 12)}
                }}
                
            NavigationLink(destination: MarketsView()){
                  MarketButtonView()
                }
            NavigationLink(destination: VendorsView()){
                  VendorButtonView()
                }
            }
            .navigationBarTitle("HTX Farmer's Markets", displayMode: .inline)
            .navigationBarColor(backgroundColor: UIColor(named: "BarColor"), titleColor: UIColor(named: "BarFontColor"))
            .background(Color("Background"))
    }
    }
    init(){
        for market in markets{
            annotations.append(Location(market: market, coordinate: CLLocationCoordinate2D(latitude: market.xcoord, longitude: market.ycoord)))
        }
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound])  {
                      success, error in
            if success {
                print("authorization granted")
                }
            else if let error = error {
                print(error.localizedDescription)
                }
                }
    }
    func isOpen(market: Market) -> Color{
        let today = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE"
        if(market.open.elementsEqual(formatter.string(from: today))){
            return .green
        }
        else{
            return .red
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


struct NavigationBarModifier: ViewModifier {

    var backgroundColor: UIColor?
    var titleColor: UIColor?

    init(backgroundColor: UIColor?, titleColor: UIColor?) {
        self.backgroundColor = backgroundColor
        let coloredAppearance = UINavigationBarAppearance()
        coloredAppearance.configureWithTransparentBackground()
        coloredAppearance.backgroundColor = backgroundColor
        coloredAppearance.titleTextAttributes = [.foregroundColor: titleColor ?? .white]
        coloredAppearance.largeTitleTextAttributes = [.foregroundColor: titleColor ?? .white]

        UINavigationBar.appearance().standardAppearance = coloredAppearance
        UINavigationBar.appearance().compactAppearance = coloredAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = coloredAppearance
    }

    func body(content: Content) -> some View {
        ZStack{
            content
            VStack {
                GeometryReader { geometry in
                    Color(self.backgroundColor ?? .clear)
                        .frame(height: geometry.safeAreaInsets.top)
                        .edgesIgnoringSafeArea(.top)
                    Spacer()
                }
            }
        }
    }
}

extension View {

    func navigationBarColor(backgroundColor: UIColor?, titleColor: UIColor?) -> some View {
        self.modifier(NavigationBarModifier(backgroundColor: backgroundColor, titleColor: titleColor))
    }

}




struct MarketButtonView: View {
var body: some View {
    Text("Markets")
        .frame(width: 200, height: 50, alignment: .center)
        .background(Color("BarColor"))
        .foregroundColor(Color("BarFontColor"))
}
}


struct VendorButtonView: View {
var body: some View {
    Text("Vendors")
        .frame(width: 200, height: 50, alignment: .center)
        .background(Color("BarColor"))
        .foregroundColor(Color("BarFontColor"))
}
}


