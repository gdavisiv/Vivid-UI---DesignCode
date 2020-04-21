//
//  BlurView.swift
//  DesignCode_1
//
//  Created by George Davis IV on 4/20/20.
//  Copyright © 2020 user163072. All rights reserved.
//

import SwiftUI

//SwiftUI still does not have a way to allow a backgorund Blur
//Going to create a going to allow us to use UIKit or normal swift in order to
//use the feature of background blur
struct BlurView: UIViewRepresentable {
    //Setup up the UIView and put the Blur View ontop of that using
    //inset subview
    typealias UIViewType = UIView
    //We create style to allow customization in the ContentView.swift
    var style: UIBlurEffect.Style
    
    func makeUIView(context: UIViewRepresentableContext<BlurView>) -> UIView {
        //Using normal swift now
        let view = UIView(frame: CGRect.zero)
        //Make sure the background does not have any color
        view.backgroundColor = .clear
        //to use the blur view we have to declare it first
        //systemMaterial will auto update for light/dark mode
        let blurEffect = UIBlurEffect(style: style)
        //Now we set the blur effect
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.translatesAutoresizingMaskIntoConstraints = false
        //Insert the blurview into the main view 'at' is the similar to the Z-Index
        view.insertSubview(blurView, at: 0)
        
        //Setup the constraints
        NSLayoutConstraint.activate([
            //Set an Array with constraints for width
            //This ensure the blur view will have the same width as the parent view
            blurView.widthAnchor.constraint(equalTo: view.widthAnchor),
            //Setup the height constraint as well
            blurView.heightAnchor.constraint(equalTo: view.heightAnchor)
        ])
        
        //This function needs to return a UIView
        return view
        
    }
    //This is useful for animation when your view gets changed
    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<BlurView>) {
        
    }
}
