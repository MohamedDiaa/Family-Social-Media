//
//  CIImage+Extension.swift
//  FamilySocialMedia
//
//  Created by Mohamed Alwakil on 2025-03-11.
//

import CoreImage

extension CIImage {

    var cgImage: CGImage? {
        let ciContext = CIContext()

        guard let cgImage = ciContext.createCGImage(self, from: self.extent) else {
            return nil
        }

        return cgImage
    }

}
