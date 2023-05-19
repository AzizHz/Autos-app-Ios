//
//  FaceIdPage.swift
//  Autos
//
//  Created by iMac on 8/5/2023.
//

import SwiftUI
import LocalAuthentication


struct FaceIdPage: View {
    var body: some View {
        Button{
          faceIdHandle()
        } label: {
            Text("Confim")
                .font(.system(size: 18).bold())
                .padding(.vertical,15)
                .frame(maxWidth: .infinity)
                .foregroundColor(Color.white)
                .background(Color.black)
                .cornerRadius(10)
                .shadow(color: Color.black.opacity(0.1), radius:5,x: 5,y: 5)

            
        }
        .padding(.top,15)
        .padding(.horizontal)
        
    }
func faceIdHandle(){
    let context = LAContext()
        var error: NSError?
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Authenticate with Face ID") { (success, error) in
                if success {
                    print("Authentication succeeded")
                   
                        
                        
                        

                
                        
            } else {
                    print("Authentication failed")

                    
                }
            }
        } else {
            print("Biometric authentication is not available")
            // Add your logic to handle biometric authentication not available
        }

    
 }
}


struct FaceIdPage_Previews: PreviewProvider {
    static var previews: some View {
        FaceIdPage()
    }
}
