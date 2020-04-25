//
//  TabBar.swift
//  DesignCode_1
//
//  Created by GdavisIV on 3/18/20.
//  Copyright © 2020 George Davis IV. All rights reserved.
//

import SwiftUI

struct TabBar: View {
    var body: some View {
        //We need to wrap our content insdie a TabView
        TabView {
            //Summon Home() and use the .tabItem modifier to turn it into a tab bar item
            Home().tabItem {
                //add an sf icon and text
                Image(systemName: "play.circle.fill")
                Text("Home")
            }
            //Summon ContentView() and ... ""
            CourseList().tabItem {
                //add an sf icon and text
                Image(systemName: "rectangle.stack.fill")
                Text("Courses")
            }
        }
        //Add the modifier below to ignore the safe area at the top of the phone
        //.edgesIgnoringSafeArea(.top)
    }
}

struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        //to preview on a specific device change below to following example :
        //You can also preview on multiple devices, but you'll need to turn off live preview FIRST
        Group {
            TabBar().previewDevice("iPhone 8")
            TabBar().previewDevice("iPhone 11 Pro Max")
        }
    }
}
