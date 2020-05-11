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
    
    //Creating an Alias for an existing type
    typealias UIViewType = UIView
    var filename: String
    
    //Using normal swift to render the lottie file
    //Make sure to specify the context
    func makeUIView(context: UIViewRepresentableContext<LottieView>) -> UIView {
        //Creating a Rectangle with a Frame of zero in terms of : width/height and position
        let view = UIView(frame: .zero)
        
        //Create an animation view from the library
        let animationView = AnimationView()
        //Can play any lottie animation; Setting the animation filename
        //below with something generic that can be changed easily
        let animation = Animation.named(filename)
        //Specify the animation, for the animation view that we declared
        animationView.animation = animation
        //The option to scale the content to fit the size of the view
        //by maintaining the aspect ratio. Any remaining area of the view’s bounds is transparent.
        animationView.contentMode = .scaleAspectFit
        //Plays Animation
        animationView.play()
        
        //A Boolean value that determines whether the view’s autoresizing mask
        //is translated into Auto Layout constraints.
        animationView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(animationView)
        
        //The relationship between two user interface objects that must be
        //satisfied by the constraint-based layout system.
        //Activates each constraint in the specified array.
        NSLayoutConstraint.activate([
            animationView.widthAnchor.constraint(equalTo: view.widthAnchor),
            animationView.heightAnchor.constraint(equalTo: view.heightAnchor)
        ])
        
        return view
    }
    //Specify the Context : Updates the state of the specified view with new information from SwiftUI.
    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<LottieView>) {
        
    }
}
