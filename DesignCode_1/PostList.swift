//
//  PostList.swift
//  DesignCode_1
//
//  Created by George Davis IV on 4/5/20.
//  Copyright © 2020 George Davis IV. All rights reserved.
//

import SwiftUI


struct PostList: View {
    //While we are running the API call we will use this state, and we will set it to default so that
    //it will load the empty results
    //@State var posts: [Post] = []
    
    //Pull in Datastore in store variable: Using and observing this data ojbect store
    //will automatically update in its lists
    @ObservedObject var store = DataStore()
    
    
    var body: some View {
        //Use a list to display the post, rename the value recieving from it as post
        //Update post with store.posts
        List(store.posts) { post in
            VStack(alignment: .leading, spacing: 8) {
                //Updates the display of the code info
                Text(post.title).font(.system(.title, design: .serif)).bold()
                Text(post.body).font(.subheadline).foregroundColor(.secondary)
            }
        }
        //No need for the following code since I created the DataStore
//        //Quick way to implement the display of data from the JSOn call
//        .onAppear {
//            //Calling the class we created in Data.swift
//            //We're going to use completion and getting back the value thanks to the completion, and
//            //we will store those post inside @State var post
//            Api().getPosts { (posts) in
//                //now that we recieved the post, we can put it in the State
//                self.posts = posts
//            }
//        }
    }
}

struct PostList_Previews: PreviewProvider {
    static var previews: some View {
        PostList()
    }
}
