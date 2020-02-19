//
//  Home.swift
//  DesignCode_1
//
//  Created by Gdavisiv on 2/18/20.
//  Copyright © 2020 George Davis IV. All rights reserved.
//

import SwiftUI

struct Home: View {
    var body: some View {
        HStack {
            Text("Watching")
                .font(.system(size: 28, weight: .bold))
            
            Spacer()
            
            Button(action: {}) {
                Image("Avatar")
                    .renderingMode(.original)
                    .resizable()
                    .frame(width: 36, height: 36)
                    .clipShape(Circle())
            }
        }.padding(.horizontal)
        Spacer()
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
