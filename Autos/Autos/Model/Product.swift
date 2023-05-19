//
//  Product.swift
//  Autos
//
//  Created by iMac on 13/4/2023.
//

import SwiftUI
struct Product: Decodable, Identifiable {
    var id: String { _id } // provide an id property using _id
    
    var _id: String
    var Title: String
    var Description: String
    var User: String
    var image:String
}
