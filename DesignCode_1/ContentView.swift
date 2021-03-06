//Start from Dismiss and Drag Anchors
//
//  ContentView.swift
//  DesignCode_1
//
//  Created by GdavisIV on 2/9/20.
//  Copyright © 2020 GdavisIV. All rights reserved.
//
//**Rotation 3D Effect does not work on IPAD so comment that code out until a fix is found**

import SwiftUI

struct ContentView: View {
    //This is a simple Boolean created at the root level that is True or False that will
    //allow us to swtich between Animation States (also will need '.self' to be declared)
    @State var show = false
    //We are storing CGSize that has x and y position, and the default value will be zero
    //We can use it whenever we want to setup animations later on..
    @State var viewState = CGSize.zero
    //This will create a root level animation state for showing the bottom card
    @State var showCard = false
    @State var bottomState = CGSize.zero
    @State var showFull = false
    
    var body: some View {
        ZStack{
            
            //Calls the struct below and displays the top title and image
            TitleView()
                .blur(radius: show ? 20 : 0)
                .opacity(showCard ? 0.4 : 1)
                .offset(y: showCard ? -200 : 0)
                .animation(
                    Animation
                        .default
                        .delay(0.1)
//                      .speed(2)
//                      .repeatForever(autoreverses: true)
                )
            
            
            //Make sure that the order of operations is followed for applying
            //these different effects upon the struct
            //This is the back card
            BackCardView()
                //Updated to maxWidth
                .frame(maxWidth: showCard ? 300 : 340)
                .frame(height: 220)
                .background(show ? Color("card3") : Color("card4"))
                .cornerRadius(20)
                .shadow(radius: 20)
                //This is the ternary operator 'show ? :' if show = true set -400 else set to -40
                .offset(x:0, y: show ? -400 : -40)
                //Set a modifier offset before gestures for less lag, and then move the card
                //based off the location of the user finger on the screen
                .offset(x: viewState.width, y: viewState.height)
                .offset(y: showCard ? -180 : 0)
                .scaleEffect(showCard ? 1 : 0.9)
                //This is the ternary operator 'show ? :' if show = true set 0 else set to 10
                .rotationEffect(Angle(degrees: show ? 0 : 10))
                .rotationEffect(Angle(degrees: showCard ? -10 : 0))
                .rotation3DEffect(Angle(degrees: showCard ? 0 : 10), axis: (x: 10, y: 0, z: 0))
                .blendMode(.hardLight)
                .animation(.easeInOut(duration: 0.5))
            
            
            //This is the middle card or check Assets to find out
            //Same applies here follow the order of operations for effects
            BackCardView()
                //Updated to maxWidth/.frame height
                .frame(maxWidth:340)
                .frame(height: 220)
                .background(show ? Color("card4") : Color("card3"))
                .cornerRadius(20)
                .shadow(radius: 20)
                //This is the ternary operator 'show ? :' if show = true set -200 else set to -20
                .offset(x:0, y: show ? -200 : -20)
                //Set a modifier offset before gestures for less lag, and then move the card
                //based off the location of the user finger on the screen
                .offset(x: viewState.width, y: viewState.height)
                .offset(y: showCard ? -140 : 0)
                .scaleEffect(showCard ? 1 : 0.95)
                //This is the ternary operator 'show ? :' if show = true set 0 else set to 5
                .rotationEffect(Angle.degrees(show ? 0 : 5))
                .rotationEffect(Angle(degrees: showCard ? -5 : 0))
                //On iPad an odd transformation occurs
                //.rotation3DEffect(Angle(degrees: showCard ? 0 : 5), axis: (x: 10, y: 0, z: 0))
                .blendMode(.hardLight)
                .animation(.easeInOut(duration: 0.3))
            
            
            //This is the front facing card
            CardView()
                .frame(maxWidth: showCard ? 370 : 340.0)
                .frame(height: 220.0)
                .background(Color.black)
//              .cornerRadius(20)
                .clipShape(RoundedRectangle(cornerRadius: showCard ? 30 : 20, style: .continuous))
                .shadow(radius: 20)
                //Set a modifier offset before gestures for less lag, and then move the card
                //based off the location of the user finger on the screen
                .offset(x: viewState.width, y: viewState.height)
                .offset(y: showCard ? -100 : 0)
                .blendMode(.hardLight)
                //Add spring animation here so there is not any lag!
                .animation(.spring(response: 0.3, dampingFraction: 0.6, blendDuration: 0))
                //Use the event below to create an Animation
                .onTapGesture {
                    self.showCard.toggle()
                }
                //Everytime that you drag on the screen with your finger the movement values of x/y are
                //sent to 'value', and are stroed in 'viewState'
                .gesture(DragGesture().onChanged { value in
                        self.viewState = value.translation
                        //This sets show to TRUE
                        self.show = true
                    }
                //Once your finger is lifted from the scren then 'viewState' will be reset to 0 and the
                //card will return to its original position
                .onEnded { value in
                        self.viewState = .zero
                        //This sets show to False
                        self.show = false
                    }
                )
            
            //****Useful Coding trick that will display the current position of an element****
            //****so you know what values to plug into it!!! :D ****
//            Text("\(bottomState.height)").offset(y: -300)
            
            //This is the Bottom card that shows info about the top card the user
            //is reading
            //Connect the Binding from outside the Bottom Card View for the Ring Animation using $showCard
            GeometryReader { bounds in
                BottomCardView(show: self.$showCard)
                    //If showcard is true then it will animate and move to the middle of the screen
                    //Using 'bounds.safe..." This is detecting the status bar size, and the home indicator
                    //through using the Geometry Reader, this detects the status bar size and the home indicator
                    //using Geometry Reader
                    .offset(x: 0, y: self.showCard ? bounds.size.height / 2 : bounds.size.height + bounds.safeAreaInsets.top + bounds.safeAreaInsets.bottom)
                    //This appplies the drag values from .gesture via bottomState for the y position
                    .offset(y: self.bottomState.height)
                    .blur(radius: self.show ? 20 : 0)
                    //Use the website www.cubic-bezier.com to get the appropriate timingcurve you want for
                    //the specific animation
                    .animation(.timingCurve(0.2, 0.8, 0.2, 1, duration: 0.8))
                    .gesture(
                        //Use the onChanged event to store the drag values from the user finger.  When
                        //the drag is released we'll reset the position
                        DragGesture().onChanged { value in
                            self.bottomState = value.translation
                            if self.showFull {
                                self.bottomState.height += -300
                            }
                            if self.bottomState.height < -300 {
                                self.bottomState.height = -300
                            }
                        }
                        //Using the unique trick above to know what the height is of the bottom card, then
                        //we setup rules so that if the user drags the bottom card beyong a certain point it will
                        //either snap to the top or snap to the bottom
                        .onEnded {  value in
                            if self.bottomState.height > 50 {
                                self.showCard = false
                            }
                            if (self.bottomState.height < -100 && !self.showFull) || (self.bottomState.height < -250 && self.showFull)
                            {
                                self.bottomState.height = -300
                                self.showFull = true
                            }
                            else
                            {
                                self.bottomState = .zero
                                self.showFull = false
                            }
                        }
                )
            }
            //The screen height is within the safe area using This trick will fix it.
            //Using Ignore safe area on a parent container can effect all the content in the container
            //.edgesIgnoringSafeArea(.all)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            //Create a simple preview code to view images that will need to be resized later on
            .previewLayout(.fixed(width: 320, height: 667))
    }
}


//This is a unique way to store the UI elments neatly so that they can be easily
//replicated and used in different scenarios
struct CardView: View {
    var body: some View {
            VStack {
                HStack{
                    VStack(alignment: .leading) {
                        Text("UI Design")
                            .font(.title)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                        Text("Certificate")
                            .foregroundColor(Color("accent"))
                    }
                    Spacer()
                    Image("Logo1")
                }
                .padding(.horizontal, 20)
                .padding(.top, 20)
                    Spacer()
                    Image("Card1")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
        }
    }
}


//The Back card is already created and sized properly and can be called
//and then edited as needed
struct BackCardView: View {
    var body: some View {
        ZStack{
            VStack{
                Spacer()
            }
        }
    }
}


struct TitleView: View {
    var body: some View {
            VStack {
                HStack {
                    Text("Certifications")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    
                    Spacer()
                }
                .padding()
                Image("Background1")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: 375)
                Spacer()
        }
    }
}


struct BottomCardView: View {
    //We need to create a Binding for a the Animation Ring, and pass the Binding to the RingView
    @Binding var show: Bool
    
    var body: some View {
            //Will place a spacing of 20 between top/bottom each element in the Vstack!
            VStack(spacing: 20) {
                Rectangle()
                    .frame(width: 40, height: 5)
                    .cornerRadius(3)
                    .opacity(0.1)
                Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.")
                    .multilineTextAlignment(.center)
                    //Use the dynamic types that are defaults for xcode
                    .font(.subheadline)
                    .lineSpacing(4)
                
                HStack(spacing: 20.0) {
                //implementing the ring animation into the bottom info card
                RingView(color1: #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1), color2: #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1), width: 88, height: 88, percent: 78, show: $show)
                    //This adds a delay to the Animation of the Ring Loading
                    //Had to delete the animation easeinout in the RingView.swift because it was over-riding this animation
                    .animation(Animation.easeInOut.delay(0.3))
                
                //
                    VStack(alignment: .leading, spacing: 8.0) {
                        Text("SwiftUI")
                            .fontWeight(.bold)
                        Text("12 of 12 sections completed\n10 hours spent so far!")
                            .font(.footnote)
                            .foregroundColor(.gray)
                            .lineSpacing(4)
                    }
                    .padding(20)
                    //Update code for dark mode
                    //.background(Color.white)
                    .background(Color("background3"))
                    .cornerRadius(20)
                    .shadow(color: Color.black.opacity(0.2), radius: 20, x: 0, y: 10)
                }
                Spacer()
            }
                //!!!!!!Always padding before background!!!!!!!
                .padding(.top, 8)
                .padding(.horizontal, 20)
                // This property (maxWidth: .infinity) will mmake sure that the sides touch the left and right
                //regardless of the device that is used!!
                //Apple uses a maxwidth for text boxes in their iPads of maxWidth:712
                .frame(maxWidth: 712)
                //.background(Color.white)
                //Updating the background from code used above
                .background(BlurView(style: .systemThinMaterial))
                .cornerRadius(30)
                .shadow(radius: 20)
                //This centers the box on the bottom of the screen
                .frame(maxWidth: .infinity)
    }
}

