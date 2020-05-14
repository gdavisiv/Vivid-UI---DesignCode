//
//  SuccessView.swift
//  DesignCode_1
//
//  Created by George Davis IV on 5/12/20.
//  Copyright © 2020 user163072. All rights reserved.
//

import SwiftUI

struct SuccessView: View {
    @State var show = false
    
    var body: some View {
        VStack {
            Text("Logging You In...")
                .font(.title).bold()
                .opacity(show ? 1 : 0)
                //Title appears first and then animation after below
                .animation(Animation.linear(duration: 1).delay(0.2))
        
            LottieView(filename: "success")
                .frame(width: 300, height: 300)
                .opacity(show ? 1 : 0)
                .animation(Animation.linear(duration: 1).delay(0.4))

        }
        .padding(.top, 30)
        .background(BlurView(style: .systemMaterial))
        .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
        .shadow(color: Color.black.opacity(0.2), radius: 30, x: 0, y: 30)
        .scaleEffect(show ? 1 : 0.5)
        .animation(.spring(response: 0.75, dampingFraction: 0.6, blendDuration: 0))
        //As soon as we see the Vstack, we are going to start the animation
        .onAppear {
                self.show = true
        }
        //Since we're already using a background we can either place everything in another VStack or use a fram
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black.opacity(show ? 0.5 : 0))
        .animation(.linear(duration: 0.5))
        .edgesIgnoringSafeArea(.all)
    }
}

struct SuccessView_Previews: PreviewProvider {
    static var previews: some View {
        SuccessView()
    }
}
