//
//  ContentView.swift
//  DesignCode_1
//
//  Created by GdavisIV on 2/9/20.
//  Copyright © 2020 GdavisIV. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    //This is a simple Boolean created at the root level that is True or False that will
    //allow us to swtich between Animation States (also will need '.self' to be declared)
    @State var show = false
    //We are storing CGSize that has x and y position, and the default value will be zero
    //We can use it whenever we want to setup animations later on..
    @State var viewState = CGSize.zero
    
    var body: some View {
        ZStack{
            //Calls the struct below and displays the top title and image
            TitleView()
                .blur(radius: show ? 20 : 0)
                .animation(.default)
            
            //Make sure that the order of operations is followed for applying
            //these different effects upon the struct
            //This is the back card
            BackCardView()
                .background(show ? Color("card3") : Color("card4"))
                .cornerRadius(20)
                .shadow(radius: 20)
                //This is the ternary operator 'show ? :' if show = true set -400 else set to -40
                .offset(x:0, y: show ? -400 : -40)
                //Set a modifier offset before gestures for less lag, and then move the card
                //based off the location of the user finger on the screen
                .offset(x: viewState.width, y: viewState.height)
                .scaleEffect(0.9)
                //This is the ternary operator 'show ? :' if show = true set 0 else set to 10
                .rotationEffect(Angle(degrees: show ? 0 : 10))
                .rotation3DEffect(Angle(degrees: 10), axis: (x: 10, y: 0, z: 0))
                .blendMode(.hardLight)
                .animation(.easeInOut(duration: 0.5))
            
            
            //This is the middle card or check Assets to find out
            //Same applies here follow the order of operations for effects
            BackCardView()
                .background(show ? Color("card4") : Color("card3"))
                .cornerRadius(20)
                .shadow(radius: 20)
                //This is the ternary operator 'show ? :' if show = true set -200 else set to -20
                .offset(x:0, y: show ? -200 : -20)
                //Set a modifier offset before gestures for less lag, and then move the card
                //based off the location of the user finger on the screen
                .offset(x: viewState.width, y: viewState.height)
                .scaleEffect(0.95)
                //This is the ternary operator 'show ? :' if show = true set 0 else set to 5
                .rotationEffect(Angle.degrees(show ? 0 : 5))
                .rotation3DEffect(Angle(degrees: 5), axis: (x: 10, y: 0, z: 0))
                .blendMode(.hardLight)
                .animation(.easeInOut(duration: 0.3))
            
            
            //This is the front facing card
            CardView()
                //Set a modifier offset before gestures for less lag, and then move the card
                //based off the location of the user finger on the screen
                .offset(x: viewState.width, y: viewState.height)
                .blendMode(.hardLight)
                //Add spring animation here so there is not any lag!
                .animation(.spring(response: 0.3, dampingFraction: 0.6, blendDuration: 0))
                //Use the event below to create an Animation
                .onTapGesture {
                    self.show.toggle()
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
            
            
            //This is the Bottom card that shows info about the top card the user
            //is reading
            BottomCardView()
                .blur(radius: show ? 20 : 0)
                .animation(.default)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
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
        .frame(width:340.0, height: 220.0)
        .background(Color.black)
        .cornerRadius(20)
        .shadow(radius: 20)
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
            .frame(width:340, height: 220)
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
                Spacer()
        }
    }
}

struct BottomCardView: View {
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
                Spacer()
            }
                //!!!!!!Always padding before background!!!!!!!
                .padding(.top, 8)
                .padding(.horizontal, 20)
                // This property (maxWidth: .infinity) will mmake sure that the sides touch the left and right
                //regardless of the device that is used!!
                .frame(maxWidth: .infinity)
                .background(Color.white)
                .cornerRadius(30)
                .shadow(radius: 20)
                .offset(x: 0, y: 550)
    }
}

