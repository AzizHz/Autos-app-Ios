//
//  Message.swift
//  Autos
//
//  Created by Mac Mini 6 on 26/4/2023.
//

import SwiftUI
struct Message: Decodable, Identifiable {
    var id: String { _id } // provide an id property using _id
    
    var _id: String
    var chatId: String
    var senderId: String
    var text: String
}

