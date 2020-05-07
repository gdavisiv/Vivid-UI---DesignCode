//
//  LoginView.swift
//  DesignCode_1
//
//  Created by George Davis IV on 5/2/20.
//  Copyright © 2020 user163072. All rights reserved.
//

import SwiftUI

struct LoginView: View {
    //Set the Animation State to False
    @State var show = false
    //Use for 3D Parallax
    
    var body: some View {
        //This will only work to align the elements inside the Zstack; !against each other!
        ZStack(alignment: .top) {
            //Add black background to the top dropdown bar, and ignore safe areas
            Color.black.edgesIgnoringSafeArea(.all)
            
            //Adds the grey Colored background
            Color("background2")
                //Clips the shape of the corners and rounds the top/bottom corners
                .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
                .edgesIgnoringSafeArea(.bottom)
            VStack {
                GeometryReader { geometry in
                    Text("Learn, Design & Code.\nFrom scratch!")
                        .font(.system(size: geometry.size.width/10.3, weight: .bold))
                        //Makes text white
                        .foregroundColor(.white)
                }
                .frame(maxWidth: 375, maxHeight: 100)
                .padding(.horizontal, 16)
                
                Text("80 Hours of courses for SwiftUI, React and design tools.")
                    .font(.subheadline)
                    .frame(width: 250)
                    
                Spacer()
            }
            //Multiline will apply to all children in the VSTack and CENTER the text!
            .multilineTextAlignment(.center)
            //Padding will push down the text from the top in the VStack
            .padding(.top, 100)
            .frame(height: 477)
            .frame(maxWidth: .infinity)
            //Adding Circle Blobs to image
            .background(
                ZStack {
                    Image(uiImage: #imageLiteral(resourceName: "Blob"))
                        //Moves the image to the specific x/y coordinates
                        .offset(x: -150, y: 200)
                        //Now I added an offset so that it starts at 90Degrees, to fix a jump in the animation
                        //simple add '+ 90'
                        .rotationEffect(Angle(degrees: show ? 360+90 : 90), anchor: .leading)
                        //Makes image darker
                        .blendMode(.plusDarker)
                        //This Animation will cause the movement to loop forever within 30 seconds
                        //and turns off autoreverse
                        .animation(Animation.linear(duration: 120).repeatForever(autoreverses: false))
                        .onAppear { self.show = true}
                    
                    Image(uiImage: #imageLiteral(resourceName: "Blob"))
                        //Moves the image to the specific x/y coordinates
                        .offset(x: 200, y: -175)
                        .rotationEffect(Angle(degrees: show ? 360 : 0), anchor: .trailing)
                        //Makes image blendmode as difference
                        .blendMode(.difference)
                        .animation(Animation.linear(duration: 100).repeatForever(autoreverses: true))
                }
            )
            //This adds the Image background
            .background(Image(uiImage: #imageLiteral(resourceName: "Card3")), alignment: .bottom)
            //Background Color the forefront image
            .background(Color(#colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)))
            //Rounds the Edges
            .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
        //Use to preivew on different devices
        //.previewDevice("iPad Air 2")
    }
}
