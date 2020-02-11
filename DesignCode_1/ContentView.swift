//
//  ContentView.swift
//  DesignCode_1
//
//  Created by user163072 on 2/9/20.
//  Copyright © 2020 user163072. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack{
            //Calls the struct below and displays the top title and image
            TitleView()
            
            
            //Make sure that the order of operations is followed for applying
            //these different effects upon the struct
            //This is the back card
            BackCardView()
                .background(Color("card4"))
                .cornerRadius(20)
                .shadow(radius: 20)
                .offset(x:0, y:-40)
                .scaleEffect(0.9)
                .rotationEffect(Angle(degrees: 10))
                .rotation3DEffect(Angle(degrees: 10), axis: (x: 10, y: 0, z: 0))
                .blendMode(.hardLight)
            
            //Same applies here follow the order of operations for effects
            //This is the middle card or check Assets to find out
            BackCardView()
                .background(Color("card3"))
                .cornerRadius(20)
                .shadow(radius: 20)
                .offset(x:0, y:-20)
                .scaleEffect(0.95)
                .rotationEffect(Angle(degrees: 5))
                .rotation3DEffect(Angle(degrees: 5), axis: (x: 10, y: 0, z: 0))
                .blendMode(.hardLight)
            
            //This is the front facing card
            CardView()
            .blendMode(.hardLight)
            
            VStack{
                Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.")
                    .multilineTextAlignment(.center)
                    //Use the dynamic types that are defaults for xcode
                    .font(.subheadline)
                    .lineSpacing(4)
                Spacer()
            }
            //!!!!!!Always padding before background!!!!!!!
            .padding()
            .background(Color.white)
            .cornerRadius(30)
            .shadow(radius: 20)
            .offset(x: 0, y: 500)
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
