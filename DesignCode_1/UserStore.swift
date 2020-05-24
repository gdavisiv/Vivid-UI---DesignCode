//
//  UserStore.swift
//  DesignCode_1
//
//  Created by George Davis IV on 5/17/20.
//  Copyright © 2020 user163072. All rights reserved.
//

import SwiftUI
import Combine

//Saves login information and make it persistent
class UserStore: ObservableObject {
    //Pulls in data from User Defaults
    @Published var isLogged: Bool = UserDefaults.standard.bool(forKey: "isLogged") {
        didSet {
            //When the applications loads we are going to pull any data that has
            //already been stored using UserDefaults for isLogged
            //Self meaning the user store is logged, the key is logged
            //Any data that you are storing needs to have a unique key
            UserDefaults.standard.set(self.isLogged, forKey: "isLogged")
        }
    }
    @Published var showLogin = false
}
