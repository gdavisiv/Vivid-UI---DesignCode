//
//  UpdateList.swift
//  DesignCode_1
//
//  Created by GdavisIV on 3/15/20.
//  Copyright © 2020 George Davis IV. All rights reserved.
//

import SwiftUI

struct UpdateList: View {
    //To use the Update Store which is the class we created
    //This is the store that contains the data now
    @ObservedObject var store = UpdateStore()
    
    //Going to add a new function that will alow the creation of new data
    func addUpdate() {
        store.updates.append(Update(image: "Card1", title: "New Item", text: "Text", date: "Jan 4"))
    }
    
    var body: some View {
        NavigationView {
            //Updated this to the store
            List(store.updates) { update in
                //Only works within the Navigation View
                //Updated the Navigation link to the new file created UpdateDetail
<<<<<<< HEAD
<<<<<<< 105eef1ac19e60591fe0c5d0d00c632441a72000
=======
                //We pass in the update, and the value that we get from the array which is update
>>>>>>> Completed Updates to Navigation Style and finished passing data between UpdateDetail/UpdateList
=======
                //We pass in the update, and the value that we get from the array which is update
>>>>>>> UI-Updates
                NavigationLink(destination: UpdateDetail(update: update)) {
                    HStack {
                        Image(update.image)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 80, height: 80)
                            .background(Color.black)
                            .cornerRadius(20)
                            .padding(.trailing, 4)
                        
                                VStack(alignment: .leading, spacing: 8.0) {
                                    Text(update.title)
                                        .font(.system(size: 20, weight: .bold))
                                        
                                    Text(update.text)
                                        //Limit the Descriptions to 2 lines instead of 3
                                        .lineLimit(2)
                                        .font(.subheadline)
                                        .foregroundColor(Color(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)))
                                    
                                    Text(update.date)
                                        .font(.caption)
                                        .fontWeight(.bold)
                                        .foregroundColor(.secondary)
                        }
                    }
                    .padding(.vertical, 8)
                }
            }
            .navigationBarTitle(Text("Updates"))
        }
    }
}

struct UpdateList_Previews: PreviewProvider {
    static var previews: some View {
        UpdateList()
    }
}
//We are going to create an Data Model or array of data so that it can change the look of the list
//of elements on the UpdateList screen by using manual inputs
struct Update: Identifiable {
    var id = UUID()
    var image: String
    var title: String
    var text: String
    var date: String
}

//Make sure that Each lin is seperated by a comma!!
let updateData = [
    Update(image: "Card1", title: "SwiftUI Styling", text: "Take your SwiftUI app to the App Store with advanced techniques like API data, packages and CMS.", date: "JAN 1"),
    Update(image: "Card2", title: "Webflow", text: "Design and animate a high converting landing page with advanced interactions, payments and CMS", date: "OCT 17"),
    Update(image: "Card3", title: "ProtoPie", text: "Quickly prototype advanced animations and interactions for mobile and Web.", date: "AUG 27"),
    Update(image: "Card4", title: "SwiftUI", text: "Learn how to code custom UIs, animations, gestures and components in Xcode 11", date: "JUNE 26"),
    Update(image: "Card5", title: "Framer Playground", text: "Create powerful animations and interactions with the Framer X code editor", date: "JUN 11")
]
