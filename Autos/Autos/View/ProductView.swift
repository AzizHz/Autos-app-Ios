//
//  ProductView.swift
//  Autos
//
//  Created by iMac on 16/4/2023.
//

import SwiftUI

struct ProductView: View {
    var productData : Product
    var animation : Namespace.ID
    var body: some View {
        VStack(alignment:.leading,spacing: 6){
            ZStack{
                Color(.gray).opacity(0.4)
                    .cornerRadius(15)
                Image("images")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(20)
            }
            Text(productData.Title)
                .fontWeight(.heavy)
                .foregroundColor(.gray)
        }
    }
}


 
