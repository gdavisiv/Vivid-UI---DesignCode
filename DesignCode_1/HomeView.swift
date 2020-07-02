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
    //Create the Binding for the viewState
    @Binding var viewState: CGSize
    //Need to create states and observed object since we are implementing Courselist info
    @ObservedObject var store = CourseStore()
    //Create this state for the status bar toggle
    @State var active = false
    @State var activeIndex = -1
    @State var activeView = CGSize.zero
    //Set the enviornment  : predefined mode of size for the iPad
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    
    var body: some View {
        //To make sure that the cards are displayed properly on an iPad
        //we need to make sure scrollview works within Geomoetry Reader
        //Geometry read updates dynamically
        GeometryReader { bounds in
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
                        AvatarView(showProfile: self.$showProfile)
                        
                        //This allows the button to toggle between a true/false state and being able to
                        //click the bell
                        Button(action: {self.showUpdate.toggle() }) {
                            Image(systemName: "bell")
                                //Comment out renderMode and instead use foreground
                                //.renderingMode(.original)
                                .foregroundColor(.primary)
                                .font(.system(size: 16, weight: .medium))
                                .frame(width: 36, height: 36)
                                //Updating code for dark mode
                                //.background(Color.white)
                                .background(Color("background3"))
                                //makes the shape a circle
                                .clipShape(Circle())
                                //Adds two shadows so that it has a foreground/background Shadow
                                .shadow(color: Color.black.opacity(0.1), radius: 1, x: 0, y: 1)
                                .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 10)
                            
                        }
                        //This brings up the modal ContentView
                            .sheet(isPresented: self.$showUpdate) {
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
                                        .rotation3DEffect(Angle(degrees:  Double(geomentry.frame(in: .global).minX - 30) / -getAngleMultiplier(bounds: bounds)), axis:(x: 0, y: 10.0, z: 0))
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
                
                    //This will repeat the demo record 5 times (***PAY ATTENTION TO SPACING!!!***)
                    //instead of looping through the courses we are going to get the index value for the courses
                    //This will provide the index
                    ForEach(self.store.courses.indices, id: \.self) { index in
                    //Don't need the code below now that we are implementing Course Data from an Array
                    //CourseView(show: $show)
                    //Use the gemetry reader to detect the scroll positions of every single card, and use those positions
                    //to create a gap between the two cardsdetermine the spacing over every single card
                        GeometryReader { geometry in
                            //We will need to use self since we are inside Geometry Reader
                            //CourseView(show: self.$show2)
                            //To use the Courses Array we call the following
                            CourseView(
                                show: self.$store.courses[index].show,
                                course: self.store.courses[index],
                                active: self.$active,
                                index: index,
                                activeIndex: self.$activeIndex,
                                activeView: self.$activeView, bounds: bounds
                            )
                                //If self.show2 this is in fullscreen it will use minY position (between the two cards) else don't change anything
                                //minY is the position of the top of the second card, and we use negative minY to fill the gap left
                                //by the top card as it receeds, else don't change anything
                                .offset(y: self.store.courses[index].show ? -geometry.frame(in: .global).minY: 0)
                                //When the card is not the one that is active, the card not active will have an opacity of 0 otherwise 1 or visible
                                .opacity(self.activeIndex != index && self.active ? 0 : 1)
                                //Same as above only will reduce the size of the cards now
                                .scaleEffect(self.activeIndex != index && self.active ? 0.5 : 1)
                                //this animation will move the cards to the side
                                //Updated with bounds.size for Geometry Reader
                                .offset(x: self.activeIndex != index && self.active ? bounds.size.width : 0)
                        }
                            //Since I added the for each, have to update self.show2 with self first with self.courses[index].show
                            //this should fix the height of the container at fullscreen
                            //If show2 is true, set it to scree.height, otherwise set it to 280
                    //Updating the height value so that it expands consistently
                    //and not based off its geometry location
                            //but the cards after are still being displayed
                            //This sets the size of the horizontalSizeClass so that it will
                            //be able to adjust based off the device being used
                            .frame(height: self.horizontalSizeClass == .regular ? 80 : 280)
                        //This will move the second card, because the card is set to infinity, and it is centered in the vstack with width - 60
                            .frame(maxWidth: self.store.courses[index].show ?  720 : getCardWidth(bounds: bounds))
                            //If you ever want to animate one element and you want that one element to be ontop of the other elements,
                            //zIndex is what you use to allow that to happen
                            .zIndex(self.store.courses[index].show ? 1 : 0)
                    }
                
                    Spacer()
                }
                //I need to set a specific width to fix the odd transition between screens
                //Updated .frame with bounds.size so that card will display properly on iPad
                .frame(width: bounds.size.width)
                .offset(y: self.showProfile ? -450 : 0)
                 //Added Double(viewState.height / 10) - 10 : 0) so that you are dividing 50/10=5 so a softer transition when dragging
                 //the bottom menu up or down
                .rotation3DEffect(Angle(degrees: self.showProfile ? Double(self.viewState.height / 10) - 10 : 0), axis: (x: 10.0, y: 0, z: 0))
                .scaleEffect(self.showProfile ? 0.9 : 1)
                 .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
            }
        }
    }
}

//Need to make a function that makes the angle of the shadow for the
//Ipad less sharp so that the shadow is not cut off on the bottom
func getAngleMultiplier(bounds: GeometryProxy) -> Double {
    if bounds.size.width > 500 {
        return 80
    } else {
        return 20
    }
}
struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        //Have to update this because we created a new file HomeView, this is different from
        //extracting a subview : the HomeView needs some setting.  WE CAN'T pass a state, because
        //we don't have a state to use.  So instead we set .constant(false)
        //We have to do this for both showProfile and showContent for the ringviews
        HomeView(showProfile: .constant(false), showContent: .constant(false), viewState: .constant(.zero))
        //Add Because we're using an environment to create iPad appropriate view
        .environmentObject(UserStore())
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
            //Update code for dark mode
            //.background(Color.white)
            .background(Color("background3"))
            .cornerRadius(20)
            //This allows us to use the shadow modifier by calling it in this instance
            .modifier(ShadowModifier())
            
            HStack(spacing: 12) {
                RingView(color1: #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1), color2: #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1), width: 40, height: 40,
                         percent: 36, show: .constant(true))
            }
            .padding(8)
            //Update code for dark mode
            //.background(Color.white)
            .background(Color("background3"))
            .cornerRadius(20)
            //This allows us to use the shadow modifier by calling it in this instance
            .modifier(ShadowModifier())
            
            HStack(spacing: 12.0) {
                RingView(color1: #colorLiteral(red: 0.3176470697, green: 0.07450980693, blue: 0.02745098062, alpha: 1), color2: #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1), width: 40, height: 40,
                         percent: 89, show: .constant(true))
            }
            .padding(8)
            //Update code for dark mode
            //.background(Color.white)
            .background(Color("background3"))
            .cornerRadius(20)
            //This allows us to use the shadow modifier by calling it in this instance
            .modifier(ShadowModifier())
        }
    }
}
