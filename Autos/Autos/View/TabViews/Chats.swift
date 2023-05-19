//
//  Chat.swift
//  Autos
//
//  Created by iMac on 21/4/2023.
//

import SwiftUI

struct Chats: View {
    @StateObject var chatData: ChatViewModel = ChatViewModel()
    var body: some View {
        VStack{
            Text ("Chats")
                .font (.system(size: 28).bold())
                .frame(maxWidth: .infinity,alignment: .leading)
            ScrollView(.vertical,showsIndicators: false){
                VStack{
                    ForEach(Array(chatData.users.enumerated()), id: \.1.id) { (index, user) in
                        NavigationLink(destination: ChatPage(chat: chatData.chats[index], otherUser:user)) {
                            ChatRow(chatData: chatData.chats[index], otherUserData: user)
                        }
                        .foregroundColor(.black)
                    }
                    
                }
                
            }
            
        }.padding()
    }
}

struct Chat_Previews: PreviewProvider {
    static var previews: some View {
        Chats()
    }
}
