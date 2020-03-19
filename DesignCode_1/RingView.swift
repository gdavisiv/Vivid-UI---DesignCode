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
    var color1 = #colorLiteral(red: 0.3176470697, green: 0.07450980693, blue: 0.02745098062, alpha: 1)
    var color2 = #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)
    //.frame uses CGFloat and not default Int
    var width: CGFloat = 88
    var height: CGFloat = 88
    var percent: CGFloat = 25
    
    var body: some View {
        //Add the variable inside the body because it will not intialize with the
        //correct inputs outside the body
        //Also add return ZStack once you add the let multiplier
        let multiplier = width / 44
        
        //Added a  "1 -" because it would start from the left instead of the right
        let progress = 1 - (percent / 100)
        
        return ZStack {
            //Positioning is very important to get this to work properly so pay close attention!!
            //This creates the grey inactive ring in the background
            Circle()
                .stroke(Color.black.opacity(0.1), style:
                    StrokeStyle(lineWidth: 5 * multiplier))
                .frame(width: width, height: height)
            //This creates the main color circle
            Circle()
                //The trim is a bit counter-intuitive, the 0.2 = 80%, and starts around x=10, y =0
                .trim(from: progress, to: 1)
                .stroke(
                    LinearGradient(gradient: Gradient(colors:[Color(color1),
                            Color(color2)]), startPoint: .topTrailing,
                            endPoint: .bottomLeading),
                        style: StrokeStyle(lineWidth: 5 * multiplier, lineCap: .round, lineJoin: .round, miterLimit: .infinity, dash: [20, 0],
                            dashPhase: 0)
            )
            //Adding customization for starting point, and rotation/scale
            //adding the rotation will move the start point to the bottom
            .rotationEffect(Angle(degrees: 90))
            .rotation3DEffect(Angle(degrees: 180), axis: (x: 1, y: 0, z: 0))
            .frame(width: width, height: height)
            .shadow(color: Color(color2).opacity(0.1), radius: 3 * multiplier, x: 0, y: 3 * multiplier)
            
            //Adds text in the middle of the status circle
            //positioning is important
            //CGFloat uses extra decimals so we convert it to an Int instead
            Text("\(Int(percent))%")
                .font(.system(size: 14 * multiplier))
                .fontWeight(.bold)
        }
    }
}

struct RingView_Previews: PreviewProvider {
    static var previews: some View {
        RingView()
    }
}
