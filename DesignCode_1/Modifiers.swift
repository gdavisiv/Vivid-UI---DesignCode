//
//  Modifiers.swift
//  DesignCode_1
//
//  Created by GdavisIV on 3/20/20.
//  Copyright © 2020 George Davis IV. All rights reserved.
//
//This shows how to import custom fonts for an app!
import SwiftUI

//Creating the Components of modifiers similar to have a style guide in CSS
struct ShadowModifier: ViewModifier {
    //Return some view, and use content, and apply the modifiers to content
    func body(content: Content) -> some View {
        content
            .shadow(color: Color.black.opacity(0.2), radius: 20, x: 0, y: 20)
            .shadow(color: Color.black.opacity(0.1), radius: 1, x: 0, y: 1)
        
    }
}

struct FontModifier: ViewModifier {
    //Font modifier has a .body set by default we that can not be changed.
    //so we can make the .body customizable by making .style variable
    var style: Font.TextStyle = .body
    
    func body(content: Content) -> some View {
        content
            .font(.system(.body, design: .default))
    }
}

struct CustomFontModifier: ViewModifier {
    //Create a variable to make size customizable
    var size: CGFloat
    
    func body(content: Content) -> some View {
        
        content.font(.custom("Overpass-ExtraBold", size: size))
    }
}
