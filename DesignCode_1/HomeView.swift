//
//  HomeView.swift
//  DesignCode_1
//
//  Created by user163072 on 3/10/20.
//  Copyright © 2020 user163072. All rights reserved.
//

import SwiftUI

struct HomeView: View {
    @Binding var showProfile: Bool
    var body: some View {
        VStack {
            HStack {
                Text("Watching")
                    .font(.system(size: 28, weight: .bold))
                
                Spacer()
                
                //Pass that state as a binding and add the $ :
                //Bindings are considered to be a property of the object which is bound,
                //and all information related to bindings should be owned by the object.
                AvatarView(showProfile: $showProfile)
                
            }
            .padding(.horizontal)
            .padding(.top, 30)
            
            Spacer()
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        //Have to update this because we created a new file HomeView, this is different from
        //extracting a subview : the HomeView needs some setting.  WE CAN'T pass a state, because
        //we don't have a state to use.  So instead we set .constant(false)
        HomeView(showProfile: .constant(false))
    }
}
