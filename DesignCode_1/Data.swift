//
//  Data.swift
//  DesignCode_1
//
//  Created by George Davis IV on 4/5/20.
//  Copyright © 2020 George Davis IV. All rights reserved.
//
//Using JSON data from the following website :
//https://jsonplaceholder.typicode.com/

import SwiftUI

//Create a new Data Model, of type codable so that we can use JSON format, and identifiable so we can
//loop through the data and make it easy to read in SwiftUI
struct Post: Codable, Identifiable {
    let id = UUID()
    var title: String
    var body: String
}

//Create an API class
class Api {
    //When we make the API call we want to return something, ie the post that we made
    //We're going to have an array of post ie our Data Model
    //we'll be able to return values for this function getPost
    func getPosts(completion: @escaping ([Post]) -> ()) {
        //Needed to create an API call, and then input the website link of the JSON format of the Data
        //Using Guard we can use it tso that if it is not a URL otherwise it will stop running the code
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return }
        
        //Come back to FULL understand the importance of this!! and Comment it!
        //Make the API Call : The completion handler allows us to set the names of the data that we get back from the
        //response.  For the rest of the responses we will set as '_' and that simply means we will not use it for the moment
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            //We will now decode the JSON in Swift.  It will decode and use the data model we created
            //We can get rid of tha exclamation point on from:data! with a guard statement
            //This will stop running the rest of the function instead of having the app crash
            guard let data = data else { return }
            
            let posts = try! JSONDecoder().decode([Post].self, from: data)
            
            //This will allow us to interact with the app while running the API call
            DispatchQueue.main.async {
                //Use completion handles
                completion(posts)
            }
        }
    .resume()
    }
}
