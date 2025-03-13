//
//  CloudinaryHelper.swift
//  FamilySocialMedia
//
//  Created by Mohamed Alwakil on 2025-03-12.
//
import Foundation
import Cloudinary
import UIKit

class CloudinaryHelper {

    static let shared = CloudinaryHelper()

    var cloudinary: CLDCloudinary

    init() {

        guard let path = Bundle.main.path(forResource: "Keys", ofType: "plist"),
              let keys = NSDictionary(contentsOfFile: path),
              let cloudName = keys["cloudName"] as? String,
              let apiKey = keys["apiKey"] as? String,
              let apiSecret = keys["apiSecret"] as? String
        else { fatalError("secret keys plist is missing")   }


        let config = CLDConfiguration.init(cloudName: cloudName, apiKey: apiKey, apiSecret: apiSecret, secure: true)
        cloudinary = CLDCloudinary(configuration: config)
    }

//    func setUploadCloud(_ cloudName: String?) {
//        guard let cloudName = cloudName else {
//            return
//        }
//        UserDefaults.standard.set(cloudName, forKey: cloudName)
//    }
//
//    func getUploadCloud() -> String? {
//        guard let cloudName = UserDefaults.standard.value(forKey: cloudName) as? String else {
//            return nil
//        }
//        return cloudName
//    }

    func upload(image: UIImage) {

        guard let data = image.jpegData(compressionQuality: 1.0)
        else { return }

        let _ = cloudinary
            .createUploader()
            .upload(data: data, uploadPreset: "iOS-app", params: CLDUploadRequestParams())
            .response { response, error in
                print("completion")
                if let error = error {
                    print("Error: \(error.localizedDescription)")
                } else {
                    print("Upload Success: \(response?.secureUrl ?? "No URL")")
                }
            }
    }
}
