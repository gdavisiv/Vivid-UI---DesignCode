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
        //Multiline will apply to all children in the VSTack
        .multilineTextAlignment(.center)
        .padding(.top, 100)
        .frame(height: 477)
        .frame(maxWidth: .infinity)
        .background(Image(uiImage: #imageLiteral(resourceName: "Card3")), alignment: .bottom)
        .background(Color(#colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)))
        .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
        //Use to preivew on different devices
        //.previewDevice("iPad Air 2")
    }
}
