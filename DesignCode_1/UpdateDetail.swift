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
    var update: Update = updateData[0]
    
    var body: some View {
        //Add scrolling to the Info Card Section and snaps the title back to the navbar
        ScrollView {
            VStack {
                Image(update.image)
                    //Add formatting since each info tab does not have consistent formatting
                    .frame(width: .infinity)
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: .infinity)
                Text(update.text)
                    //this helps to fix the incosistent formatting
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
