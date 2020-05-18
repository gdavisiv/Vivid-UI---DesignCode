//
//  LoginView.swift
//  DesignCode_1
//
//  Created by George Davis IV on 5/2/20.
//  Copyright © 2020 user163072. All rights reserved.
//

import SwiftUI
import Firebase

struct LoginView: View {
    //Create empty States
    @State var email = ""
    @State var password = ""
    //Creating State for Keyboard Interaction
    @State var isFocused = false
    //Creating State for Showing Alert
    @State var showAlert = false
    @State var alertMessage = "Something went wrong?!"
    @State var isLoading = false
    @State var isSuccess = false
    
    //Seperate the login logic from the rest of the code
    func login() {
        //Hides the keyboard
        self.hideKeyboard()
        //Focus on the login area
        self.isFocused = false
        //Show the loading animation
        self.isLoading = true
        
        //This the code implementation from Firebase Library for user Authentication
        //It returns the data or error
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            self.isLoading = false
            
            //If there is an error then..
            if error != nil {
                //use Error data from API call
                self.alertMessage = error?.localizedDescription ?? ""
                self.showAlert = true
            //When there is no error and the login is succssful
            } else {
                self.isSuccess = true
                
                //Dissmiss the Login success screeen after a 2 seconds
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    //This dismisses the login animation
                    self.isSuccess = false
                    //reset the fields
                    self.email = ""
                    self.password = ""
            }
        }
    }
}
    
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
    var body: some View {
        //Adding this extra ZStack will helps us to keep the black background that we have in our
        //background
        //This will only work to align the elements inside the Zstack; !against each other!
        ZStack {
            //Add black background to the top dropdown bar, and ignore safe areas
            Color.black.edgesIgnoringSafeArea(.all)
            
                ZStack(alignment: .top) {
                    //Adds the grey Colored background
                    Color("background2")
                        //Clips the shape of the corners and rounds the top/bottom corners
                        .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
                        .edgesIgnoringSafeArea(.bottom)
                    
                    CoverView()
                    
                    VStack {
                        HStack {
                            Image(systemName: "person.crop.circle.fill")
                                .foregroundColor(Color(#colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)))
                                .frame(width:44, height: 44)
                                .background(Color.white)
                                .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                                .shadow(color: Color.black.opacity(0.15), radius: 5, x: 0, y: 5)
                                .padding(.leading)
                            
                            TextField("You Email".uppercased(), text: $email)
                            //Customize the keyboard type
                                .keyboardType(.emailAddress)
                                .font(.subheadline)
                                //This will hopefully be fixed in an update for xcode
                                //.textFieldStyle(RoundedBorderTextFieldStyle())
                                .padding(.leading)
                                .frame(height: 44)
                                .onTapGesture {
                                    self.isFocused = true
                            }
                        }
                        
                        Divider()
                            .padding(.horizontal, 20)
                        
                        HStack {
                            Image(systemName: "lock.fill")
                                .foregroundColor(Color(#colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)))
                                .frame(width:44, height: 44)
                                .background(Color.white)
                                .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                                .shadow(color: Color.black.opacity(0.15), radius: 5, x: 0, y: 5)
                                .padding(.leading)
                            
                            SecureField("Password".uppercased(), text: $password)
                            //Customize the keyboard type
                                .keyboardType(.default)
                                .font(.subheadline)
                                //This will hopefully be fixed in an update for xcode
                                //.textFieldStyle(RoundedBorderTextFieldStyle())
                                .padding(.leading)
                                .frame(height: 44)
                                .onTapGesture{
                                    self.isFocused = true
                            }
                        }
                    }
                    .frame(height: 136)
                    .frame(maxWidth: .infinity)
                    .background(BlurView(style: .systemMaterial))
                    .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
                    .shadow(color: Color.black.opacity(0.15), radius: 20, x: 0, y: 20)
                    .padding(.horizontal)
                    .offset(y: 460)
                    
                    HStack {
                        Text("Forgot Password?")
                            .font(.subheadline)
                
                        Spacer()
                        
                        //Actions of the Button are Below
                        Button(action: {
                            self.login()
                        }) {
                            Text("Sign in")
                                .foregroundColor(.black)
                        }
                        .padding(12)
                        .padding(.horizontal, 30)
                        .background(Color(#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)))
                        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                        .shadow(color: Color(#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)).opacity(0.3), radius: 20, x: 0, y: 20)
                        //Show an alert message when the user clicks on the login button
                        .alert(isPresented: $showAlert) {
                            Alert(title: Text("Error"), message: Text(self.alertMessage), dismissButton: .default(Text("OK")))
                        }
                        
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
                    .padding()
            }
            //Shifts the screen up with
            .offset(y: isFocused ? -300 : 0)
            //Gets rid of odd lag by using @State
            .animation(isFocused ? .easeInOut : nil)
            .onTapGesture {
                self.isFocused = false
                self.hideKeyboard()
            }
            if isLoading {
                LoadingView()
            }
            if isSuccess {
                SuccessView()
            }
            
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
        //Use to preivew on different devices
        //.previewDevice("iPad Air 2")
    }
}

struct CoverView: View {
    //Set the Animation State to False
    @State var show = false
    //Use for 3D Parallax
    @State var viewState = CGSize.zero
    @State var isDragging = false
    
    
    var body: some View {
        VStack {
            GeometryReader { geometry in
                Text("Learn, Design & Code.\nFrom scratch!")
                    .font(.system(size: geometry.size.width/10.3, weight: .bold))
                    //Makes text white
                    .foregroundColor(.white)
            }
            .frame(maxWidth: 375, maxHeight: 100)
            .padding(.horizontal, 16)
                //Can also implement the parallax here divide it to slow down movement
                .offset(x: viewState.width/18, y: viewState.height/18)
            
            Text("80 Hours of courses for SwiftUI, React and design tools.")
                .font(.subheadline)
                .foregroundColor(.white)
                .frame(width: 250)
                //Can also implement the parallax here divide it to slow down movement
                .offset(x: viewState.width/23, y: viewState.height/23)
            
            Spacer()
        }
            //Multiline will apply to all children in the VSTack and CENTER the text!
            .multilineTextAlignment(.center)
            //Padding will push down the text from the top in the VStack
            .padding(.top, 100)
            .frame(height: 477)
            .frame(maxWidth: .infinity)
            //Adding Circle Blobs to image
            .background(
                ZStack {
                    Image(uiImage: #imageLiteral(resourceName: "Blob"))
                        //Moves the image to the specific x/y coordinates
                        .offset(x: -150, y: 200)
                        //Now I added an offset so that it starts at 90Degrees, to fix a jump in the animation
                        //simple add '+ 90'
                        .rotationEffect(Angle(degrees: show ? 360+90 : 90), anchor: .leading)
                        //Makes image darker
                        .blendMode(.plusDarker)
                        //This Animation will cause the movement to loop forever within 30 seconds
                        //and turns off autoreverse
                        .animation(Animation.linear(duration: 120).repeatForever(autoreverses: false))
                        .onAppear { self.show = true}
                    
                    Image(uiImage: #imageLiteral(resourceName: "Blob"))
                        //Moves the image to the specific x/y coordinates
                        .offset(x: 200, y: -175)
                        .rotationEffect(Angle(degrees: show ? 180 : 0), anchor: .trailing)
                        //Makes image blendmode as difference
                        .blendMode(.difference)
                        .animation(Animation.linear(duration: 100).repeatForever(autoreverses: true))
                }
        )
            //This adds the Image background
            //Implement the 3D Parallax Effect to the background as well!
            .background(
                Image(uiImage: #imageLiteral(resourceName: "Card3")).offset(x: viewState.width/26, y: viewState.height/26),
                alignment: .bottom
            )
            //Background Color the forefront image
            .background(Color(#colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)))
            //Rounds the Edges
            .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
            //Implement Scale Effect with .isDragging
            .scaleEffect(isDragging ? 0.95 : 1)
            //Smooths the transition from the scaling!!
            .animation(.timingCurve(0.2, 0.8, 0.2, 1, duration: 0.8))
            //Implement 3D Rotation Effects to wiggle on x/y axis with .viewState
            .rotation3DEffect(Angle(degrees: 5), axis: (x: viewState.width, y: viewState.height, z: 0))
            //Add a Gesture to our ZStack
            .gesture(
                DragGesture().onChanged { value in
                    self.viewState = value.translation
                    //Add a Scale effect
                    self.isDragging = true
                }
                    //When the use takes their finger off the screen
                    .onEnded { value in
                        //Reset the position
                        self.viewState = .zero
                        self.isDragging = false
                }
        )
    }
}
