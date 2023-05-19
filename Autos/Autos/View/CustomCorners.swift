//
//  CustomCorners.swift
//  Autos
//
//  Created by iMac on 12/4/2023.
//

import SwiftUI

struct CustomCorners: Shape {
    var corners:UIRectCorner
    var raduis:CGFloat
    func path(in rect :CGRect) -> Path {
        let path=UIBezierPath(roundedRect:rect, byRoundingCorners: corners,cornerRadii: CGSize(width:raduis,height:raduis))
        return Path(path.cgPath)
        
    }
    
}


