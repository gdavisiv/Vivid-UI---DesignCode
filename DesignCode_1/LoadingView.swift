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
        //It is essential that the LottieView is inside a 'Container' so that
        //when we run the loading view ontop of the loginview
        VStack {
            //Call the filename of the animation
            LottieView(filename: "loading")
                //Setting the size/shape/height
                .frame(width: 200, height: 200)
        }
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
