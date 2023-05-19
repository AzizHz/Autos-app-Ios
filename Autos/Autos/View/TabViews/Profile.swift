//
//  Profile.swift
//  Autos
//
//  Created by iMac on 12/4/2023.
//

import SwiftUI

struct Profile: View {
    @AppStorage("log_Status") var log_Status:Bool=false
   @ObservedObject var userSettings=UserSettings()
   
    var body: some View {
        NavigationView{
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 0){
                    Text ("My Profile")
                        .font (.system(size: 28).bold())
                        .frame(maxWidth: .infinity,alignment: .leading)
                    VStack(spacing:30){
                     
                        
                        
                            
                        VStack(spacing: 15){
                            Image ("Profile_Image")
                                .resizable()
                                .aspectRatio (contentMode: .fill)
                                .frame (width: 60, height: 60)
                                .clipShape(Circle())
                                .offset(y:-35)
                                .padding(.bottom,-30)
                
                            Text(userSettings.user?.FullName ?? "Me")
                                    .font(.system(size: 16))
                                .fontWeight(.semibold)}
                           
                            HStack(alignment: .top,spacing: 10){
                                Image(systemName: "location.north.circle.fill")
                                    .foregroundColor(.gray)
                                    .rotationEffect(.init(degrees: 180))
                                Text( "Email: \(userSettings.user!.Email)\nManchester, UK")
                                    .font(.system(size: 15))
                            }
                            .frame(maxWidth: .infinity,alignment: .leading)
                        }
                        .padding([.horizontal,.vertical])
                        .background(Color.gray.opacity(0.1).cornerRadius(12))
                        .padding()
                        .padding(.top,40)
                        //custom navigation links ...
                        VStack (spacing:2){
                            CustoNavigationLink(title: "Edit Profile"){
                                EditProfilPage()
                                    .navigationTitle("Edit Profile")
                                    .frame(maxWidth: .infinity,maxHeight: .infinity)
                                    .ignoresSafeArea()
                            }
                            CustoNavigationLink(title: "QR Code"){
                                QrCodePage(url: "Yassine khabtheni")
                                    .navigationTitle("QR Code")
                                    .frame(maxWidth: .infinity,maxHeight: .infinity)
                                    .ignoresSafeArea()
                            }
                            CustoNavigationLink(title: "Terms & Conditions"){
                                FaceIdPage()
                                    .navigationTitle("Terms & Conditions")
                                    .frame(maxWidth: .infinity,maxHeight: .infinity)
                                    .ignoresSafeArea()
                            }
                            CustoNavigationLink(title: "Privacy Policy"){
                                Text("")
                                    .navigationTitle("Privacy policy")
                                    .frame(maxWidth: .infinity,maxHeight: .infinity)
                                    .ignoresSafeArea()
                            }}
                        
                        HStack{
                            Text("Logout")
                                .font(.system(size: 17))
                                .fontWeight(.semibold)
                            Spacer()
                            Button(action: {
                                let userDefaults = UserDefaults.standard
                                userDefaults.removeObject(forKey: "currentUser")
                                // Add other user defaults keys to be cleared
                                userDefaults.synchronize() // make sure to synchronize the changesn action code here
                                log_Status=false
                                
                            }) {
                                Image(systemName: "rectangle.portrait.and.arrow.right")

                                    .font(.system(size: 18))
                                    
                            }
                            
                            
                        }
                        .foregroundColor(.black)
                        .padding()
                        .background(Color.gray.opacity(0.1).cornerRadius(12))
                        .padding(.horizontal)
                        .padding(.top ,10)
                        
                        
                    }
                   
                } .padding(.horizontal,22)
                    .padding(.vertical,20)
            }
            .navigationBarHidden(true)
            .frame(maxWidth: .infinity,maxHeight: .infinity)
            
        }
        
    }
    
    @ViewBuilder
    func CustoNavigationLink<Detail:View>(title:String,@ViewBuilder content:@escaping ()->Detail)->some View{
        NavigationLink{
            content()
        }label: {
            HStack{
                Text(title)
                    .font(.system(size: 17))
                    .fontWeight(.semibold)
                Spacer()
                Image(systemName: "chevron.right")
                
                
            }
            .foregroundColor(.black)
            .padding()
            .background(Color.gray.opacity(0.1).cornerRadius(12))
            .padding(.horizontal)
            .padding(.top ,10)

            
        }
    }



struct Profile_Previews: PreviewProvider {
    static var previews: some View {
        Profile()
    }
}
