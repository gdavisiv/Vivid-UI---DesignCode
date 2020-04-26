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
        //
        VStack {
            Text("Button")
                .font(.system(size: 20, weight: .semibold, design: .rounded))
                .frame(width: 200, height: 60)
                .background(
                    ZStack {
                        Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1))
                    
                        //Creating a Second Color Layer with an inner shadow within the button
                        RoundedRectangle(cornerRadius: 16, style:
                            .continuous)
                            .foregroundColor(.white)
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
                //Creating two drop shadows one from top left, and one from the Bottom Right
                .shadow(color: Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)), radius: 20, x: 20, y: 20)
                .shadow(color: Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)), radius: 20, x: -20, y: -20)
        }
        //
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        //Setting the background color to color literal set below
        .background(Color(#colorLiteral(red: 0.8933308721, green: 0.935842216, blue: 1, alpha: 1)))
        //Going to ignore the edges and fill the entire screenw
        .edgesIgnoringSafeArea(.all)
    }
}

struct Buttons_Previews: PreviewProvider {
    static var previews: some View {
        Buttons()
    }
}
