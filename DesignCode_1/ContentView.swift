//
//  ContentView.swift
//  DesignCode_1
//
//  Created by user163072 on 2/9/20.
//  Copyright © 2020 user163072. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack{
            HStack{
                VStack(alignment: .leading) {
                    Text("UI Design")
                        .font(.title)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                    Text("Certificate")
                        .foregroundColor(Color("accent"))
                }
                    Spacer()
                    Image("Logo1")
            }
            .padding(.horizontal, 20)
            .padding(.top, 20)
            Spacer()
            Image("Card1")
                .resizable()
                .aspectRatio(contentMode: .fit)
        }
        .frame(width:340.0, height: 220.0)
        .background(Color.black)
        .cornerRadius(20)
        .shadow(radius: 20)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
