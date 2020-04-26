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
                .shadow(color: Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)), radius: 20, x: 20, y: 20)
                .shadow(color: Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)), radius: 20, x: -20, y: -20)
        }
    .frame()
    }
}

struct Buttons_Previews: PreviewProvider {
    static var previews: some View {
        Buttons()
    }
}
