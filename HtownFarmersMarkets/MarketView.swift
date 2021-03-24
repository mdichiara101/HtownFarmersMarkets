//
//  MarketView.swift
//  HtownFarmersMarkets
//
//  Created by Michael Dichiara on 2/23/21.
//

import SwiftUI
import MapKit


struct MarketView: View {
    struct MarketVendor {
        let vendor: Vendor
        let products: String
    }
    struct Location: Identifiable {
        let id = UUID()
        let name: String
        let coordinate: CLLocationCoordinate2D
    }
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 29.7, longitude: -95.5), span: MKCoordinateSpan(latitudeDelta: 0.4, longitudeDelta: 0.4))
    let annotation: Location
    var annotations: [Location] = []
    let market: Market
    let vendors: [MarketVendor]
    @ObservedObject var userSettings = UserSettings() 
    var body: some View {
        GeometryReader{ geometry in
        ScrollView(.vertical){
        VStack{
        TabView {
        ForEach(1..<4){ num in
        Image("\(self.market.id) \(num)")
            .resizable()
            .scaledToFit()
            .overlay(Color.black.opacity(0.4))
            .tag(num)
            }}.tabViewStyle(PageTabViewStyle())
            .padding(.top)
            .frame(maxWidth: geometry.size.width * 0.7)
            Text(self.market.description)
            .padding()
            .layoutPriority(1)
            .foregroundColor(Color("BodyFontColor"))
                   
        Map(coordinateRegion: $region, annotationItems: annotations) {
        MapAnnotation(coordinate: $0.coordinate, content: {
        VStack{
        Group {
        Image(systemName: "mappin.circle.fill")
            .resizable()
            .frame(width: 30.0, height: 30.0)
            }
            .foregroundColor(.red)
            }})
            }
            .frame(width: 300, height: 300)
        Text("Vendors")
            .padding()
            .font(.headline)
            .foregroundColor(Color("BodyFontColor"))
        ForEach(self.vendors, id: \.products){
            marketVendor in
        NavigationLink(destination: VendorView(vendor: marketVendor.vendor)) {
        HStack{
        Image(marketVendor.vendor.id)
            .resizable()
            .frame(width: 83, height: 60)
            .clipShape(Capsule())
            .overlay(Capsule().stroke(Color.primary, lineWidth: 1))
        VStack(alignment: .leading){
        Text(marketVendor.vendor.id)
            .font(.headline)
            .foregroundColor(Color("BodyFontColor"))
        Text(marketVendor.products)
            .foregroundColor(.secondary)
            .foregroundColor(Color("BodyFontColor"))
            }
        Spacer()
            }
            .padding(.horizontal)
            }
            .buttonStyle(PlainButtonStyle())
            }
        Spacer(minLength: 25)
            }
            }
            }
           .navigationBarTitle(Text(market.id), displayMode: .inline )
           .navigationBarItems(trailing:
        Button(action: {
            if(market.id.elementsEqual("Memorial Villages Farmers Market")){
                userSettings.bool.toggle()
                notification(market: market, bool: userSettings.bool)
            }
            if(market.id.elementsEqual("Heights Farmers Market")){
                userSettings.bool2.toggle()
                notification(market: market, bool: userSettings.bool2)
            }
            if(market.id.elementsEqual("Rice Village Farmers Market")){
                userSettings.bool3.toggle()
                notification(market: market, bool: userSettings.bool3)
            }
            }
            ){
            if(market.id.elementsEqual("Memorial Villages Farmers Market")){
                NotifOn(bool: userSettings.bool).foregroundColor(.blue)}
            if(market.id.elementsEqual("Heights Farmers Market")){
                NotifOn(bool: userSettings.bool2).foregroundColor(.blue)
            }
            if(market.id.elementsEqual("Rice Village Farmers Market")){
                NotifOn(bool: userSettings.bool3).foregroundColor(.blue)}
            })
            
    }
    init(market: Market, vendors: [Vendor]){
        self.market = market
        var matches = [MarketVendor]()
        annotation = Location(name: market.id, coordinate: CLLocationCoordinate2D(latitude: market.xcoord, longitude: market.ycoord))
        annotations.append(annotation)
        
        
        for member in market.vendors {
        if let match = vendors.first(where: { $0.id == member.id})  {
        matches.append(MarketVendor(vendor: match, products: member.products))
        }
        else{
        fatalError("Missing \(member)")
        }
        }
        self.vendors = matches
       

    }
    func WeekDaytoInt(market: Market) -> Int{
        if market.open.elementsEqual("Sunday"){
            return 1
        }
        else if market.open.elementsEqual("Monday"){
            return 2
        }
        else if market.open.elementsEqual("Tuesday"){
            return 3
        }
        else if market.open.elementsEqual("Wednesday"){
            return 4
        }
        else if market.open.elementsEqual("Thursday"){
            return 5
        }
        else if market.open.elementsEqual("Friday"){
            return 6
        }
        else if market.open.elementsEqual("Saturday"){
            return 7
        }
        else{
            return 0
        }
    }
    
    func NotifOn(bool: Bool) -> Image{
        if bool {
            return Image(systemName: "bell.fill")
        }
        else{
            return Image(systemName: "bell")
        }
    }
    
    func notification(market: Market, bool: Bool){
        
        if bool{
        let content = UNMutableNotificationContent()
        content.title = "Open: \(market.id)"
            content.subtitle = "Open today from \(market.time)"
        content.sound = UNNotificationSound.default
                            
        var dateComponents = DateComponents()
        dateComponents.hour = 8
        dateComponents.minute = 30
                    
        dateComponents.weekday = WeekDaytoInt(market: market)
                    
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        let request = UNNotificationRequest(identifier:UUID().uuidString, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request)
        }
    }
   
}

struct MarketView_Previews: PreviewProvider {
    static let markets: [Market] = Bundle.main.decode("markets.json")
    static let vendors: [Vendor] = Bundle.main.decode("vendors.json")
    static var previews: some View {
        MarketView(market: markets[0], vendors: vendors)
    }
}


