//
//  UpdateDetail.swift
//  DesignCode_1
//
//  Created by GdavisIV on 3/16/20.
//  Copyright © 2020 George Davis IV. All rights reserved.
//

import SwiftUI

struct UpdateDetail: View {
    //we are going to set updateData to 1 since it's an array
    var update: Update = updateData[1]
    
    var body: some View {
        //Changed from a scrollview to a list, since this is a list of items
        List {
            VStack(spacing: 20) {
                Image(update.image)
                    //add formatting since each info tab does not have consistent formatting
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: .infinity)
                Text(update.text)
                    //This helps to fix the inconsistent Formatting
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
