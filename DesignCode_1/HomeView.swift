//
//  HomeView.swift
//  DesignCode_1
//
//  Created by GdavisIV on 3/10/20.
//  Copyright © 2020 George Davis IV. All rights reserved.
//

import SwiftUI

struct HomeView: View {
    @Binding var showProfile: Bool
    
    //Added a new state for the Scene Transition Button
    @State var showUpdate = false
    
    //We want to organize all our views in HomeSwift so we create this new binding and
    //bind it to a state in home.swift
    @Binding var showContent: Bool
    
    var body: some View {
        ScrollView {
            VStack {
                HStack {
                    Text("Watching")
                        //.font(.system(size: 28, weight: .bold))
                        .modifier(CustomFontModifier(size: 35))
                    
                    Spacer()
                    
                    //Pass that state as a binding and add the $ :
                    //Bindings are considered to be a property of the object which is bound,
                    //and all information related to bindings should be owned by the object.
                    AvatarView(showProfile: $showProfile)
                    
                    //This allows the button to toggle between a true/false state and being able to
                    //click the bell
                    Button(action: {self.showUpdate.toggle() }) {
                        Image(systemName: "bell")
                            .renderingMode(.original)
                            .font(.system(size: 16, weight: .medium))
                            .frame(width: 36, height: 36)
                            .background(Color.white)
                            //makes the shape a circle
                            .clipShape(Circle())
                            //Adds two shadows so that it has a foreground/background Shadow
                            .shadow(color: Color.black.opacity(0.1), radius: 1, x: 0, y: 1)
                            .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 10)
                        
                    }
                    //This brings up the modal ContentView
                    .sheet(isPresented: $showUpdate) {
                        //Changed this from ContentView() after finishing the buildout of UpdateList()
                        UpdateList()
                    }
                }
                .padding(.horizontal)
                .padding(.leading, 14)
                .padding(.top, 30)
            
            //Enables Horizontal scrolling, and turns off indicators
            ScrollView(.horizontal, showsIndicators: false) {
                WatchRingsView()
                    .padding(.horizontal, 30)
                    .padding(.bottom, 30)
                    //This will set it to true whenever the screen is touched
                    //This will allow that anytime the ring views are clicked it will be aware of that via
                    //showContent
                    .onTapGesture {
                        self.showContent = true
                    }
            }
            
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
                //This code will offset and move the sections data cards up a bit to reduce the spacing
                .offset(y: -30)
                
                HStack {
                    Text("Courses")
                        .font(.title).bold()
                    Spacer()
                }
                .padding(.leading, 30)
                //Moves up "Courses" on the y axis a bit higher
                .offset(y: -60)
            
                //Pulling in the values from the SectionView Allows the width and height to be easily customizable
                SectionView(section: sectionData[2], width: screen.width - 60, height: 275)
                .offset(y: -60)
            
                Spacer()
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        //Have to update this because we created a new file HomeView, this is different from
        //extracting a subview : the HomeView needs some setting.  WE CAN'T pass a state, because
        //we don't have a state to use.  So instead we set .constant(false)
        //We have to do this for both showProfile and showContent for the ringviews
        HomeView(showProfile: .constant(false), showContent: .constant(false))
    }
}

struct SectionView: View {
    //Adding the new data structure to the SectionView
    var section: Section
    //Added these two variables to make the width and height easily customizable
    var width: CGFloat = 275
    var height: CGFloat = 275
    
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


struct WatchRingsView: View {
    var body: some View {
        //Added this Ring Indicator to the top of the HomeView
        //This RingView will not be animated an instead .constant(true)
        //Added a bouding box with apply edits to the HStack
        HStack(spacing: 30) {
            HStack {
                RingView(color1: #colorLiteral(red: 0.1764705926, green: 0.01176470611, blue: 0.5607843399, alpha: 1), color2: #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1), width: 44, height: 44,
                         percent: 68, show: .constant(true))
                VStack(alignment: .leading, spacing: 4.0){
                    //We can call upon the modifier that was created that also allows editing
                    //to the .body with the following modifier
                    Text("10 mins left!!").bold().modifier(FontModifier(style: .subheadline))
                    Text("Watch 10 mins today!").modifier(FontModifier(style: .caption))
                }
                .modifier(FontModifier())
            }
            .padding(8)
            .background(Color.white)
            .cornerRadius(20)
            //This allows us to use the shadow modifier by calling it in this instance
            .modifier(ShadowModifier())
            
            HStack(spacing: 12) {
                RingView(color1: #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1), color2: #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1), width: 40, height: 40,
                         percent: 36, show: .constant(true))
            }
            .padding(8)
            .background(Color.white)
            .cornerRadius(20)
            //This allows us to use the shadow modifier by calling it in this instance
            .modifier(ShadowModifier())
            
            HStack(spacing: 12.0) {
                RingView(color1: #colorLiteral(red: 0.3176470697, green: 0.07450980693, blue: 0.02745098062, alpha: 1), color2: #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1), width: 40, height: 40,
                         percent: 89, show: .constant(true))
            }
            .padding(8)
            .background(Color.white)
            .cornerRadius(20)
            //This allows us to use the shadow modifier by calling it in this instance
            .modifier(ShadowModifier())
        }
    }
}
