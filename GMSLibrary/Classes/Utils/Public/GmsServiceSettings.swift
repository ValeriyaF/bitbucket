//
//  GmsSettings.swift
//  GMSLibrary
//
//  Created by Cindy Wong on 2019-07-02.
//

import Foundation

public typealias ParameterValue = Codable & CustomStringConvertible

/// These are service-level settings meant to be internal to the app.  Immutable.
open class GmsServiceSettings {
    /// Name of the service as defined in GMS.
    public let serviceName: String

    /// Additional parameters for the service.
    open var additionalParameters: [String: ParameterValue] {
        return properties
    }

    let properties: [String: ParameterValue]

    public init(
        _ serviceName: String,
        additionalParameters: [String: ParameterValue] = [String: ParameterValue]()) throws {
        if serviceName.isEmpty {
            throw GmsApiError.missingGmsSettingsValue(key: "serviceName")
        }
        self.serviceName = serviceName
        self.properties = additionalParameters
    }
}
