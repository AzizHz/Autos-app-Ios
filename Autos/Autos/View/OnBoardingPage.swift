//
//  OnBoardingPage.swift
//  Autos
//
//  Created by iMac on 12/4/2023.
//

import SwiftUI

struct OnBoardingPage: View {
    @State private var isActive = false
    @State private var size = 0.6
    @State private var opacity = 0.5
    
    var body: some View {
        ZStack(alignment: .center){
            ZStack{
                Image("Autos")
                    .resizable()
                    .scaledToFit()
                .frame(width: 200.0, height: 220.0, alignment: .top)
                
            }
            .scaleEffect(size)
            .opacity(opacity)
            .onAppear{
                withAnimation(.easeIn(duration: 1.2)){
                    self.size = 0.8
                    self.opacity = 1.0
                }
            }
            
                
                
          
            
        }
        .frame(maxWidth: .infinity,maxHeight: .infinity)
        .background(
               Image("background")
                   .resizable()
                   .edgesIgnoringSafeArea(.all)
                   .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        .onAppear{
            DispatchQueue.main.asyncAfter(deadline: .now()+2.0) {
                
                self.isActive=true
            }
        }
        .overlay(
            Group{
                if isActive{
                    LoginPage()
                        .transition(.move(edge: .bottom))
                }
            }
        )
    }
        
}

struct OnBoardingPage_Previews: PreviewProvider {
    static var previews: some View {
        OnBoardingPage()
    }
}
