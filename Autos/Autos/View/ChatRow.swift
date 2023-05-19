//
//  ChatRow.swift
//  Autos
//
//  Created by iMac on 21/4/2023.
//

import SwiftUI

struct ChatRow: View {
    var chatData:Chat
    var otherUserData:User
    var body: some View {
        
        
        HStack(spacing: 20) {
        Image ("avatar2")
        .resizable()
        .frame (width: 70, height: 70)
        .clipShape (Circle () )
            ZStack {
                VStack(alignment:.leading,spacing:5){
                    HStack {
                        Text (otherUserData.FullName)
                            .bold ()
                    }
                    .frame(maxWidth: .infinity,alignment: .leading)
                    
                    
                }
                }
                    
        }.frame(height: 80)
                
            }
}


