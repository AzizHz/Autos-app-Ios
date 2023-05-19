//
//  ProductDetailView.swift
//  Autos
//
//  Created by iMac on 13/4/2023.
//

import SwiftUI

struct ProductDetailView: View {
    var product : Product
    var animation: Namespace.ID
    //Shared data model
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var sharedData:SharedDataViewModel
    @StateObject var chatData: ChatViewModel = ChatViewModel()

    var body: some View {
        VStack{
            //Title bar and product Image
          
            
            VStack{
                HStack{
                    Button{
                        dismiss()
                        
                    } label: {
                        Image(systemName: "arrow.left")
                            .font(.title2)
                            .foregroundColor(Color.black.opacity(0.7))
                    }
                    Spacer()
                    Button{
                        
                    }label: {
                        Image(systemName: "heart.fill")
                            .font(.title2)
                            .foregroundColor(.black.opacity(0.7))
                        
                    }
                }.padding()
                if let selectedImageData = Data(base64Encoded: product.image , options: .ignoreUnknownCharacters),
                   let uiImage = UIImage(data: selectedImageData){
                    Image(uiImage: uiImage).resizable()
                        .resizable()
                        .clipShape(CustomCorners(corners: [.topLeft,.topRight], raduis: 25))

                        .aspectRatio( contentMode: .fill)
                        .matchedGeometryEffect(id: "\(product.id)IMAGE", in: animation)
                        .offset(y:-12)
                    .frame(maxHeight: .infinity)
                }else{
                    Image("wheell")
                        .resizable()
                        .aspectRatio( contentMode: .fit)
                        .matchedGeometryEffect(id: "\(product.id)IMAGE", in: animation)
                        .offset(y:-12)
                    .frame(maxHeight: .infinity)}
                    
            }
            
                .frame(height: getRect().height/2.7)
            //Product Details ...
            ScrollView(.vertical,showsIndicators: false){
                
                VStack(alignment: .leading,spacing: 15){
                    Text(product.Title)
                        .font(.system(size: 20).bold())
                    Text(product.Description)
                        .font(.system(size: 15))
                        .foregroundColor(.gray)
                    
                    Button{
                        if let userData = UserDefaults.standard.data(forKey: "currentUser"),
                           let _user = try? JSONDecoder().decode(User.self, from: userData) {
                            let userId = _user._id
                            chatData.createChat(senderId:userId , receiverId: product.User)
                            // Do something with userId
                        } else {
                            print("User data not found in UserDefaults")
                        }
                        
                        
                    }label: {
                        Text("Ask to trade").foregroundColor(.white)
                            .font(.system(size: 20).bold())
                            .padding(.vertical,15)
                            .frame(maxWidth: .infinity)
                            .background(
                                Color.black)
                            .cornerRadius(10)
                            .shadow(radius: 5,x: 5,y: 5)
                    }.padding(.top,250)
                }.padding([.horizontal,.bottom],20)
                    .padding(.top,25)
                    .frame(maxWidth: .infinity,alignment: .leading)
                
            }.frame(maxWidth: .infinity,maxHeight: .infinity)
                .background(Color.white
                    .clipShape(CustomCorners(corners: [.topLeft,.topRight], raduis: 25))
                    .padding(.top,-40)
                    .ignoresSafeArea())
            
        }.background(Color.black.opacity(0.12).ignoresSafeArea())
            .navigationBarHidden(true)
        
    }
}

struct ProductDetailView_Previews: PreviewProvider {
    static var previews: some View {
       //sample product for binding Preview ...
       // ProductDetailView(product: HomeViewModel().products[0])
         //   .environmentObject(SharedDataViewModel())
        MainPage()
    }
}
