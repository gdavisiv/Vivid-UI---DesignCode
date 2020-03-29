//
//  CourseList.swift
//  DesignCode_1
//
//  Created by user163072 on 3/24/20.
//  Copyright © 2020 user163072. All rights reserved.
//

import SwiftUI

struct CourseList: View {
    //State a starts from Courselist and pass this to each instance of CourseView
    //Bound to a state show at the root level
    //@State var show = false
    //This allows a different state for each card
    //@State var show2 = false
    //Manual States no Longer needed with implementation of Data model
    //This new state will allow us to use the course Array Data created
    @State var courses = courseData
    
    var body: some View {
        ScrollView {
            VStack(spacing: 30) {
                //This will repeat the demo record 5 times (***PAY ATTENTION TO SPACING!!!***)
                //instead of looping through the courses we are going to get the index value for the courses
                //This will provide the index
                ForEach(courses.indices, id: \.self) { index in
                //Don't need the code below now that we are implementing Course Data from an Array
                //CourseView(show: $show)
                //Use the gemetry reader to detect the scroll positions of every single card, and use those positions
                //to create a gap between the two cardsdetermine the spacing over every single card
                    GeometryReader { geometry in
                        //We will need to use self since we are inside Geometry Reader
                        //CourseView(show: self.$show2)
                        //To use the Courses Array we call the following
                        CourseView(show: self.$courses[index].show, course: self.courses[index])
                            //If self.show2 this is in fullscreen it will use minY position (between the two cards) else don't change anything
                            //minY is the position of the top of the second card, and we use negative minY to fill the gap left
                            //by the top card as it receeds, else don't change anything
                            .offset(y: self.courses[index].show ? -geometry.frame(in: .global).minY: 0)
                    }
                        //Since I added the for each, have to update self.show2 with self first with self.courses[index].show
                    //this should fix the height of the container at fullscreen
                    //If show2 is true, set it to scree.height, otherwise set it to 280
                    .frame(height: self.courses[index].show ? screen.height : 280)
                    //This will move the second card, because the card is set to infinity, and it is centered in the vstack with width - 60
                    .frame(maxWidth: self.courses[index].show ? .infinity : screen.width - 60)
                }
            }
            .frame(width: screen.width)
            //This fixes the sudden animation transition
            .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
            
        }
    }
}

struct CourseList_Previews: PreviewProvider {
    static var previews: some View {
        CourseList()
    }
}

//Create a new struct to reference
struct CourseView: View {
    //Need to use a State to create animation
    //To add a second card we need to change the state from State to a Binding
    //@State var show = false
    @Binding var show: Bool
    //State applying the Data Array
    var course: Course
    
    var body: some View {
        //Added ZStack to add content behind the created card on Z axis
        ZStack(alignment: .top) {
            VStack(alignment: .leading, spacing: 30.0) {
                Text("Learn Advanced SwiftUI skills take take your apps to the next level, with techniques such as API Data, packages and CMS!")
                Text("Info about this course")
                    .font(.title).bold()
                Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.")
                Text("Consequat interdum varius sit amet mattis. A arcu cursus vitae congue mauris rhoncus aenean vel. Integer vitae justo eget magna fermentum iaculis. Vel facilisis volutpat est velit egestas. Id diam vel quam elementum pulvinar etiam non. Purus sit amet volutpat consequat mauris nunc congue nisi vitae. Parturient montes nascetur ridiculus mus mauris vitae")
            }
            .padding(30)
            //show .infinity otherwise set it to screen.width - 60
            .frame(maxWidth: show ? .infinity : screen.width - 60, maxHeight: show ? .infinity : 280, alignment: .top)
            .offset(y: show ? 460 : 0)
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
            .shadow(color: Color.black.opacity(0.2), radius: 20, x: 0, y: 20)
            .opacity(show ? 1 : 0)
            
            
            VStack {
                HStack(alignment: .top) {
                    VStack(alignment: .leading, spacing: 8.0) {
                        //Update to new Code
                        //Text("iOS Swift UI Advanced")
                        Text(course.title)
                            .font(.system(size: 24, weight: .bold))
                            .foregroundColor(.white)
                        //Update to new Data Array
                        //Text("20 Sections")
                        Text(course.subtitle)
                            .foregroundColor(Color.white.opacity(0.7))
                        }
                        Spacer()
                        //ImageLiteral to easily select an image in your assets folder!
                    ZStack {
                        //Update to new Data Array
                        //Image(uiImage: #imageLiteral(resourceName: "Logo1"))
                        Image(uiImage: course.logo)
                            //This will set the opacity to 0 otherwise set it to 1 or show
                            //This will make the logo disappear in fullscreen mode
                            .opacity(show ? 0 : 1)
                        VStack {
                            Image(systemName: "xmark")
                                .font(.system(size: 16, weight: .medium))
                                .foregroundColor(.white)
                            }
                            .frame(width: 36, height: 36)
                            .background(Color.black)
                            .clipShape(Circle())
                            //We set this up in reverse since we only want the 'X' to show when we are in full screen mode
                            .opacity(show ? 1 : 0)
                        }
                    }
                    Spacer()
                    //Update to new Datay Array
                    //Image(uiImage: #imageLiteral(resourceName: "Card2"))
                    Image(uiImage: course.image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: .infinity)
                        .frame(height: 140, alignment: .top)
                }
                //Add animation to the padding modifier so that it updates from CArd to Fullscreen Mode
                .padding(show ? 30 : 20)
                //This adds extra padding at the very top so that it does not intefer with the top Status Menu
                //.padding(.top, show ? 30 : 0)
                //This following code will add the transition animation
                //Adding a Tap Gesture : Just need to update the frame, show screen.width otherwise show width - 60; ""
                //.frame(width: show ? screen.width : screen.width - 60, height: show ? screen.height : 280)
                //There is a better way to write the same code as shown above!  This will ensure that the card
                //maximizes and takes up the entire screen
                .frame(maxWidth: show ? .infinity : screen.width - 60, maxHeight: show ? 460 : 280)
                //Update to new Array Data
                //.background(Color(#colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)))
                .background(Color(course.color))
                .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
                //Update to new Array Data
                //.shadow(color: Color(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)).opacity(0.3), radius: 20, x: 0, y: 20)
                .shadow(color: Color(course.color).opacity(0.3), radius: 20, x: 0, y: 20)
                //Have to move the animation from this location to parent container because we want it to effect
                //the text and card at the same time, instead of just the card
                //.animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
                .onTapGesture {
                    self.show.toggle()
            }
            //This works in tandem with the .frame code from above to make the card expand to fullscreen MODE
            //Move this also with the addition of the Text
            //.edgesIgnoringSafeArea(.all)
        }
        .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
        .edgesIgnoringSafeArea(.all)
        
    }
}

//Set the data model via Array
//This is going to store the show state for each variation of the cards

struct Course: Identifiable {
    var id = UUID()
    var title: String
    var subtitle: String
    var image: UIImage
    var logo: UIImage
    var color: UIColor
    var show: Bool
    
}

//Created the mock Data
//Each array is using a Data model, and set show to false by default
var courseData = [
    Course(title: "Protyping for Designing in SwiftUI", subtitle: "18 Sections", image: #imageLiteral(resourceName: "Background1"), logo: #imageLiteral(resourceName: "Logo1"), color: #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1), show: false),
    Course(title: "Advanced Designing in SwiftUI", subtitle: "18 Sections", image: #imageLiteral(resourceName: "Background1"), logo: #imageLiteral(resourceName: "Logo1"), color: #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1), show: false),
    Course(title: "UI Design for Developers", subtitle: "18 Sections", image: #imageLiteral(resourceName: "Card5"), logo: #imageLiteral(resourceName: "Logo1"), color: #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1), show: false)
]
