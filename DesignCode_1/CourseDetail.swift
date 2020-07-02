//
//  CourseDetail.swift
//  DesignCode_1
//
//  Created by GdavisIV on 4/3/20.
//  Copyright © 2020 George Davis IV. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI

struct CourseDetail: View {
    var course: Course
    @Binding var show: Bool
    //Create these bindings for the onTapGesture
    @Binding var active: Bool
    @Binding var activeIndex: Int
    @Binding var isScrollable: Bool
    
    var body: some View {
        ScrollView {
            //Fixes the spacing between the bottom of the card, and the beginning on the text, fixing the shadow cut off
            VStack(spacing: 0) {
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
                            VStack {
                                Image(systemName: "xmark")
                                    .font(.system(size: 16, weight: .medium))
                                    .foregroundColor(.white)
                            }
                            .frame(width: 36, height: 36)
                            .background(Color.black)
                            .clipShape(Circle())
                            .onTapGesture {
                                self.show = false
                                self.active = false
                                self.activeIndex = -1
                                //Setting this binding will completely hide the CourseDetail View when we click on close button
                                self.isScrollable = false
                            }
                        }
                    }
                    Spacer()
                    //Update to new Datay Array
                    //Image(uiImage: #imageLiteral(resourceName: "Card2"))
                    //Image(uiImage: course.image)
                    //With the implementation of SDWebImage this is how we can now properly display images from the web
                    WebImage(url: course.image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: .infinity)
                        .frame(height: 140, alignment: .top)
                }
                    //Add animation to the padding modifier so that it updates from CArd to Fullscreen Mode
                    .padding(show ? 40 : 20)
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
                
                VStack(alignment: .leading, spacing: 30.0) {
                    Text("Learn Advanced SwiftUI skills take take your apps to the next level, with techniques such as API Data, packages and CMS!")
                    Text("Info about this course")
                        .font(.title).bold()
                    Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.")
                    Text("Consequat interdum varius sit amet mattis. A arcu cursus vitae congue mauris rhoncus aenean vel. Integer vitae justo eget magna fermentum iaculis. Vel facilisis volutpat est velit egestas. Id diam vel quam elementum pulvinar etiam non. Purus sit amet volutpat consequat mauris nunc congue nisi vitae. Parturient montes nascetur ridiculus mus mauris vitae")
                }
                .padding(30)
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct CourseDetail_Previews: PreviewProvider {
    static var previews: some View {
        CourseDetail(course: courseData[0], show: .constant(true), active: .constant(true), activeIndex: .constant(-1), isScrollable: .constant(true))
    }
}
