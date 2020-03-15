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
    
    //Added a new state for the Scene Transition Button
    @State var showUpdate = false
    
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
                
                Button(action: {self.showUpdate.toggle() }) {
                    Image(systemName: "bell")
                        .renderingMode(.original)
                        .font(.system(size: 16, weight: .medium))
                        .frame(width: 36, height: 36)
                }
            .sheet(isPresented: $showUpdate)
            }
            .padding(.horizontal)
            .padding(.leading, 14)
            .padding(.top, 30)
            
            //Created Section View now we need to create a repeat for each of these elements and then we
            //make tha scrollview horizontal and then place the image in the HStack
            //turn off the scroll indicator
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 20){
                    //Updated with Data structure: use a ForEach() to loop through the collection
                    //of items and return individual ones declared as item. With item, we can
                    //specify the variables from your data model.
                    ForEach(sectionData) { item in
                        GeometryReader { geomentry in
                                SectionView(section: item)
                                    //Adding double converts CGFloat -> Double
                                    //For a vertical scroll I'd use '.minY' instead
                                    .rotation3DEffect(Angle(degrees:  Double(geomentry.frame(in: .global).minX - 30) / -20), axis:(x: 0, y: 10.0, z: 0))
                            }
                            .frame(width: 275, height: 275)
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
    //Adding the new data structure to the SectionView
    var section: Section
    
    var body: some View {
        VStack {
            HStack(alignment: .top) {
                //Data structure replacement below
                Text(section.title)
                    .font(.system(size: 24, weight: .bold))
                    .frame(width: 160, alignment: .leading)
                Spacer()
                Image(section.logo)
            }
            //Data structure replacement below
            Text(section.text.uppercased())
                .frame(maxWidth: .infinity, alignment: .leading)
            
            //Replaced Image("Card1" with Data Structure info
            section.image
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 210)
            
        }
        .padding(.top, 20)
        .padding(.horizontal, 20)
        .frame(width: 275, height: 275)
        .background(section.color)
        .cornerRadius(30)
        //Updated below with new Data Structure
        .shadow(color: section.color.opacity(0.3), radius: 20, x: 0, y: 20)
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
    Section(title: "Prototype designs made with SwiftUI", text: "18 Sections", logo: "Logo1", image: Image("Card1"), color: Color(#colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1))),
    Section(title: "Designing with Color Literal", text: "3 Sections", logo: "Logo1", image: Image("Card1"), color: Color(#colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1))),
    Section(title: "Coding with Image Literal", text: "14 Sections", logo: "Logo1", image: Image("Card1"), color: Color(#colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1))),
]

//Below with color literal is a great way to find the color you need
//colorLiteral
//
//To find a specific image you can use the following!! -> imageliteral
//imageLiteral

