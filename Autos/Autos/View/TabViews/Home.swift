//
//  Home.swift
//  Autos
//
//  Created by iMac on 12/4/2023.
//

import SwiftUI

struct Home: View {
    var animation:Namespace.ID
    @EnvironmentObject var sharedData:SharedDataViewModel
    @StateObject var homeData: HomeViewModel = HomeViewModel()
  
    private let adaptiveColumns = [
        GridItem(.adaptive(minimum: 170))
    ]
    
    var body: some View {
            VStack{
                HStack{
                    Image(systemName: "magnifyingglass")
                        .font(.title2)
                        .foregroundColor(.gray)
                    TextField("Search...",text: .constant(""))
                        .disabled(true)
                }
                .padding(.vertical,12)
                .padding(.horizontal)
                .background(
                    Capsule()
                        .strokeBorder(Color.gray,lineWidth: 0.8))
                Text("Products")
                    .frame(maxWidth: .infinity,alignment: .leading)
                    .font(.system(size: 20).bold())
                    .padding()
                
                ScrollView(.vertical,showsIndicators: false){
                    
                    LazyVGrid(columns: adaptiveColumns, spacing: 20){
                        ForEach(homeData.products){product in
                            NavigationLink(destination: ProductDetailView(product: product, animation: animation)) {
                                ProductCardView(product: product)

                            }.foregroundColor(.black)
                        }
                    }
                    
                }
                
                
            }.padding()
        }
    @ViewBuilder
    func ProductCardView(product:Product)->some View{
        VStack (spacing: 0){
            ZStack{
                if sharedData.showDetailProduct{
                    Image("images")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                }
                else{
                    if let selectedImageData = Data(base64Encoded: product.image , options: .ignoreUnknownCharacters),
                       let uiImage = UIImage(data: selectedImageData){
                        Image(uiImage: uiImage).resizable()
                            .aspectRatio(contentMode: .fit)
                            .clipShape(CustomCorners(corners: .allCorners, raduis: 10))

                            .matchedGeometryEffect(id:"\(product.id)IMAGE", in: animation)
                    }}
            }
            .frame(width: 160,height:150)
                .offset(y:-100)
                .padding(.bottom,-80)
            Text(product.Title)
                .font(.system(size:18))
                .fontWeight(.semibold)
                .padding(.bottom,10)
            
                
                
        }
        .padding(10)
        .padding(.top,80)
        .background(
            Color.gray.opacity(0.1).cornerRadius(20))
        
        
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        MainPage()
    }
}
extension View{
    func getRect()->CGRect{
        return UIScreen.main.bounds
    }
}
