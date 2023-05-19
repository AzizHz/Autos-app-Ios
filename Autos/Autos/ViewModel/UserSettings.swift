//
//  UserSettings.swift
//  Autos
//
//  Created by iMac on 18/5/2023.
//

import SwiftUI

class UserSettings: ObservableObject {
    @Published var user:User?
    init() {
        user = retreiveUser()
    }
    func retreiveUser()->User?{
       if let userData = UserDefaults.standard.data(forKey: "currentUser"),
          let user = try? JSONDecoder().decode(User.self, from: userData){
           return user}
        return nil

    }
}


