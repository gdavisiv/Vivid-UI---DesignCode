//
//  UpdateDetail.swift
//  DesignCode_1
//
//  Created by user163072 on 3/16/20.
//  Copyright © 2020 user163072. All rights reserved.
//

import SwiftUI

struct UpdateDetail: View {
    //We are going to set UpdateData to 0 since it is an array
    //This is simply used for testing the UI and the transitions between the cardss
    var update: Update = updateData[0]
    
    var body: some View {
        List {
            VStack {
                Image(update.image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: .infinity)
                //Add in this formatting because the card is not right adjusted correctly
                //the mzxWidth and Alignment will fix it
                Text(update.text)
                    .frame(maxWidth: .infinity, alignment: .leading)
        }
        //Set the navigation view title, and is far more adaptive,
        //this is dependent on the navigation view wrapper
        .navigationBarTitle(update.title)
        }
        .listStyle(PlainListStyle())
    }
}

struct UpdateDetail_Previews: PreviewProvider {
    static var previews: some View {
        UpdateDetail()
    }
}
