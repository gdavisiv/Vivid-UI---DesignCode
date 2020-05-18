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
    @Published var isLogged = false
    @Published var showLogin = false
}
