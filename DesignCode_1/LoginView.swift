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
        GeometryReader { geometry in
            Text("Learn, Design & Code.\nFrom scratch!")
                .font(.system(size: 30, weight: .bold))
        }
        .frame(maxWidth: .infinity)

    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
