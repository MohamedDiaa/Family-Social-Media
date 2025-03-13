//
//  Photo.swift
//  FamilySocialMedia
//
//  Created by Mohamed Alwakil on 2025-03-14.
//
import Foundation

struct Photo: Codable {
    var photoId: String
    var url: String

    private enum CodingKeys: String, CodingKey {
           case photoId, url
       }

    var thumbnail: URL {

        return URL.init(string: "https://res.cloudinary.com/family-social-media/image/upload/c_thumb,w_200,g_face/v1741905816/\(photoId).jpg")!
    }
}
