//
//  CourseList.swift
//  DesignCode_1
//
//  Created by user163072 on 3/24/20.
//  Copyright © 2020 user163072. All rights reserved.
//

import SwiftUI

struct CourseList: View {
    var body: some View {
        VStack {
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 8.0) {
                    Text("iOS Swift UI Advanced")
                        .font(.system(size: 24, weight: .bold))
                    Text("20 Sections")
                }
                //ImageLiteral to easily select an image in your assets folder!
                Image(uiImage: #imageLiteral(resourceName: "Logo1"))
            }
            Image(uiImage: #imageLiteral(resourceName: "Card2"))
            .resizable()
        }
        .padding(20)
        .frame(width: screen.width - 60, height: 280)
        .background(Color(#colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)))
        .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
        .shadow(color: Color(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)).opacity(0.3), radius: 20, x: 0, y: 20)
    }
}

struct CourseList_Previews: PreviewProvider {
    static var previews: some View {
        CourseList()
    }
}
