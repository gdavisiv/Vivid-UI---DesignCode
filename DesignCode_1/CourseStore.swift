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
        //Create an array of colors to randomize the colors displayed
        let colors = [#colorLiteral(red: 0.1215686277, green: 0.01176470611, blue: 0.4235294163, alpha: 1), #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1), #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1), #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1), #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1), #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1), #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)]
        //Declare an index element, and then increment the index via a loop
        var index = 0
        
        getArray(id: "course") { (items) in
            items.forEach { (item) in
                //w
                self.courses.append(Course(
                    title: item.fields["title"] as! String,
                    subtitle: item.fields["subtitle"] as! String,
                    //Change from an image literal to the following;
                    //instead of targetting the field instead we are going to use a .linkedAsset
                    //with a field name of image, we have either wrap everything in a paranthesis
                    //a second solution is to create a default value.  we can keep the string empty
                    //or use a fallback URL
                    image: item.fields.linkedAsset(at: "image")?.url ?? URL(string: "")!,
                    logo: #imageLiteral(resourceName: "Logo1"),
                    //Randomize the colors used on the cardswith the following
                    //
                    color: colors[index],
                    show: false))
                //Swift UI doesn't like this because this value type is of ANY, usually u have to tell swift what
                //kind of data you are recieving so add 'as! String'
                //print(item.fields["title"] as! String)
                
                //This number will increment every single time at the end of the loop
                index = index + 1
            }
        }
    }
}
