//
//  LottieView.swift
//  DesignCode_1
//
//  Created by George Davis IV on 5/9/20.
//  Copyright © 2020 user163072. All rights reserved.
//

import SwiftUI
//Import Library
import Lottie

//Going to create a UIView Representable, so we can use Normal Swift Code to implement this
struct LottieView: UIViewRepresentable {
    
    typealias UIViewType = UIView
    var filename: String
    
    //Using normal swift to render the lottie file
    //Make sure to specify the context
    func makeUIView(context: UIViewRepresentableContext<LottieView>) -> UIView {
        //Creating a Rectangle with a Frame : width/height of Zero
        let view = UIView(frame: .zero)
        
        //Create an animation view from the library
        let animationView = AnimationView()
        //Can play any lottie animation
        let animation = Animation.named(filename)
        animationView.animation = animation
        animationView.contentMode = .scaleAspectFit
        animationView.play()
        
        animationView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(animationView)
        
        NSLayoutConstraint.activate([
            animationView.widthAnchor.constraint(equalTo: view.widthAnchor),
            animationView.heightAnchor.constraint(equalTo: view.heightAnchor)
        ])
        
        return view
    }
    //Specify the Context
    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<LottieView>) {
        
    }
}
