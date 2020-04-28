//
//  Buttons.swift
//  DesignCode_1
//
//  Created by George Davis IV on 4/25/20.
//  Copyright © 2020 user163072. All rights reserved.
//

import SwiftUI

struct Buttons: View {
    var body: some View {
        VStack(spacing: 80) {
            RectangleButton()
            
            CircleButton()
            
        }
        //Sets the screen width and height
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        //Setting the background color to color literal set below
        .background(Color(#colorLiteral(red: 0.8933308721, green: 0.935842216, blue: 1, alpha: 1)))
        //Going to ignore the edges and fill the entire screenw
        .edgesIgnoringSafeArea(.all)
        //Adding Spring animation to the button click action
        .animation(.spring(response: 0.5, dampingFraction: 0.8, blendDuration: 0))
    }
}

struct Buttons_Previews: PreviewProvider {
    static var previews: some View {
        Buttons()
    }
}

struct RectangleButton: View {
    //Creating a State for Tap Gesture
    @State var tap = false
    //Creating a State for Press Gesture
    @State var press = false
    
    var body: some View {
        Text("Button")
            .font(.system(size: 20, weight: .semibold, design: .rounded))
            .frame(width: 200, height: 60)
            .background(
                ZStack {
                    //Default will be Grey: If I press it will become white instead
                    Color(press ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) : #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1))
                    
                    //Creating a Second Color Layer with an inner shadow within the button
                    RoundedRectangle(cornerRadius: 16, style:
                        .continuous)
                        //Updated the White inner shadow, it will be white by default and when pressed it will
                        //become light blue instead
                        .foregroundColor(Color(press ? #colorLiteral(red: 0.7350739837, green: 0.8465071321, blue: 0.9345290065, alpha: 0.9990234375) : #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
                        .blur(radius: 4)
                        .offset(x: -8, y: -8)
                    
                    //Creating a third color layer
                    RoundedRectangle(cornerRadius: 16, style:
                        .continuous)
                        .fill(
                            //Adding a Linear gradient that runs from left to right and adds a nice transition between the two colors
                            LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.8593714833, green: 0.87916857, blue: 0.9651435018, alpha: 1)), Color.white]), startPoint: .topLeading, endPoint: .bottomTrailing)
                    )
                        //Adds a slight inner shadow while also adding blur
                        .padding(2)
                        .blur(radius: 2)
                    
                }
        )
            //Roundes the edges of the Rectangle
            .clipShape(RoundedRectangle(cornerRadius: 60, style: .continuous))
            //This will create an overlay on the button that display a person system icon
            .overlay(
                HStack {
                    Image(systemName: "person.crop.circle")
                        .font(.system(size: 24, weight: .light))
                        //This will make the person icon disappear upon being pressed
                        .foregroundColor(Color.white.opacity(press ? 0 : 1))
                        //This will make the person icon disappear upon being pressed
                        .frame(width: press ? 64 : 54, height: press ? 4 :50)
                        .background(Color(#colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)))
                        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                        .shadow(color: Color(#colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)).opacity(0.3), radius: 10, x: 10, y: 10)
                        //Creating the press animation where the offset will be -10 otherwise 70
                        .offset(x: press ? 70 : -10, y: press ? 16 : 0)
                    Spacer()
                }
        )
            //Creating two drop shadows one from top left, and one from the Bottom Right
            //This will also change the color when the button is pressed from white to light grey
            //and from light grey to white
            .shadow(color: Color(press ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) : #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)), radius: 20, x: 20, y: 20)
            .shadow(color: Color(press ? #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1) : #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)), radius: 20, x: -20, y: -20)
            //Use a scale effect to expand and normalize the size of the button as it is tapped
            .scaleEffect(tap ? 1.2 : 1)
            //Adding the LongPressGesture with Duration, distance..
            //When we tap on the button it will expand and then come back to its normal size
            .gesture(
                LongPressGesture(minimumDuration: 0.5, maximumDistance: 2).onChanged { value in
                    self.tap = true
                    //Adding a touch delay after the button is tapped
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        //It will once again expand and comes back to normal size
                        self.tap = false
                    }
                }
                    //This will handle the long press toggle gesture state
                    .onEnded { value in
                        self.press.toggle()
                }
        )
    }
}

struct CircleButton: View {
    //Create the states neede to Transition between
    @State var tap = false
    @State var press = false
    
    var body: some View {
        VStack {
            Image(systemName: "sun.max")
                .font(.system(size: 44, weight: .light))
        }
        .frame(width: 100, height: 100)
        .background(
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)), Color(#colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1))]), startPoint: .topLeading, endPoint: .bottomTrailing)
                //Gives a light grey stroke around the bottom right of the round button
                Circle()
                    .stroke(Color.clear, lineWidth: 10)
                    .shadow(color: Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)), radius: 3, x: -5, y: -5)
                //Gives a white stroke around the top Left corner of the round button
                Circle()
                    .stroke(Color.clear, lineWidth: 10)
                    .shadow(color: Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)), radius: 3, x: 3, y: 3)
            }
            
        )
            .clipShape(Circle())
            .shadow(color: Color.white, radius: 20, x: -20, y: -20)
            .shadow(color: Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)), radius: 20, x: 20, y: 20)
            //Use a scale effect to expand and normalize the size of the button as it is tapped
            .scaleEffect(tap ? 1.2 : 1)
            .gesture(
                LongPressGesture().onChanged { value in
                    self.tap = true
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        self.tap = false
                    }
                }
                .onEnded { value in
                    self.press.toggle()
                }
            )
    }
}
