//
//  QRCode.swift
//  MD2
//
//  Created by Will Taylor on 19/02/2019.
//  Copyright © 2019 Will Taylor. All rights reserved.
//

import UIKit

struct QRCode {
    
    // HOW TO SCAN A BARCODE;
    // https://www.hackingwithswift.com/example-code/media/how-to-scan-a-barcode
    
    /// Generates a QR code from the given string.
    /// Code: https://www.hackingwithswift.com/example-code/media/how-to-create-a-qr-code
    static func generate(from string: String) -> UIImage? {
        let data = string.data(using: String.Encoding.ascii)
        
        if let filter = CIFilter(name: "CIQRCodeGenerator") {
            filter.setValue(data, forKey: "inputMessage")
            let transform = CGAffineTransform(scaleX: 3, y: 3)
            
            if let output = filter.outputImage?.transformed(by: transform) {
                return UIImage(ciImage: output)
            }
        }
        
        return nil
    }
}
