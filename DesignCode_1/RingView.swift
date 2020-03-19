//
//  RingView.swift
//  DesignCode_1
//
//  Created by user163072 on 3/19/20.
//  Copyright © 2020 user163072. All rights reserved.
//

import SwiftUI

struct RingView: View {
    
    //setting variables so that we can customize our component
    var color1 = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    var color2 = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    //.frame uses CGFloat and not default Int
    var width: CGFloat = 44
    var height: CGFloat = 44
    var percent = 88
    
    var body: some View {
        ZStack {
            //Positioning is very important to get this to work properly so pay close attention!!
            //This creates the grey inactive ring in the background
            Circle()
                .stroke(Color.black.opacity(0.1), style:
                    StrokeStyle(lineWidth: 5))
                .frame(width: width, height: height)
            //This creates the main color circle
            Circle()
                //The trim is a bit counter-intuitive, the 0.2 = 80%, and starts around x=10, y =0
                .trim(from: 0.2, to: 1)
                .stroke(
                    LinearGradient(gradient: Gradient(colors:[Color(color1),
                            Color(color2)]), startPoint: .topTrailing,
                            endPoint: .bottomLeading),
                        style: StrokeStyle(lineWidth: 5, lineCap: .round, lineJoin: .round, miterLimit: .infinity, dash: [20, 0],
                            dashPhase: 0)
            )
            //Adding customization for starting point, and rotation/scale
            //adding the rotation will move the start point to the bottom
            .rotationEffect(Angle(degrees: 90))
            .rotation3DEffect(Angle(degrees: 180), axis: (x: 1, y: 0, z: 0))
            .frame(width: width, height: height)
                .shadow(color: Color(color2).opacity(0.1), radius: 3, x: 0, y: 3)
            
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
