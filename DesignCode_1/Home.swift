//
//  Home.swift
//  DesignCode_1
//
//  Created by Gdavisiv on 2/18/20.
//  Copyright © 2020 George Davis IV. All rights reserved.
//
//  This technique is only recommended for light views like a
//  menu or a simple modal. It's not recommended for heavy
//  screens since that may affect performance.
//

import SwiftUI

struct Home: View {
    
    @State var showProfile = false
    
    //Created a state to store the DRAG gesture translation value
    @State var viewState = CGSize.zero
    
    var body: some View {
        ZStack{
            Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1))
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                HStack {
                    Text("Watching")
                        .font(.system(size: 28, weight: .bold))
                    
                    Spacer()
                    
                    Button(action: { self.showProfile.toggle() }) {
                        Image("Avatar")
                            .renderingMode(.original)
                            .resizable()
                            .frame(width: 36, height: 36)
                            .clipShape(Circle())
                    }
                }
                .padding(.horizontal)
                .padding(.top, 30)
                
                Spacer()
            }
            .padding(.top, 35)
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
            .shadow(color: Color.black.opacity(0.2), radius: 20, x: 0, y: 20)
            .offset(y: showProfile ? -450 : 0)
            //Added Double(viewState.height / 10) - 10 : 0) so that you are dividing 50/10=5 so a softer transition when dragging
            //the bottom menu up or down
            .rotation3DEffect(Angle(degrees: showProfile ? Double(viewState.height / 10) - 10 : 0), axis: (x: 10.0, y: 0, z: 0))
            .scaleEffect(showProfile ? 0.9 : 1)
            .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
            .edgesIgnoringSafeArea(.all)
            
            
            MenuView()
                //This allows you to not see the menu, but still make it interactive
                .background(Color.black.opacity(0.001))
                .offset(y: showProfile ? 0 : 1000)
                //Applies the offset to the menu so that it animates
                .offset(y: viewState.height)
                .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
                //Add this so you can press the profile and make it interactive
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
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
