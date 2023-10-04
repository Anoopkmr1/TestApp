//
//  DataResponse.swift
//  LibraryApp
//
//  Created by Anoop on 03/10/23.
//

import Foundation

struct DataResponse: Decodable {  // this is an array
    let userID, id: Int
    let title: String

    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case id, title
    }
}


