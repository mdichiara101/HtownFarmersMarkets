//
//  UserSettings.swift
//  HtownFarmersMarkets
//
//  Created by Michael Dichiara on 3/14/21.
//

import Foundation

class UserSettings: ObservableObject {
    @Published var bool: Bool{
        didSet{
            UserDefaults.standard.set(bool, forKey: "bool")
            
        }
    }
    @Published var bool2: Bool{
        didSet{
            UserDefaults.standard.set(bool2, forKey: "bool2")
            
        }
    }
    @Published var bool3: Bool{
        didSet{
            UserDefaults.standard.set(bool3, forKey: "bool3")
            
        }
    }
    init(){
        self.bool = UserDefaults.standard.object(forKey: "bool") as? Bool ?? false
        self.bool2 = UserDefaults.standard.object(forKey: "bool2") as? Bool ?? false
        self.bool3 = UserDefaults.standard.object(forKey: "bool3") as? Bool ?? false
    }
}
