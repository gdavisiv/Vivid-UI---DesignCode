//
//  Home.swift
//  DesignCode_1
//
//  Created by GdavisIV on 2/18/20.
//  Copyright © 2020 George Davis IV. All rights reserved.
//
//  This technique is only recommended for light views like a
//  menu or a simple modal. It's not recommended for heavy
//  screens since that may affect performance.
//
//This document has all the screens stacked on top of each other using a ZStack
//This is a test commit

import SwiftUI

struct Home: View {
    
    @State var showProfile = false
    
    //Created a state to store the DRAG gesture translation value
    @State var viewState = CGSize.zero
    //Created the new state: using the state we bind it to HomeView
    @State var showContent = false
    //Show login screen
    @EnvironmentObject var user: UserStore
    
    var body: some View {
        ZStack{
            //Updating for Dark Mode in iOS
            Color("background2")
                .edgesIgnoringSafeArea(.all)
            
            HomeBackgroundView(showProfile: $showProfile)
                .offset(y: showProfile ? -450 : 0)
                //Added Double(viewState.height / 10) - 10 : 0) so that you are dividing 50/10=5 so a softer transition when dragging
                //the bottom menu up or down
                .rotation3DEffect(Angle(degrees: showProfile ? Double(viewState.height / 10) - 10 : 0), axis: (x: 10.0, y: 0, z: 0))
                .scaleEffect(showProfile ? 0.9 : 1)
                .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
                //WE should NOT use .edge on actual view, only should be used on the background
                .edgesIgnoringSafeArea(.all)
            
            //Using the TabView to create a menu on the bottom of the screen
//            TabView {
//                //Using the above state we will bind $showContent
            HomeView(showProfile: $showProfile, showContent: $showContent, viewState: $viewState)
//                    .tabItem {
//                        Image(systemName: "house.fill")
//                        Text("Home")
//                }
//            }
            
            //This shows on demand when clicked
            MenuView(showProfile: $showProfile)
                //This allows you to not see the menu, but still make it interactive
                .background(Color.black.opacity(0.001))
                //Added the screen.height with the detection code at the bottom of this page
                //to make screen size dynamic based on the device!!
                .offset(y: showProfile ? 0 : screen.height)
                //Applies the offset to the menu so that it animates
                .offset(y: viewState.height)
                .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
                //Add this so you can press the profile and make it interactive via tap
                .onTapGesture {
                    self.showProfile.toggle()
                }
                //Add a new drag gesture to the menu view.  If the Y position is
                //higher than a certain number during the drag procvess it will reset the Menu position
                .gesture(
                    DragGesture().onChanged { value in
                        self.viewState = value.translation
                    }
                    .onEnded { value in
                        //this will dismiss the menu past a height of 50 on y-axis
                        if self.viewState.height > 50 {
                            self.showProfile = false
                        }
                        self.viewState = .zero
                        }
                )
            
            if user.showLogin {
                ZStack {
                    LoginView()
                    
                    VStack {
                        HStack {
                            Spacer()
                                Image(systemName: "xmark")
                                    .frame(width: 36, height: 36)
                                    .foregroundColor(.white)
                                    .background(Color.black)
                                    .clipShape(Circle())
                        }
                        Spacer()
                    }
                    .padding()
                    //Allows us to close the login screen when opened
                    .onTapGesture {
                        self.user.showLogin = false
                    }
                }
            }
                //This if statement will allow us to show ContentView() with an If statement
                if showContent {
                    //The content stacks on top of each other so we can hide it by simply setting
                    //the background to white, and then we make it fullscreen by ignoring the safe areas
                    //Updating below for Dark Mode
                    //Color.white.edgesIgnoringSafeArea(.all)
                    BlurView(style: .systemMaterial).edgesIgnoringSafeArea(.all)
                    
                    ContentView()
                    
                    //Add this systemname symbol of 'X' so it will close the showContent view with a x in the top right
                    //corner using systemicons
                    VStack {
                        HStack {
                            Spacer()
                                Image(systemName: "xmark")
                                    .frame(width: 36, height: 36)
                                    .foregroundColor(.white)
                                    .background(Color.black)
                                    .clipShape(Circle())
                                }
                                Spacer()
                            }
                            .offset(x: -16, y: 16)
                //Downside with IF is that you don't have the same control over the custom animations
                //what you use instead is a modifier called .transition
//The OUT-transition is being masked by the bottom content
//No current solution to this unfortunately in Swift Coding
                .transition(.move(edge: .top))
                .animation(.spring(response: 0.6, dampingFraction: 0.8, blendDuration: 0))
                .onTapGesture{
                    self.showContent = false
                }
            }
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        //Commented out original Home to add in customization of app in dark mode
        //Home()
        Home()
            //Color Scheme for turning on dark mode option
//          .environment(\.colorScheme, .dark)
//          //For accessibility you can add the following code to preview works best with dynamic types
//          .environment(\.sizeCategory, .extraExtraLarge)
            .environmentObject(UserStore())
    }
}

struct AvatarView: View {
    //Have to add this binding because the self.showProfile will give an error otherwise below
    @Binding var showProfile: Bool
    //Now I can get information about the user and use that to show different buttons
    @EnvironmentObject var user : UserStore
    
    var body: some View {
        VStack {
            //Show the avatar icon
            if user.isLogged {
                Button(action: { self.showProfile.toggle() }) {
                Image("Avatar")
                    .renderingMode(.original)
                    .resizable()
                    .frame(width: 36, height: 36)
                    .clipShape(Circle())
                }
                //Shows avatar icon when you are not logged in
            } else {
                Button(action: { self.user.showLogin.toggle() }) {
                    Image(systemName: "person")
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
            }
        }
    }
}

//We can use this code to detect screen size and now we can make screen size dynamic
//across all devices by using screen.height or screen.width for example!! 
let screen = UIScreen.main.bounds

struct HomeBackgroundView: View {
    //Creating a binding so that we can have round corners
    @Binding var showProfile: Bool
    
    var body: some View {
        //Removing padding because it does not display properly on iPad
        //.padding(.top, 35)
        //Created a background gradient for the main screen
        VStack {
            //Updating for Dark Mode
            LinearGradient(gradient: Gradient(colors:[Color("background2"), Color("background1")]),
                startPoint: .top, endPoint: .bottom)
                    .frame(height: 200)
            Spacer()
        }
        .background(Color("background1"))
        //Is showProfile true? if yes, set it to 30 otherwise set it to Zero
        .clipShape(RoundedRectangle(cornerRadius: showProfile ? 30 : 0, style: .continuous))
        .shadow(color: Color.black.opacity(0.2), radius: 20, x: 0, y: 20)
    }
}
