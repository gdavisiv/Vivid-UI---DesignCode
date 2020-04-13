//
//  CourseStore.swift
//  DesignCode_1
//
//  Created by George Davis IV on 4/13/20.
//  Copyright © 2020 user163072. All rights reserved.
//

import SwiftUI
//This is only available because we downloaded the library contentful
import Contentful

//Here we will manage the API calls from Contentful

//Settings -> API Keys -> Space ID & Access Token Needed
let client = Client(spaceId: "q9yfx3ed18xx", accessToken: "CLoS8H84d0SYq9-zZjy1uFU3LKKHQ4psQw6TojBtys8")

//How to use their API : https://github.com/contentful/contentful.swift/
func getArray() {
    //The EntryDecodable protocol allows you to define a mapping between your content
    //types and your Swift classes that entries will be serialized to.
    //Couse is simply the content model
    let query = Query.where(contentTypeId: "course")
    
    //To make the API call use client which was configured above, entry is the content model from contentful
    //
    client.fetchArray(of: Entry.self, matching: query) { result in
        print(result)
    }
}
