//
//  EditProfilPage.swift
//  Autos
//
//  Created by iMac on 19/5/2023.
//

import SwiftUI
import _PhotosUI_SwiftUI

struct EditProfilPage: View {
    @State private var selectedItem: PhotosPickerItem? = nil
    @State private var selectedImageData: Data? = nil
    
    @StateObject var loginData: LoginViewModel = LoginViewModel()
    var body: some View {
        
        VStack {
            if let selectedImageData,
               let uiImage = UIImage(data: selectedImageData) {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFit()
                    .clipShape(CustomCorners(corners: .allCorners, raduis: 25))
                    .frame(width: .infinity)
                   
                    

                   
            } else {
                Image(systemName: "photo.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width:.infinity)
                    .foregroundColor(.gray)
            }
            
            PhotosPicker(
                selection: $selectedItem,
                matching: .images,
                photoLibrary: .shared()) {
                    Text("Select a photo")
                }
                .onChange(of: selectedItem) { newItem in
                    Task {
                        // Retrieve selected asset in the form of Data
                        if let data = try? await newItem?.loadTransferable(type: Data.self) {
                            selectedImageData = data
                        }
                    }
                }
            
            CustomTextField(icon: "envelope", title: "Title", value:$loginData.updateFullName , hint: "Title", showPassword: .constant(false))
                .padding(.top,30)
          
            
            Button {
                uploadProduct()
            }
        label: {
            Text("Add New")
                .font(.system(size: 18).bold())
                .padding(.vertical,15)
                .frame(maxWidth: .infinity)
                .foregroundColor(Color.white)
                .background(Color.black)
                .cornerRadius(10)
                .shadow(color: Color.black.opacity(0.1), radius:5,x: 5,y: 5)

            
        }

        .padding(.horizontal)
            .padding(.top, 20)
            .disabled(loginData.updateFullName.isEmpty ||  selectedImageData == nil)
            
        }
        .padding(30)
    }
    
    func uploadProduct() {
        guard let selectedImageData = selectedImageData,
              let uiImage = UIImage(data: selectedImageData) else { return }
        let compressionQuality: CGFloat = 0.5
        if let jpegData = uiImage.jpegData(compressionQuality: compressionQuality) {
            loginData.updateImage=jpegData.base64EncodedString()
            loginData.UpdateUser()
            
            
            
            
        }}
    
    @ViewBuilder
    func CustomTextField(icon:String,title:String,value:Binding<String>,hint:String,showPassword:Binding<Bool>) -> some View{
        
        VStack(alignment: .leading){
         
                Text(title)
                    .font(.system(size: 14))
                    .foregroundColor(Color.black.opacity(0.8))
            
           
                TextField(hint,text: value,axis: .vertical )
                    .padding(.top,2)
            Divider()
                .background(Color.black.opacity(0.4))
                    
            
            
            
            
        }
        //showing show button for password field
        
    }
    
}
struct EditProfilPage_Previews: PreviewProvider {
    static var previews: some View {
        EditProfilPage()
    }
}
