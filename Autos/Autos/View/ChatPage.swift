//
//  ChatPage.swift
//  Autos
//
//  Created by iMac on 21/4/2023.
//

import SwiftUI
import Combine
import SocketIO

struct ChatPage: View {
    var chat:Chat
    var otherUser:User
    @StateObject var messageData: MessageViewModel = MessageViewModel()
    var socket: SocketIOClient?
    @State private var dataChanged = false
    @State private var text=""
    @FocusState private var isFocused
    init(chat: Chat, otherUser: User) {
        self.chat = chat
        self.otherUser = otherUser
        self._messageData = StateObject(wrappedValue: MessageViewModel())
        self.socket = SocketHandler.shared.setSocket()
    }
    var body: some View {
        VStack (spacing: 0){
            GeometryReader{render in
                ScrollView{
                    getMessagesView()
                        .padding(.horizontal)
                        .onAppear {
                                            messageData.fetchMessages(for: chat._id)
                            setupSocket()
                                        }
                        /*.onReceive(messageData.$messages) { _ in
                                                  dataChanged = true // set dataChanged to true when messages change
                                              }*/
                }
            } 
            toolBarView()
            
        }.padding(.top,1)
            .navigationBarTitleDisplayMode(.inline)
            /*.onReceive(Just(dataChanged)) { changed in
                        if changed {
                            setupSocket() // call setupSocket() when data changes
                            dataChanged = false // set dataChanged back to false
                        }
                    }*/
    }
    
    func setupSocket() {
        let userData = UserDefaults.standard.data(forKey: "currentUser")!
        let _user = try? JSONDecoder().decode(User.self, from: userData)
        let userId = _user!._id

        
        
        socket?.emit("new-user-add", userId)

      
           
        socket?.on("recieve-message") { data, ack in
                if let message = data[0] as? [String: Any] {
                    let chatId = message["chatId"] as? String ?? ""
                    let senderId = message["senderId"] as? String ?? ""
                    let text = message["text"] as? String ?? ""
                    let id = message["_id"] as? String ?? ""
                    let newMessage = Message(_id:id,chatId: chatId, senderId: senderId, text: text)
                    messageData.messages.append(newMessage)
                }
            }
        socket?.connect()

    
        }
    func toolBarView() -> some View {
        VStack{
            let height:CGFloat = 37
            HStack{
                TextField("Message ...",text:$text)
                    .padding(.horizontal)
                    .frame(height: height)
                    .background(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 13))
                    .focused($isFocused)
                Button(action:{
                    if let userData = UserDefaults.standard.data(forKey: "currentUser"),
                       let _user = try? JSONDecoder().decode(User.self, from: userData) {
                        let userId = _user._id
                        messageData.sendMessage(chatId: chat._id, text:text, senderId:userId)
                        
                        let messageData = [
                            "chatId": chat.id,
                                        "senderId": userId,
                                        "text": text
                                    ]
                        socket?.emit("send-message",messageData)
                        text=""  // Do something with userId
                    } else {
                        print("User data not found in UserDefaults")
                    }
                }){
                    Image(systemName: "paperplane.fill")
                        .foregroundColor(.white)
                        .frame(width: height,height: height)
                        .background(
                        Circle()
                            .foregroundColor(text.isEmpty ? .gray : .blue)
                        )
                    
                }
                .disabled(text.isEmpty)
                .frame(height: height)
                
            }
        }
        .padding(.vertical)
        .padding(.horizontal)
        .background(.thickMaterial)
        
    }
    let columns=[GridItem(.flexible(minimum: 10))]
    func  getMessagesView()-> some View{
        LazyVGrid(columns: columns){
            ForEach(messageData.messages){message in
                let userData = UserDefaults.standard.data(forKey: "currentUser")!
                let _user = try? JSONDecoder().decode(User.self, from: userData)
                let userId = _user!._id
                let sender = userId == message.senderId
                
                    HStack{
                        ZStack {
                            Text(message.text)
                                .foregroundColor(sender ? .white.opacity(0.9): .black)
                                .padding(.horizontal)
                                .padding(.vertical, 12)
                                .background(sender ? .black : Color.black.opacity(0.2)
                                )
                                .cornerRadius(20)
                            
                        }
                        .frame(width: getRect().width * 0.7,alignment: sender ? .trailing : .leading)
                        .padding(.vertical,5)
                        
                    }
                    .frame(maxWidth: .infinity,alignment: sender ? .trailing : .leading)
                    //.id(message.id) auto scroll
              
                
            }
        }
    }
}

struct ChatPage_Previews: PreviewProvider {
    static var previews: some View {
        MainPage()
        
    }
}
