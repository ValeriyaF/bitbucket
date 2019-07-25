//
//  GmsPushNotificationSettings.swift
//  GMSLibrary
//
//  Created by Cindy Wong on 2019-07-12.
//

import Foundation

/// Push notification settings
public enum GmsPushNotificationSettings: Encodable {
    // No notification
    case none

    // FCM notification
    case fcm(_ token: String?, debug: Bool?, language: String?, provider: String?)

    // Apple Push notification pending
    //case ios

    /// Creates a new FCM notification settings instance.
    public static func createFCM(
        _ token: String? = nil,
        debug: Bool? = nil,
        language: String? = nil,
        provider: String? = nil) -> GmsPushNotificationSettings {
        return .fcm(token, debug: debug, language: language, provider: provider)
    }

    var type: String {
        switch self {
        case .none:
            return "none"
        case .fcm:
            return "fcm"
        }
    }

    // MARK: - Encodable

    enum CodingKeys: String, CodingKey {
        case deviceId = "push_notification_deviceid"
        case type = "push_notification_type"
        case debug = "push_notification_debug"
        case language = "push_notification_language"
        case provider = "push_notification_provider"
    }

    public func encode(to encoder: Encoder) throws {
        switch self {
        case let .fcm(token, debug, lang, provider):
            var container = encoder.container(keyedBy: CodingKeys.self)
            guard let token = token else {
                throw GmsApiError.missingGmsSettingsValue(key: "fcmToken")
            }
            try container.encode(token, forKey: .deviceId)
            try container.encode("fcm", forKey: .type)
            try container.encodeIfPresent(debug, forKey: .debug)
            try container.encodeIfPresent(lang, forKey: .language)
            try container.encodeIfPresent(provider, forKey: .provider)
        default: break
        }
    }
}
