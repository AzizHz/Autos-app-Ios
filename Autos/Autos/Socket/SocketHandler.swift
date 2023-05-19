//
//  SocketHandler.swift
//  Autos
//
//  Created by Mac Mini 1 on 1/5/2023.
//
import SocketIO
import Foundation

class SocketHandler {
    
    static let shared = SocketHandler()
      
    let manager = SocketManager(socketURL: URL(string: "https://autos-backend-socket.onrender.com")!)
     func setSocket() -> SocketIOClient{
       
        let mSocket = manager.defaultSocket
         mSocket.connect()
         return mSocket
    }
    


     func getSocket() -> SocketIOClient? {
         return manager.defaultSocket
    }

    
 func closeConnection() {
        manager.defaultSocket.disconnect()
    }
}

