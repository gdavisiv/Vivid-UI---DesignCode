//
//  RingView.swift
//  DesignCode_1
//
//  Created by user163072 on 3/19/20.
//  Copyright © 2020 user163072. All rights reserved.
//

import SwiftUI

struct RingView: View {
    var body: some View {
        ZStack {
            //Positioning is very important to get this to work properly so pay close attention!!
            //This creates the grey inactive ring in the background
            Circle()
                .stroke(Color.black.opacity(0.1), style:
                    StrokeStyle(lineWidth: 5))
                .frame(width: 44, height: 44)
            //This creates the main color circle
            Circle()
                //The trim is a bit counter-intuitive, the 0.2 = 80%, and starts around x=10, y =0
                .trim(from: 0.2, to: 1)
                .stroke(
                    LinearGradient(gradient: Gradient(colors:[Color(#colorLiteral(red: 0.1764705926, green: 0.01176470611, blue: 0.5607843399, alpha: 1)),
                            Color(#colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1))]), startPoint: .topTrailing,
                            endPoint: .bottomLeading),
                        style: StrokeStyle(lineWidth: 5, lineCap: .round, lineJoin: .round, miterLimit: .infinity, dash: [20, 0],
                            dashPhase: 0)
            )
            //Adding customization for starting point, and rotation/scale
            //adding the rotation will move the start point to the bottom
            .rotationEffect(Angle(degrees: 90))
            .rotation3DEffect(Angle(degrees: 180), axis: (x: 1, y: 0, z: 0))
            .frame(width: 44, height: 44)
            .shadow(color: Color(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)).opacity(0.1), radius: 3, x: 0, y: 3)
            
            //Adds text in the middle of the status circle
            //positioning is important
            Text("82%")
                .font(.subheadline)
                .fontWeight(.bold)
        }
    }
}

struct RingView_Previews: PreviewProvider {
    static var previews: some View {
        RingView()
    }
}
