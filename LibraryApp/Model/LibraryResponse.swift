//
//  LibraryResponse.swift
//  LibraryApp
//
//  Created by Anoop on 03/10/23.
//

import Foundation


struct LibraryResponse: Decodable {
    let albumID, id: Int
    let title: String
    let url, thumbnailURL: String

    enum CodingKeys: String, CodingKey {
        case albumID = "albumId"
        case id, title, url
        case thumbnailURL = "thumbnailUrl"
    }
}
