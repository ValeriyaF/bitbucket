//
//  GmsAuthSettings.swift
//  GMSLibrary
//
//  Created by Cindy Wong on 2019-07-12.
//

import Foundation
import Alamofire

/// Authentication settings.
public enum GmsAuthSettings: Encodable {

    /// No authentication used.
    case none

    /// Basic Auth.
    case basic(user: String, password: String)

    var authorizationHeader: (key: String, value: String)? {
        switch self {
        case let .basic(user, password):
            return Request.authorizationHeader(user: user, password: password)
        default:
            return nil
        }
    }

    enum CodingKeys: String, CodingKey {
        case encoded
    }

    public func encode(to encoder: Encoder) throws {
        switch self {
        case let .basic(user, password):
            var container = encoder.container(keyedBy: CodingKeys.self)
            let base64 = "\(user):\(password)".data(using: .utf8)
            try container.encode(base64?.base64EncodedString(), forKey: .encoded)
        default: break
        }
    }
}
