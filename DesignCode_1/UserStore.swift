//
//  UserStore.swift
//  DesignCode_1
//
//  Created by George Davis IV on 5/17/20.
//  Copyright © 2020 user163072. All rights reserved.
//

import SwiftUI
import Combine


class UserStore: ObservableObject {
    @Published var isLogged: Bool = UserDefaults.standard.bool(forKey: "isLogged") {
        didSet {
            UserDefaults.standard.set(self.isLogged, forKey: "isLogged")
        }
    }
    @Published var showLogin = false
}
