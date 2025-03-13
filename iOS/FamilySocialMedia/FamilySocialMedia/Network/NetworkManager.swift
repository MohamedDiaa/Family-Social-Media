//
//  NetworkManager.swift
//  FamilySocialMedia
//
//  Created by Mohamed Alwakil on 2025-03-13.
//
import Foundation

struct Photo: Codable {
    var photoId: String
    var url: String
}

class NetworkManager {

    func postPhoto(photo: Photo) async {

        do {
            let url =  URL.init(string: "https://family-social-media.onrender.com/photo")!
            var request = URLRequest.init(url: url)
            request.httpMethod = "POST"
            request.httpBody = try? JSONEncoder().encode(photo)


            let (data, response) = try await URLSession.shared.data(for: request)

        }
        catch {
            print(error.localizedDescription)
        }
    }

    func getPhotos() async -> [Photo] {

        do {
            let url =  URL.init(string: "https://family-social-media.onrender.com/photos")!
            var request = URLRequest.init(url: url)
            request.httpMethod = "GET"


            let (data, response) = try await URLSession.shared.data(for: request)

            let photos = try JSONDecoder().decode([Photo].self, from: data)
            return photos
        }
        catch {
            print(error.localizedDescription)
        }

        return []
    }
}
