//
//  AlbumsResponse.swift
//  ADVA
//
//  Created by iOSAYed on 20/01/2024.
//

import Foundation


// MARK: - AlbumsResponseElement
struct AlbumsResponseElement: Codable {
    let userID, id: Int
    let title: String

    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case id, title
    }
}

typealias AlbumsResponse = [AlbumsResponseElement]
