//
//  QrCodePage.swift
//  Autos
//
//  Created by iMac on 6/5/2023.
//

import SwiftUI
import CoreImage.CIFilterBuiltins
struct QrCodePage: View {
    let context = CIContext()
    let filter = CIFilter.qrCodeGenerator()
    let url : String
    var body: some View {
        Image(uiImage: generateQRCodeImage(url))
            .interpolation(.none)
            .resizable()
            .frame(width: 150,height: 150,alignment: .center)
            
    }
    func generateQRCodeImage(_ url:String)->UIImage{
        let data = Data(url.utf8)
        filter.setValue(data, forKey: "inputMessage")
        if let qrCodeImage = filter.outputImage{
            if let qrCodeImage = context.createCGImage(qrCodeImage, from: qrCodeImage.extent){
                return UIImage(cgImage: qrCodeImage)
            }
        }
        return UIImage(systemName: "xmark") ?? UIImage()
    }
    
}

struct QrCodePage_Previews: PreviewProvider {
    static var previews: some View {
        QrCodePage(url: "test")
    }
}
