//
//  LoginView.swift
//  DesignCode_1
//
//  Created by George Davis IV on 5/2/20.
//  Copyright © 2020 user163072. All rights reserved.
//

import SwiftUI

struct LoginView: View {
    var body: some View {
        VStack {
            GeometryReader { geometry in
                Text("Learn, Design & Code.\nFrom scratch!")
                    .font(.system(size: geometry.size.width/10.3, weight: .bold))
            }
            .frame(maxWidth: 375, maxHeight: 100)
            .padding(.horizontal, 16)
            .multilineTextAlignment(.center)
            
            Text("80 Hours of courses for SwiftUI, React and design tools.")
                .font(.subheadline)
                .frame(width: 250)
                .multilineTextAlignment(.center)
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
