//
//  CourseList.swift
//  DesignCode_1
//
//  Created by user163072 on 3/24/20.
//  Copyright © 2020 user163072. All rights reserved.
//

import SwiftUI

struct CourseList: View {
    var body: some View {
        VStack {
            CourseView()
        }
    }
}

struct CourseList_Previews: PreviewProvider {
    static var previews: some View {
        CourseList()
    }
}

struct CourseView: View {
    //Need to use a State to create animation
    @State var show = false
    
    var body: some View {
        VStack {
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 8.0) {
                    Text("iOS Swift UI Advanced")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(.white)
                    Text("20 Sections")
                        .foregroundColor(Color.white.opacity(0.7))
                    }
                    Spacer()
                    //ImageLiteral to easily select an image in your assets folder!
                    Image(uiImage: #imageLiteral(resourceName: "Logo1"))
                }
                Spacer()
                Image(uiImage: #imageLiteral(resourceName: "Card2"))
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: .infinity)
                    .frame(height: 140, alignment: .top)
            }
            //Add animation to the padding modifier so that it updates from CArd to Fullscreen Mode
            .padding(show ? 30 : 20)
            //This adds extra padding at the very top so that it does not intefer with the top Status Menu
            .padding(.top, show ? 30 : 0)
            //This following code will add the transition animation
            //Adding a Tap Gesture : Just need to update the frame, show screen.width otherwise show width - 60; ""
            //.frame(width: show ? screen.width : screen.width - 60, height: show ? screen.height : 280)
            //There is a better way to write the same code as shown above!  This will ensure that the card
            //maximizes and takes up the entire screen
            .frame(maxWidth: show ? .infinity : screen.width - 60, maxHeight: show ? .infinity : 280)
            .background(Color(#colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)))
            .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
            .shadow(color: Color(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)).opacity(0.3), radius: 20, x: 0, y: 20)
            .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
            .onTapGesture {
                self.show.toggle()
        }
        //This works in tandem with the .frame code from above to make the card expand to fullscreen MODE
        .edgesIgnoringSafeArea(.all)
    }
}
