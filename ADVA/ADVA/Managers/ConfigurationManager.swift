//
//  ConfigrationManager.swift
//  ADVA
//
//  Created by iOSAYed on 20/01/2024.
//

import Foundation

struct ConfigurationManager {

    enum ConfigurationError: Error {
        case invalidPath
        case invalidInfo
    }

    static let shared = ConfigurationManager()
    private let fileName = "Configuration"

    private init() { }

    var baseURL: String {
        guard let urlString = try? baseURLInfo()["baseURL"] as? String else { return "" }
        return urlString
    }

    public var privateKey: String {
        guard let info = try? baseURLInfo(),
              let privateKey = info["privateKey"] as? String else { return "" }
        return privateKey
    }

    func baseURLInfo() throws -> NSDictionary {
        guard let path = Bundle.main.path(forResource: fileName, ofType: "plist") else {
            throw ConfigurationError.invalidPath
        }

        guard let info = NSDictionary(contentsOfFile: path) else {
            throw ConfigurationError.invalidInfo
        }

        return info
    }

    func getCurrentLanguage() -> String {
        let language = Locale.preferredLanguages.first
        if let languageCode = language {
            return languageCode
        }
        return "en"
    }
}
