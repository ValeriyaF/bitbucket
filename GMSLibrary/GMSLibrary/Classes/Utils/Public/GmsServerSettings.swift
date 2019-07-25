//
//  GmsServerSettings.swift
//  GMSLibrary
//
//  Created by Cindy Wong on 2019-07-12.
//

import Foundation

/// Thess are server-level settings meant to be internal to the app.  Immutable.
public class GmsServerSettings {

    public let hostname: String
    public let port: Int?
    public let app: String
    public let secureProtocol: Bool

    public let gmsUser: String?

    public let apiKey: String?

    public let additionalHeaders: [(field: String, value: String)]

    public let pushSettings: GmsPushNotificationSettings
    public let authSettings: GmsAuthSettings

    public init(hostname: String,
                port: Int? = nil,
                app: String = "genesys",
                secureProtocol: Bool = true,
                gmsUser: String? = nil,
                apiKey: String? = nil,
                authSettings: GmsAuthSettings = .none,
                pushSettings: GmsPushNotificationSettings = .none,
                additionalHeaders: [(field: String, value: String)] = []
                ) throws {
        if hostname.isEmpty {
            throw GmsApiError.missingGmsSettingsValue(key: "hostname")
        }
        self.hostname = hostname
        if let port = port, (port <= 0 || port > 65536) {
                throw GmsApiError.invalidParameter(key: "port", value: port.description)
        }
        self.port = port
        if app.isEmpty {
            throw GmsApiError.missingGmsSettingsValue(key: "app")
        }
        self.gmsUser = gmsUser
        self.app = app
        self.secureProtocol = secureProtocol
        self.apiKey = apiKey
        self.pushSettings = pushSettings
        self.authSettings = authSettings
        self.additionalHeaders = additionalHeaders
    }

    /// Returns the base URL of GMS instance provided
    var baseUrl: String? {
        let proto = (secureProtocol) ? "https" : "http"
        let portPart: String
        if let port = port {
            portPart = ":\(port)"
        } else {
            portPart = ""
        }
        let appPart = app.replacingOccurrences(of: #"(^/+|/+$)"#, with: "", options: .regularExpression)
        let baseUrl = "\(proto)://\(hostname)\(portPart)/\(appPart)"
        debugPrint("[GmsSettings] baseUrl = \(baseUrl)")
        return baseUrl
    }

    public func updateFcmToken(_ token: String) throws -> GmsServerSettings {
        switch pushSettings {
        case .none:
            return self
        case let .fcm(_, debug, language, provider):
            let pushSettings = GmsPushNotificationSettings.fcm(token,
                                                               debug: debug,
                                                               language: language,
                                                               provider: provider)
            return try GmsServerSettings(hostname: self.hostname,
                                     port: self.port,
                                     app: self.app,
                                     secureProtocol: self.secureProtocol,
                                     gmsUser: self.gmsUser,
                                     apiKey: self.apiKey,
                                     authSettings: self.authSettings,
                                     pushSettings: pushSettings,
                                     additionalHeaders: additionalHeaders)
        }
    }
}
