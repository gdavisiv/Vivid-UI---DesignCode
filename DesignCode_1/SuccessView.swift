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
            Text("Logging You...")
                .font(.title).bold()
        
            LottieView(filename: "success")
                .frame(width: 300, height: 300)
        }
        .padding(.top, 30)
        .background(BlurView(style: .systemMaterial))
        .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
        .shadow(color: Color.black.opacity(0.2), radius: 30, x: 0, y: 30)
        //As soon as we see the Vstack, we are going to start the animation
        .onAppear()
    }
}

struct SuccessView_Previews: PreviewProvider {
    static var previews: some View {
        SuccessView()
    }
}
