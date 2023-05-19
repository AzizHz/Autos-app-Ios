//
//  MainPage.swift
//  Autos
//
//  Created by iMac on 12/4/2023.
//

import SwiftUI

struct MainPage: View {
    @State var currentTab:Tab = .Home
    @State var sharedData:SharedDataViewModel=SharedDataViewModel()


@Namespace var animation
    init() {
        UITabBar.appearance().isHidden = true
    }
    var body: some View {
        VStack(spacing:0){
            
            TabView(selection: $currentTab){
                Home(animation:animation)
                    .environmentObject(sharedData)
                    .tag(Tab.Home)
                
                QRScannerPage()
                    .tag(Tab.QR)
                AddProduct()
                    .tag(Tab.New)
                Chats()
                    .tag(Tab.Chat)
                Profile()
                    .tag(Tab.Profile)
            }
            HStack(spacing: 0){
                ForEach(Tab.allCases,id: \.self){tab in
                    Button{
                        //updating tab ...
                        currentTab = tab
                    } label:{
                        Image(systemName:tab.rawValue)
                            .resizable()
                            .renderingMode(.template)
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 25,height: 25)
                            .background(
                                Color.black.opacity(0.1).cornerRadius(8)
                                    .blur(radius: 8)
                                    .padding(-7)
                                    .opacity(currentTab == tab ? 1 : 0)
                            )
                            .frame(maxWidth: .infinity)
                            .foregroundColor(currentTab == tab ? Color.black :Color.gray.opacity(0.9))
                    }
                }
            }
            .padding([.horizontal,.bottom])
            .padding(.bottom,5)
            
        }
        .background(Color.white.ignoresSafeArea())
       
    }
    
    
}

struct MainPage_Previews: PreviewProvider {
    static var previews: some View {
        MainPage()
    }
}

enum Tab: String,CaseIterable {
    case Home = "house.fill"
    case QR  = "qrcode.viewfinder"
    case New = "plus.circle"
    case Chat = "message.fill"
    case Profile = "person.fill"
}
