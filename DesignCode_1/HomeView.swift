//
//  HomeView.swift
//  DesignCode_1
//
//  Created by user163072 on 3/10/20.
//  Copyright © 2020 user163072. All rights reserved.
//

import SwiftUI

struct HomeView: View {
    @Binding var showProfile: Bool
    var body: some View {
        VStack {
            HStack {
                Text("Watching")
                    .font(.system(size: 28, weight: .bold))
                
                Spacer()
                
                //Pass that state as a binding and add the $ :
                //Bindings are considered to be a property of the object which is bound,
                //and all information related to bindings should be owned by the object.
                AvatarView(showProfile: $showProfile)
                
            }
            .padding(.horizontal)
            .padding(.leading, 14)
            .padding(.top, 30)
            
            //Created Section View now we need to create a repeat for each of these elements and then we
            //make tha scrollview horizontal and then place the image in the HStack
            //turn off the scroll indicator
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 30){
                    ForEach(0 ..< 5) { item in
                        SectionView()
                        }
                    }
                    //Adds extra padding so the scroll view doesn't clip the dropshadow
                    .padding(30)
                    .padding(.bottom, 30)
                }
            
            Spacer()
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        //Have to update this because we created a new file HomeView, this is different from
        //extracting a subview : the HomeView needs some setting.  WE CAN'T pass a state, because
        //we don't have a state to use.  So instead we set .constant(false)
        HomeView(showProfile: .constant(false))
    }
}

struct SectionView: View {
    var body: some View {
        VStack {
            HStack(alignment: .top) {
                Text("Prototype Design")
                    .font(.system(size: 24, weight: .bold))
                    .frame(width: 160, alignment: .leading)
                Spacer()
                Image("Logo1")
            }
            Text("15 Sections".uppercased())
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Image("Card1")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 210)
            
        }
        .padding(.top, 20)
        .padding(.horizontal, 20)
        .frame(width: 275, height: 275)
        .background(Color("card1"))
        .cornerRadius(30)
        .shadow(color: Color("card1").opacity(0.3), radius: 20, x: 0, y: 20)
    }
}
//We are going to create an Data Model or array of data so that it can change the look of the cards
//on the main screen by replacing our manual inputs
struct Section: Identifiable {
    var id = UUID()
    var title: String
    var text: String
    var logo: String
    var image: Image
    var color: Color
}

let sectionData = [
    Section(title: "Prototype designs made with SwiftUI", text: "18 Sections", logo: "Logo1", image: Image("Card1"), color: Color("card1"))
]
