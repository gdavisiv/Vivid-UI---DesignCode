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
<<<<<<< 105eef1ac19e60591fe0c5d0d00c632441a72000
        //Using List allows the card to be easily scrollable, and autolock at the top
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
=======
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
>>>>>>> Completed Updates to Navigation Style and finished passing data between UpdateDetail/UpdateList
    }
}

struct UpdateDetail_Previews: PreviewProvider {
    static var previews: some View {
        UpdateDetail()
    }
}
