//
//  User.swift
//  Autos
//
//  Created by Mac Mini 6 on 26/4/2023.
//

import SwiftUI
struct User: Decodable, Identifiable,Encodable {
    var id: String { _id } // provide an id property using _id
    
    var _id: String
    var FullName: String
    var Email: String
    var Password: String
    var image:String
}
