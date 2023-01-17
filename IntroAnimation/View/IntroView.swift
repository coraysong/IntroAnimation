//
//  IntroView.swift
//  IntroAnimation
//
//  Created by Coray SONG on 21/12/2022.
//

import SwiftUI

struct IntroView: View {
    //MARK: Animation Properties
    @State var showWalkThroughScreens: Bool = false
    @State var currentIndex: Int = 0
    var body: some View {
        ZStack {
            Color("BG")
                .ignoresSafeArea()
            IntroScreen()
            
            WalkThroughScreens()
            
            NavBar()
                
        }
        .animation(.interactiveSpring(response: 1.1, dampingFraction: 0.85, blendDuration: 0.85), value: showWalkThroughScreens)
    }
    //MARK: WalkThrough Screens
    @ViewBuilder
    func WalkThroughScreens() -> some View {
        let isLast = currentIndex == intros.count
        GeometryReader {
            let size = $0.size
            
            ZStack {
                //MARK: Walk through screens
                ForEach(intros.indices, id: \.self) { index in
                    ScreenView(size: size, index: index)
                }
                
                WelcomeView(size: size, index: intros.count)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            //MARK: Next Button
            .overlay(alignment: .bottom) {
                ZStack {
                    Image(systemName: "chevron.right")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .scaleEffect(!isLast ? 1 : 0.001)
                        .opacity(!isLast ? 1 : 0)
                    
                    HStack {
                        Text("Sign Up")
                            .font(.title3)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Image(systemName: "arrow.right")
                            .font(.title3)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                    }
                    .padding(.horizontal, 15)
                    .scaleEffect(isLast ? 1 : 0.001)
                    .frame(height: isLast ? nil : 0)
                    .opacity(isLast ? 1 : 0)
                }
                .frame(width: isLast ? size.width / 1.5 : 55, height: isLast ? 50 : 55)
                    .foregroundColor(.white)
                    .background {
                        RoundedRectangle(cornerRadius: isLast ? 10 : 30, style: isLast ? .continuous : .circular)
                            .fill(Color.black)
                    }
                    .onTapGesture {
                        currentIndex += 1
                    }
                    .offset(y: isLast ? -40 : -90)
            }
            .overlay(alignment: .bottom, content: {
                // MARK: Bottom Sign In Button
                let isLast = currentIndex == intros.count
                
                HStack(spacing: 5) {
                    Text("Already have an account?")
                        .font(.title3)
                        .foregroundColor(.gray)
                    
                    Button("Login") {
                        
                    }
                    .font(.title3)
                    .foregroundColor(.black)
                }
                .offset(y: isLast ? -12 : 100)
                .animation(.interactiveSpring(response: 0.9, dampingFraction: 0.8, blendDuration: 0.5), value: isLast)
                
            })
            .offset(y: showWalkThroughScreens ? 0 : size.height)
            .animation(.interactiveSpring(response: 0.9, dampingFraction: 0.8, blendDuration: 0.5), value: isLast)
        }
    }
    
    @ViewBuilder
    func ScreenView(size: CGSize, index: Int) -> some View {
        let intro = intros[index]
        
        VStack(spacing: 10) {
            Text(intro.title)
                .font(.title3)
            // MARK: Applying offset for each screen's
                .offset(x: -size.width * CGFloat(currentIndex - index))
            // MARK: Adding Animation
                .animation(.interactiveSpring(response: 0.9, dampingFraction: 0.8, blendDuration: 0.5).delay(currentIndex == index ? 0.2 : 0), value: currentIndex)
            Text(dummyText)
                .font(.title3)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 30)
                .offset(x: -size.width * CGFloat(currentIndex - index))
                .animation(.interactiveSpring(response: 0.9, dampingFraction: 0.8, blendDuration: 0.5).delay(0.1), value: currentIndex)
            Image(intro.imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 250, alignment: .top)
                .padding(.horizontal, 20)
                .offset(x: -size.width * CGFloat(currentIndex - index))
                .animation(.interactiveSpring(response: 0.9, dampingFraction: 0.8, blendDuration: 0.5).delay(currentIndex == index ? 0 : 0.2), value: currentIndex)
        }
    }
    
    // MARK: Welcome screen
    func WelcomeView(size: CGSize, index: Int) -> some View {
        VStack(spacing: 10) {
            Image("Welcome")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 250, alignment: .top)
                .padding(.horizontal, 20)
                .offset(x: -size.width * CGFloat(currentIndex - index))
                .animation(.interactiveSpring(response: 0.9, dampingFraction: 0.8, blendDuration: 0.5).delay(currentIndex == index ? 0 : 0.2), value: currentIndex)
            
            Text("Welcome")
                .font(.title3)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 30)
                .offset(x: -size.width * CGFloat(currentIndex - index))
                .animation(.interactiveSpring(response: 0.9, dampingFraction: 0.8, blendDuration: 0.5).delay(0.1), value: currentIndex)
            
            Text("Stay orgainised and live stress-free with \nyou-do app.")
                .font(.title3)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 30)
                .offset(x: -size.width * CGFloat(currentIndex - index))
                .animation(.interactiveSpring(response: 0.9, dampingFraction: 0.8, blendDuration: 0.5).delay(0.1), value: currentIndex)
        }
    }
    
    // MARK: Nav Bar
    @ViewBuilder
    func NavBar() -> some View {
        let isLast = currentIndex == intros.count
        HStack {
            Button {
                if currentIndex > 0 {
                    currentIndex -= 1
                } else {
                    showWalkThroughScreens.toggle()
                }
            } label: {
                Image(systemName: "chevron.left")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundColor(.black)
            }
            
            Spacer()
            Button("Skip") {
                currentIndex = intros.count
            }
            .foregroundColor(.black)
            .opacity(isLast ? 0 : 1)
            .animation(.easeInOut, value: isLast)
        }
        .padding(.horizontal, 15)
        .padding(.top, 10)
        .frame(maxHeight: .infinity, alignment: .top)
        .offset(y: showWalkThroughScreens ? 0 : -120)
    }
    
    @ViewBuilder
    func IntroScreen() -> some View {
        GeometryReader {
            let size = $0.size
            
            VStack(spacing: 10) {
                Image("Intro")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: size.width, height: size.height/2)
                Text("Clearhead")
                    .font(.title)
                    .padding(.top, 55)
                
                Text(dummyText)
                    .font(.title3)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 30)
                
                Text("Let's Begin")
                    .font(.title3)
                    .padding(.horizontal, 40)
                    .padding(.vertical, 14)
                    .foregroundColor(.white)
                    .background {
                        Capsule()
                            .fill()
                    }
                    .onTapGesture {
                        showWalkThroughScreens.toggle()
                    }
                    .padding(.top, 30)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            //MARK: Moving Up When Clicked
            .offset(y: showWalkThroughScreens ? -size.height : 0)
            
        }
        .ignoresSafeArea()
    }
}

struct IntroView_Previews: PreviewProvider {
    static var previews: some View {
        IntroView()
    }
}
