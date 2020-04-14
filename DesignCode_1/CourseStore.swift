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
import Combine

//Here we will manage the API calls from Contentful

//Settings -> API Keys -> Space ID & Access Token Needed
let client = Client(spaceId: "q9yfx3ed18xx", accessToken: "CLoS8H84d0SYq9-zZjy1uFU3LKKHQ4psQw6TojBtys8")

//How to use their API : https://github.com/contentful/contentful.swift/
//Now that we're receving data, we going to use that data to fill our UI :
//create a completion handler, '@escaping([entry]) -> () so when the call is successful and we're reciving the data
//we don't want to print anymore and we want to send back the array that we are receiving so we can use
//that in the UI
func getArray(id: String, completion: @escaping([Entry]) -> ()) {
    //The EntryDecodable protocol allows you to define a mapping between your content
    //types and your Swift classes that entries will be serialized to.
    //Couse is simply the content model
    let query = Query.where(contentTypeId: id)
    
    //To make the API call use client which was configured above, entry is the content model from contentful
    //
    client.fetchArray(of: Entry.self, matching: query) { result in
        switch result {
        case .success(let array):
            //Make the data asyncrinous so we can work with the UI and Data in real time
            DispatchQueue.main.sync {
                completion(array.items)
            }
        case .error(let error):
            print(error)
        }
    }
}

//Create a class for an obeservable Object
class CourseStore: ObservableObject {
    @Published var courses: [Course] = courseData
    init() {
        getArray(id: "course") { (items) in
            items.forEach { (item) in
                //Swift UI doesn't like this because this value type is of ANY, usually u have to tell swift what
                //kind of data you are recieving so add 'as! String'
                print(item.fields["title"] as! String)
            }
        }
    }
}
