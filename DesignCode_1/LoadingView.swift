//
//  LoadingView.swift
//  DesignCode_1
//
//  Created by George Davis IV on 5/9/20.
//  Copyright © 2020 user163072. All rights reserved.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        LottieView()
            .frame(width: 200, height: 200)
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
