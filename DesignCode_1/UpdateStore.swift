//
//  UpdateStore.swift
//  DesignCode_1
//
//  Created by GdavisIV on 3/17/20.
//  Copyright © 2020 George Davis IV. All rights reserved.
//

import SwiftUI
import Combine

//This is our store and we will be able to use this from any view
class UpdateStore: ObservableObject {
    @Published var updates: [Update] = updateData
}
