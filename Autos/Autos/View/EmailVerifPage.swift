//
//  EmailVerifPage.swift
//  Autos
//
//  Created by iMac on 18/5/2023.
//

import SwiftUI

struct EmailVerifPage: View {
    @StateObject var loginData: LoginViewModel = LoginViewModel()

    var body: some View {
        VStack{
            Text( "Check Your Email")
                .font(.system(size: 30).bold())
                .frame(maxWidth: .infinity,alignment: .center)
                .padding(.top,20)
            Text( "We have sent a verification email to the email address")
                .font(.system(size: 12).weight(.light))
                .multilineTextAlignment(.center)
                .foregroundColor(.gray)
                .frame(maxWidth: .infinity,alignment: .center)
                .padding(.horizontal)
                .padding(.top,1)
            Text( "mohamed.ali@gmail.com")
                .tint(.black)
                .font(.system(size: 12).weight(.light))
                .multilineTextAlignment(.center)
                .frame(maxWidth: .infinity,alignment: .center)
                .padding(.horizontal)
                
            Image("email-verification")
                .resizable()
                .aspectRatio( contentMode: .fit)
                .frame(maxWidth: getRect().width*0.35)
                .padding(.top,40)
            
            Button {
                loginData.email_verif=false
            }
        label: {
            Text("Back to Login")
                .font(.system(size: 18).bold())
                .padding(.vertical,15)
                .frame(maxWidth: .infinity)
                .foregroundColor(Color.white)
                .background(Color.black)
                .cornerRadius(10)
                .shadow(color: Color.black.opacity(0.1), radius:5,x: 5,y: 5)

            
        }
        .padding(.top,50)
            
        }.padding(30)
            .padding(.bottom,60)
    }
}

struct EmailVerifPage_Previews: PreviewProvider {
    static var previews: some View {
        EmailVerifPage()
    }
}
