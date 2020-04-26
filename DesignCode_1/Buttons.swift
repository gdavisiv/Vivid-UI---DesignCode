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
        VStack {
            Text("Button")
                .font(.system(size: 20, weight: .semibold, design: .rounded))
                .frame(width: 200, height: 60)
                .background(
                    ZStack {
                        Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1))
                    
                        RoundedRectangle(cornerRadius: 16, style:
                            .continuous)
                            .foregroundColor(.white)
                            .blur(radius: 4)
                            .offset(x: -8, y: -8)
                        
                        RoundedRectangle(cornerRadius: 16, style:
                        .continuous)
                        .fill(
                            LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)), Color.white]), startPoint: .topLeading, endPoint: .bottomTrailing)
                        )
                        //Adds a slight inner shadow while also
                        .padding(2)
                        .blur(radius: 2)

                        }
                )
                .clipShape(RoundedRectangle(cornerRadius: 60, style: .continuous))
                .shadow(color: Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)), radius: 20, x: 20, y: 20)
                .shadow(color: Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)), radius: 20, x: -20, y: -20)
        }
        .frame(maxWidth: .init(), maxHeight: .infinity)
        .background(Color(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)))
        .edgesIgnoringSafeArea(.all)
    }
}

struct Buttons_Previews: PreviewProvider {
    static var previews: some View {
        Buttons()
    }
}
