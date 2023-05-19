//
//  LoginPageModel.swift
//  Autos
//
//  Created by iMac on 12/4/2023.
//

import SwiftUI

class LoginViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var fullName: String=""
    @Published var updateFullName: String=""
    @Published var updateImage: String=""


    @Published var showPassword: Bool = false
    // Register Properties
    @Published var registerUser: Bool = false
    @Published var re_Enter_Password: String = ""
    @Published var showReEnterPassword: Bool = false
    // Login Call.
    @AppStorage("log_Status") var log_Status:Bool=false
    @AppStorage("email_verif") var email_verif:Bool=false
    


    func Login() {
        let endpoint = "https://autos-backend.onrender.com/User/login"
        
        guard let url = URL(string: endpoint) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let requestBody = ["Email": email, "Password": password]
        
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
                    let user = try JSONDecoder().decode(User.self, from: data)
                    UserDefaults.standard.set(try? JSONEncoder().encode(user), forKey: "currentUser")
                    
                    print("user logged in successfully !")
                    if let userData = UserDefaults.standard.data(forKey: "currentUser"),
                       let _user = try? JSONDecoder().decode(User.self, from: userData) {
                        let userId = _user._id
                        print(userId)
                        // Do something with userId
                    } else {
                        print("User data not found in UserDefaults")
                    }
                    withAnimation{
                        self.log_Status=true
                    }
                } catch {
                    print("Error decoding user data: \(error.localizedDescription)")
                }
            } else {
                print("unexpected respons status code :\(httpResponse.statusCode)")
            }
        }.resume()
    }
    func Register(){
        // Do Action Here.
        
        
        let endpoint = "https://autos-backend.onrender.com/User/register"
                
                guard let url = URL(string: endpoint) else { return }
                
                var request = URLRequest(url: url)
                request.httpMethod = "POST"
                request.addValue("application/json", forHTTPHeaderField: "Content-Type")
                
        let requestBody = ["FullName":fullName ,"Email": email, "Password": password]
                
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
                        print("user registred successfully !")
                        withAnimation{
                        
                            self.log_Status=true
                        }
                        
                    }else{
                        print("unexpected respons status code :\(httpResponse.statusCode)")
                    }
                    
                    
                    // Process response data if necessary
                }.resume()
             
        
        
        
    }
    func UpdateUser(){
        let userData = UserDefaults.standard.data(forKey: "currentUser")!
        let _user = try? JSONDecoder().decode(User.self, from: userData)
        let userId = _user!._id
        let endpoint = "https://autos-backend.onrender.com/User/update/\(userId)"
                
                guard let url = URL(string: endpoint) else { return }
                
                var request = URLRequest(url: url)
                request.httpMethod = "PATCH"
                request.addValue("application/json", forHTTPHeaderField: "Content-Type")
                
        let requestBody = ["FullName":updateFullName ,"image": updateImage]
        
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
                    let user = try JSONDecoder().decode(User.self, from: data)
                    UserDefaults.standard.set(try? JSONEncoder().encode(user), forKey: "currentUser")
                    
                    print("user logged in successfully !")
                    if let userData = UserDefaults.standard.data(forKey: "currentUser"),
                       let _user = try? JSONDecoder().decode(User.self, from: userData) {
                        let userId = _user._id
                        print(userId)
                        // Do something with userId
                    } else {
                        print("User data not found in UserDefaults")
                    }
                   
                } catch {
                    print("Error decoding user data: \(error.localizedDescription)")
                }
            } else {
                print("unexpected respons status code :\(httpResponse.statusCode)")
            }
        }.resume()
        
        
    }
    func ForgotPassword( ){}
} 

 
