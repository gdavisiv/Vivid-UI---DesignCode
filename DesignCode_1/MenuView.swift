//
//  MenuView.swift
//  DesignCode_1
//
//  Created by GdavisIV on 2/14/20.
//  Copyright © 2020 George Davis IV. All rights reserved.
//

import SwiftUI

struct MenuView: View {
    //Add Enviornment Object
    @EnvironmentObject var user: UserStore
    //Need to create a biding so that Preview is shown
    @Binding var showProfile: Bool
    
    var body: some View {
        VStack {
            Spacer()
            
            VStack(spacing: 16) {
                Text("George - 28% Complete")
                    .font(.caption)
                
                Color.white
                    .frame(width: 38, height: 6)
                    .cornerRadius(3)
                    .frame(width: 130, height: 6, alignment: .leading)
                    .background(Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)).opacity(0.08))
                    .cornerRadius(3)
                    .padding()
                    .frame(width: 150, height: 24)
                    .background(Color.black.opacity(0.1))
                    .cornerRadius(12)
                
                
                //Clean way to make customizable components and pass in custom variables
                MenuRow(title: "Account", icon: "gear")
                MenuRow(title: "Billing", icon: "creditcard")
                MenuRow(title: "Sign Out", icon: "person.crop.circle")
                    //Allows the use to be logged out of Firebase
                    .onTapGesture {
                        //Sets islogged to False
                        UserDefaults.standard.set(false, forKey: "isLogged")
                        //set enviornment object user to false
                        self.user.isLogged = false
                        //
                        self.showProfile = false
                }
            }
            .frame(maxWidth: 500)
            .frame(height: 300)
            //Create an Linear Gradient and use 'Color Literal' to bring up the hidden menu for choosing
            //a specific color desired.
            .background(BlurView(style: .systemMaterial))
            //Updated color literal for background : Dark Mode iOS
            //.background(LinearGradient(gradient: Gradient(colors: [Color("background3"), Color("background3").opacity(0.6)]), startPoint: .top, endPoint: .bottom))
            .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
            //Create a custom Shadow
            .shadow(color: Color.black.opacity(0.2), radius: 20, x: 0, y: 20)
            .padding(.horizontal, 30)
            .overlay(
                Image("Avatar")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 60, height: 60)
                    .clipShape(Circle())
                    .offset(y: -150)
            )
        }
        .padding(.bottom, 30)
    }
}


struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        //Added Enviornment object so the preview will not go blank
        MenuView(showProfile: .constant(true)).environmentObject(UserStore())
    }
}

//This simple organizes everything so well, and allows reusability!!!
//The simplicity of this is awesome!
struct MenuRow: View {
    //Create variables  for the components so I can pass in data
    //to them and customize each easily
    var title: String
    var icon: String
    
    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: icon)
                .font(.system(size: 20, weight: .light))
                .imageScale(.large)
                .frame(width: 32, height: 32)
                .foregroundColor(Color(#colorLiteral(red: 0.5577465027, green: 0.6000000238, blue: 0.7197183337, alpha: 1)))
            
            Text(title)
                .font(.system(size: 20, weight: .bold, design: .rounded))
                .frame(width: 120, alignment: .leading)
        }
    }
}
