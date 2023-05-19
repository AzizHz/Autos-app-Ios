//
//  MessageViewModel.swift
//  Autos
//
//  Created by Mac Mini 11 on 26/4/2023.
//

import SwiftUI

class MessageViewModel: ObservableObject {
    @Published var messages: [Message] = []

    func fetchMessages(for chatId: String) {
        guard let url = URL(string: "https://autos-backend.onrender.com/Message/\(chatId)") else {
            print("Invalid URL")
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                do {
                    let decodedResponse = try JSONDecoder().decode([Message].self, from: data)
                    DispatchQueue.main.async {
                        self.messages = decodedResponse
                        print(self.messages)
                    }
                } catch {
                    print("Error decoding message data: \(error.localizedDescription)")
                }
            } else if let error = error {
                print("Error fetching message data: \(error.localizedDescription)")
            }
        }.resume()
    }
    func sendMessage( chatId: String,text:String,senderId:String) {
       
        let endpoint = "https://autos-backend.onrender.com/Message"
                
                guard let url = URL(string: endpoint) else { return }
                
                var request = URLRequest(url: url)
                request.httpMethod = "POST"
                request.addValue("application/json", forHTTPHeaderField: "Content-Type")
                
        let requestBody = ["senderId":senderId ,"chatId": chatId,"text":text]
                
                do {
                    request.httpBody = try JSONSerialization.data(withJSONObject: requestBody, options: [])
                } catch {
                    print("Error serializing request body: \(error.localizedDescription)")
                    return
                }
                
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Something went wrong: \(error.localizedDescription)")
                return
            }
            guard let httpResponse = response as? HTTPURLResponse else {
                print ("unexpected response type")
                return
            }
            if httpResponse.statusCode == 200, let data = data {
                do {
                    let message = try JSONDecoder().decode(Message.self, from: data)
                   
                    print(message)
                  
                   
                } catch {
                    print("Error decoding user data: \(error.localizedDescription)")
                }
            } else {
                print("unexpected respons status code :\(httpResponse.statusCode)")
            }
        }.resume()
    }
}
