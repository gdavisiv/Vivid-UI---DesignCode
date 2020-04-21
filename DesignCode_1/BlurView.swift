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
    
    func makeUIView(context: UIViewRepresentableContext<BlurView>) -> UIView {
        //Using normal swift now
        let view = UIView(frame: CGRect.zero)
        view.backgroundColor = .clear
        
        return view
        
    }
    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<BlurView>) {
        <#code#>
    }
}
