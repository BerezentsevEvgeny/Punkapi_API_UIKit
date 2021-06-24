//
//  Model.swift
//  TEST Collection
//
//  Created by Евгений Березенцев on 23.06.2021.
//

import Foundation

struct WelcomeElement: Decodable {
    let id: Int
    let name, tagline, firstBrewed, welcomeDescription: String
    let imageURL: String


    enum CodingKeys: String, CodingKey {
        case id, name, tagline
        case firstBrewed = "first_brewed"
        case welcomeDescription = "description"
        case imageURL = "image_url"

    }
}
