//
//  ChatViewModel.swift
//  Autos
//
//  Created by Mac Mini 6 on 26/4/2023.
//

import SwiftUI

class ChatViewModel: ObservableObject {
    init() {
          fetchChats()
      }
    
    @Published var chats: [Chat] = []
    @Published var users: [User] = []
    
        
    func fetchChats() {
        let userData = UserDefaults.standard.data(forKey: "currentUser")!
        let _user = try? JSONDecoder().decode(User.self, from: userData)
        let userId = _user!._id
        print(userId)
        // Do something with userId

        guard let url = URL(string: "https://autos-backend.onrender.com/Chat/\(userId)") else {
            print("Invalid URL")
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                print("Data received from server: \(data.count) bytes")
                if let responseString = String(data: data, encoding: .utf8) {
                    print("Response string: \(responseString)")
                }

                do {
                    let decodedResponse = try JSONDecoder().decode([Chat].self, from: data)
                    DispatchQueue.main.async {
                        self.chats = decodedResponse
                        for chat in self.chats {

                            if chat.members[0]==userId{
                                self.fetchUserData(userId: chat.members[1])

                            }
                            else{
                                self.fetchUserData(userId: chat.members[0])

                            }

                            /*for memberId in chat.members {
                                if memberId != "63d5888b4f5f3bcd612a177e"{
                                    self.fetchUserData(userId: memberId)
                                }
                            }*/
                        }
                        print(self.chats)
                    }
                } catch {
                    print("Error decoding product data: \(error.localizedDescription)")
                }
            } else if let error = error {
                print("Error fetching product data: \(error.localizedDescription)")
            }
        }.resume()
    }
    func fetchUserData(userId: String) {
        guard let url = URL(string: "https://autos-backend.onrender.com/User/\(userId)") else {
            print("Invalid URL")
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                do {
                    let decodedResponse = try JSONDecoder().decode(User.self, from: data)
                    DispatchQueue.main.async {
                        self.users.append(decodedResponse)
                        print(self.users)

                    }
                } catch {
                    print("Error decoding user data: \(error.localizedDescription)")
                }
            } else if let error = error {
                print("Error fetching user data: \(error.localizedDescription)")
            }
        }.resume()
    }
    func createChat(senderId:String,receiverId:String){
        
        
        let endpoint = "https://autos-backend.onrender.com/Chat"
                
                guard let url = URL(string: endpoint) else { return }
                
                var request = URLRequest(url: url)
                request.httpMethod = "POST"
                request.addValue("application/json", forHTTPHeaderField: "Content-Type")
                
        let requestBody = ["senderId":senderId ,"receiverId": receiverId]
                
                do {
                    request.httpBody = try JSONSerialization.data(withJSONObject: requestBody, options: [])
                } catch {
                    print("Error serializing request body: \(error.localizedDescription)")
                    return
                }
                
                URLSession.shared.dataTask(with: request) { data, response, error in
                    if let error = error {
                        print("Error registering user: \(error.localizedDescription)")
                        return
                    }
                    guard let httpResponse = response as? HTTPURLResponse else {
                        print ("unexpected response type")
                        return
                    }
                    if httpResponse.statusCode == 200{
                        print("chat created successfully !")
                        
                    }else{
                        print("unexpected respons status code :\(httpResponse.statusCode)")
                    }
                    
                    
                    // Process response data if necessary
                }.resume()
             
        
    }
    }




