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
        VStack {
            Image(update.image)
            Text(update.text)
            
        }
        //Set the navigation view title, and is far more adaptive,
        //this is dependent on the navigation view wrapper
        .navigationBarTitle(update.title)
    }
}

struct UpdateDetail_Previews: PreviewProvider {
    static var previews: some View {
        UpdateDetail()
    }
}
