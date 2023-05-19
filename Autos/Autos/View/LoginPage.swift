//
//  LoginPage.swift
//  Autos
//
//  Created by iMac on 12/4/2023.
//

import SwiftUI

struct LoginPage: View {
    @StateObject var loginData: LoginViewModel = LoginViewModel()
    var body: some View {
        VStack{
           

            ScrollView(.vertical,showsIndicators: false){
                VStack(spacing: 15){
                    Text(loginData.registerUser ? "Create an Account" : "Welcome Back")
                        .font(.system(size: 30).bold())
                        .frame(maxWidth: .infinity,alignment: .center)
                        .padding(.top,20)
                    Text( "You will be able to find a wide selection of off-road cars from top brands")
                        .font(.system(size: 15).weight(.light))
                        .multilineTextAlignment(.center)
                        .foregroundColor(.gray)
                        .frame(maxWidth: .infinity,alignment: .center)
                        .padding(.horizontal)
                        
                    if loginData.registerUser{
                        CustomTextField(icon: "person", title: "FullName", value: $loginData.fullName, hint: "Jhon Snow", showPassword: .constant(false))
                        .padding(.top,30)}
                    CustomTextField(icon: "envelope", title: "Email", value: $loginData.email, hint: "Please enter your email", showPassword: .constant(false))
                        .padding(.top,30)
                    
                    CustomTextField(icon: "lock", title: "Password", value: $loginData.password, hint: "Please enter your password", showPassword: $loginData.showPassword)
                        .padding(.top,30)
                    if loginData.registerUser{
                        CustomTextField(icon: "lock", title: "Re-Enter Password", value: $loginData.re_Enter_Password, hint: "123456", showPassword: $loginData.showReEnterPassword)
                            .padding(.top,30)
                    }
                   
                    Button{
                        loginData.ForgotPassword()
                    } label: {
                        Text("Forgot password ?")
                            .font(.system(size: 14))
                            .fontWeight(.semibold)
                    }
                    .padding(.top,5)
                    .frame(maxWidth: .infinity,alignment: .trailing)
                    Button{
                        if loginData.registerUser{
                            loginData.Register()
                        }
                        else{
                            loginData.Login()
                        }
                    } label: {
                        Text("Confim")
                            .font(.system(size: 18).bold())
                            .padding(.vertical,15)
                            .frame(maxWidth: .infinity)
                            .foregroundColor(Color.white)
                            .background(Color.black)
                            .cornerRadius(10)
                            .shadow(color: Color.black.opacity(0.1), radius:5,x: 5,y: 5)

                        
                    }
                    .padding(.top,15)
                    .padding(.horizontal)
                    
                    Button{
                        withAnimation{
                            loginData.registerUser.toggle()
                        }
                        
                    } label: {
                        Text(loginData.registerUser ?"Back to login" : "Create account")
                            .font(.system(size: 14))
                            .fontWeight(.semibold)
                    }
                    .padding(.top,5)
                    
                    
                    
                }.padding(30)
                
                
                
                
                
            }
                .frame(maxWidth: .infinity,maxHeight: .infinity)
                .background(Color.white
                    .clipShape(CustomCorners(corners: [.topLeft,.topRight], raduis: 25))
                    .ignoresSafeArea()
                )
            
        }
        .frame(maxWidth: .infinity,maxHeight: .infinity)
        .background(
            Color.gray)
        
        
        // clearing data when changes...
        .onChange(of: loginData.registerUser) {newValue in
            loginData.email = ""
            loginData.password = ""
            loginData.fullName = ""
            loginData.re_Enter_Password = ""
            loginData.showPassword = false
            loginData.showReEnterPassword = false
        }
    }
    @ViewBuilder
    func CustomTextField(icon:String,title:String,value:Binding<String>,hint:String,showPassword:Binding<Bool>) -> some View{
        
        VStack(alignment: .leading){
            Label{
                Text(title)
                    .font(.system(size: 14))
                
            } icon: {
                Image(systemName: icon)
                
            }
            .foregroundColor(Color.black.opacity(0.8))
            
            if title.contains("Password") && !showPassword.wrappedValue{
                SecureField(hint,text: value)
                    .padding(.top,2)
            }
            else{
                TextField(hint,text: value)
                    .padding(.top,2)
            }
            
            
            Divider()
                .background(Color.black.opacity(0.4))
        }
        //showing show button for password field
        .overlay(
            Group{
                if title.contains("Password"){
                    Button(action: {showPassword.wrappedValue.toggle()}, label: {Image(systemName:showPassword.wrappedValue ? "eye.slash" : "eye")
                            .foregroundColor(.gray)
                            .font(.system(size: 13).bold())
                            
                    }
                           
                    )
                    .offset(y:8)
                }
            }
            ,alignment: .trailing
        )
    }
}

struct LoginPage_Previews: PreviewProvider {
    static var previews: some View {
        LoginPage()
    }
}
