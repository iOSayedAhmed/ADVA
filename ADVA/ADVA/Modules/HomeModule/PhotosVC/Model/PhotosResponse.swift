//
//  PhotosResponse.swift
//  ADVA
//
//  Created by iOSAYed on 20/01/2024.
//

import Foundation

// MARK: - PhotosResponseElement
struct PhotosResponseElement: Codable {
    let albumID, id: Int
    let title: String
    let url, thumbnailURL: String

    enum CodingKeys: String, CodingKey {
        case albumID = "albumId"
        case id, title, url
        case thumbnailURL = "thumbnailUrl"
    }
}


typealias PhotosResponse = [PhotosResponseElement]
