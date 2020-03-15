//
//  UpdateList.swift
//  DesignCode_1
//
//  Created by user163072 on 3/15/20.
//  Copyright © 2020 user163072. All rights reserved.
//

import SwiftUI

struct UpdateList: View {
    var body: some View {
        NavigationView {
            List(0 ..< 5) { item in
                //Only works within the Navigation View
                NavigationLink(destination: Text("1")) {
                    Text("SwiftUI")
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

let updateData = [
    Update(image: "Card", title: "SwiftUI", text: "Text", date: "Jan 1")
]
