//
//  DataStore.swift
//  DesignCode_1
//
//  Created by George Davis IV on 4/9/20.
//  Copyright © 2020 user163072. All rights reserved.
//

import SwiftUI
import Combine

//Any UI that is using 
//Create a new class Datastore that will contain our
class DataStore: ObservableObject {
    //Empty Post array
    @Published var posts: [Post] = []
    
    init() {
        getPosts()
    }
    
    //Make Combine run this function when it is initialized
    func getPosts() {
        Api().getPosts { (posts) in
            self.posts = posts
        }
    }
}
