//
//  CourseList.swift
//  DesignCode_1
//
//  Created by user163072 on 3/24/20.
//  Copyright © 2020 user163072. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI

struct CourseList: View {
    //State a starts from Courselist and pass this to each instance of CourseView
    //Bound to a state show at the root level
    //@State var show = false
    //This allows a different state for each card
    //@State var show2 = false
    //Manual States no Longer needed with implementation of Data model
    //This new state will allow us to use the course Array Data created
    //@State var courses = courseData
    //Going to use the Combine store instead
    @ObservedObject var store = CourseStore()
    //Create this state for the status bar toggle
    @State var active = false
    @State var activeIndex = -1
    @State var activeView = CGSize.zero
    //Set the enviornment  : predefined mode of size for the iPad
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    //Create a new state for isScrollable
    @State var isScrollable = false
    
    
    var body: some View {
        GeometryReader { bounds in
            ZStack {
                //Enables the background to change color due to state and binding
                Color.black.opacity(Double(self.activeView.height/500))
                    .animation(.linear)
                    .edgesIgnoringSafeArea(.all)
                    //Adding in the contentful API Data to test!

                ScrollView {
                    VStack(spacing: 30) {
                        Text("Courses")
                            .font(.largeTitle).bold()
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 30)
                            .padding(.top, 30)
                            //Simple blur animation that is set to 20, otherwise 0
                            .blur(radius: self.active ? 20 : 0)
                        
                        
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
                                    activeView: self.$activeView, bounds: bounds,
                                    isScrollable: self.$isScrollable
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
                    }
                    //Automatically will resize with iPad split screen options
                    .frame(width: bounds.size.width)
                    //This fixes the sudden animation transition with the loading cards
                    .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
                    
                }
                //How to animate hiding the statusbar
                //active set it to true, otherwise set it to false
                .statusBar(hidden: self.active ? true : false)
                //Add a simple fadeout animation
                .animation(.linear)
                //self.active when the user clicks on the card, then not self.isScrollable is set to true, else false
                .disabled(self.active && !self.isScrollable ? true : false)
            }
        }
    }
}

//Create a function to handle the max width of the iPAD
//IF width is greater then 712 then return 712 else -60
func getCardWidth(bounds: GeometryProxy) -> CGFloat {
    if bounds.size.width > 712 {
        return 712
    }
    return bounds.size.width - 60
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
    @Binding var active: Bool
    var index: Int
    @Binding var activeIndex: Int
    //Creating a new state for our dismiss gesture
    @Binding var activeView: CGSize
    //This binding is created so that whenever we open a card, that card will auto hide the status bar
    var bounds: GeometryProxy
    //Creating a new state so that we can control the scrolling independent of show
    @Binding var isScrollable: Bool
    
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
            .animation(nil)
            .padding(30)
            //show .infinity otherwise set it to screen.width - 60
            .frame(maxWidth: show ? .infinity : screen.width - 60, maxHeight: show ? .infinity : 280, alignment: .top)
            .offset(y: show ? 460 : 0)
            //Update code for dark mode
            //.background(Color.white)
            .background(Color("background1"))
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
                            //Creating an offset modifier
                            //Repositining the XMark on the Card, moving it up slightly to right
                            .offset(x: 2, y: -2)
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
                //Adding an Drag Gesture to the card exit/intro animations
                .gesture(
                    //Only will be enabled when we click on the actual card
                    show ?
                    //When we tap and drag we will get the translation sent to our activeView
                    DragGesture().onChanged { value in
                        //MAke sure to drag less than 300 else stop/return
                        guard value.translation.height < 300 else { return }
                        //Disable the ability to drag upward and make the card animate
                        guard value.translation.height > 0 else { return }
                        self.activeView = value.translation
                        
                    }
                        //This will reset the position when the let got of the screen
                    .onEnded { value in
                        //DRag a little anymore than 50 and it goes back to the main screen
                        if self.activeView.height > 50 {
                            self.show = false
                            self.active = false
                            self.activeIndex = -1
                            self.isScrollable = false
                        }
                        self.activeView = .zero
                    }
                    : nil
                )
                //Have to move the animation from this location to parent container because we want it to effect
                //the text and card at the same time, instead of just the card
                //.animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
                .onTapGesture {
                    self.show.toggle()
                    self.active.toggle()
                    //When we are tapping on the card, and it is active
                    //This allows us to pass the value of the index, and track which card is active when clicked
                    if self.show {
                        self.activeIndex = self.index
                    } else {
                        self.activeIndex = -1
                    }
                    //This State will Wait for the animation to be over first after 0.7 seconds,
                    //and then summon the fullscreen view
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                        self.isScrollable = true
                    }
                }
            
            if isScrollable {
                //Until the errors with dragging and gestures can be resolved it is
                //best to leave this code commented out for now
                CourseDetail(course: course, show: $show, active: $active, activeIndex: $activeIndex, isScrollable: $isScrollable, bounds: bounds)
                    .background(Color.white)
                    .clipshape(RoundedRectangle(cornerRadius: getCardCornerRadius(bounds: bounds), style: .continuous))
                    .animation(nil)
                    //By defaulw when you use a condition by default it will use a new fade in animation/transition.
                    //We need to turn off the fade in animation that is set by default
                    .transition(.identity)
            }
            //This works in tandem with the .frame code from above to make the card expand to fullscreen MODE
            //Move this also with the addition of the Text
            //.edgesIgnoringSafeArea(.all)
        }
        //added this code so that it can expands
        .frame(height: show ? bounds.size.height + bounds.safeAreaInsets.top + bounds.safeAreaInsets.bottom : 280)
        //This scale effect will add the animation for the Drag Gesture
        //we divide by 1000 because the number is large due to pizel density of the screen
        .scaleEffect(1 - self.activeView.height / 1000)
        .rotation3DEffect(Angle(degrees: Double(self.activeView.height / 10)), axis: (x: 0, y: 10.0, z: 0))
        //A Flash technique that can or can not be used
        .hueRotation(Angle(degrees: Double(self.activeView.height)))
        .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
        //Copying the gesture code from above will allow the user to drag from any point on the screen and not
        //just the upper half
        .gesture(
            //Only will be enabled when we click on the actual card
            show ?
                //When we tap and drag we will get the translation sent to our activeView
                DragGesture().onChanged { value in
                    //MAke sure to drag less than 300 else stop/return
                    guard value.translation.height < 300 else { return }
                    //Disable the ability to drag upward and make the card animate
                    guard value.translation.height > 50 else { return }
                    self.activeView = value.translation
                    
                }
                    //This will reset the position when the let got of the screen
                    .onEnded { value in
                        //DRag a little anymore than 50 and it goes back to the main screen
                        if self.activeView.height > 50 {
                            self.show = false
                            self.active = false
                            self.activeIndex = -1
                            self.isScrollable = false
                        }
                        self.activeView = .zero
                }
                : nil
        )
        //Set disabled after gesture
        //Disabled Modifier, uses boolean, if true, element can not be draggable/tappable
        //active when the user is tapped, and not is scrollable, true otherwise false
        .disabled(active && !isScrollable ? true : false)
        .edgesIgnoringSafeArea(.all)
        
    }
}

//Set the data model via Array
//This is going to store the show state for each variation of the cards

struct Course: Identifiable {
    var id = UUID()
    var title: String
    var subtitle: String
    //Update with URL of Image
    var image: URL
    var logo: UIImage
    var color: UIColor
    var show: Bool
    
}

//Created the mock Data
//Each array is using a Data model, and set show to false by default
//I've updated the image to use a URL from DropBox, we also have to make sure that the link has
//the 'dl.' added after the '//'
var courseData = [
    Course(title: "Protyping for Designing in SwiftUI", subtitle: "18 Sections", image: URL(string: "https://dl.dropbox.com/s/dpq6sdc4kls3ntz/Card2%402x.png?dl=0")!, logo: #imageLiteral(resourceName: "Logo1"), color: #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1), show: false),
    Course(title: "Advanced Designing in SwiftUI", subtitle: "18 Sections", image: URL(string: "https://dl.dropbox.com/s/oiiz78l7urk9zj5/Card4%402x.png?dl=0")!, logo: #imageLiteral(resourceName: "Logo1"), color: #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1), show: false),
    Course(title: "UI Design for Developers", subtitle: "18 Sections", image: URL(string: "https://dl.dropbox.com/s/k8zmfd12n0i5cjw/Certificate%402x.png?dl=0")!, logo: #imageLiteral(resourceName: "Logo1"), color: #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1), show: false)
]
