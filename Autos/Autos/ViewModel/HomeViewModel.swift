//
//  HomeViewModel.swift
//  Autos
//
//  Created by iMac on 12/4/2023.
//

import SwiftUI

class HomeViewModel: ObservableObject {
    init() {
          fetchProducts()
      }
    
    @Published var products: [Product] = []
    @Published var Title: String = ""
    @Published var Description: String = ""
    @Published var image: String = ""
        func fetchProducts() {
            guard let url = URL(string: "https://autos-backend.onrender.com/Post") else {
                print("Invalid URL")
                return
            }
            
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data {
                    do {
                        let decodedResponse = try JSONDecoder().decode([Product].self, from: data)
                        DispatchQueue.main.async {
                            self.products = decodedResponse
                        }
                    } catch {
                        print("Error decoding product data: \(error.localizedDescription)")
                    }
                } else if let error = error {
                    print("Error fetching product data: \(error.localizedDescription)")
                }
            }.resume()
        }
    func addProduct(){
        let userData = UserDefaults.standard.data(forKey: "currentUser")!
        let _user = try? JSONDecoder().decode(User.self, from: userData)
        let userId = _user!._id
        print(userId)
        let endpoint = "https://autos-backend.onrender.com/Post/add"
        
        guard let url = URL(string: endpoint) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let requestBody = ["User": userId, "Title": Title,"Description":Description,"image":image]
        
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
            if httpResponse.statusCode == 200 {
                
                    print("success")
               
            } else {
                print("unexpected respons status code :\(httpResponse.statusCode)")
            }
        }.resume()
        
    }
    }

