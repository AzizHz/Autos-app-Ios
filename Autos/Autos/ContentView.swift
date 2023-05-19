//
//  ContentView.swift
//  Autos
//
//  Created by iMac on 11/4/2023.
//

import SwiftUI

struct ContentView: View {
   
    @AppStorage("log_Status") var log_Status:Bool=false
    @AppStorage("email_verif") var email_verif:Bool=false

    

    var body: some View {
        Group{
            if log_Status{
                NavigationView{
                    MainPage()
                        
                      
                }.navigationBarBackButtonHidden(true)
            }
            else if email_verif {
                EmailVerifPage()
                
            }
            else if !email_verif && !log_Status {
                LoginPage()
                
            }
            else{
                OnBoardingPage()
            }
            
        }
        
        }
    
   
    }

    

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
