//
//  SharedDataViewModel.swift
//  Autos
//
//  Created by iMac on 13/4/2023.
//

import SwiftUI

class SharedDataViewModel: ObservableObject {
    @Published var detailProduct: Product?
    @Published var showDetailProduct:Bool = false
    //@Published var connectedUser:User?
}

