//
//  GmsUserSettings.swift
//  GMSLibrary
//
//  Created by Cindy Wong on 2019-07-12.
//

import Foundation

/// These are settings meant to be user-configurable.
public struct GmsUserSettings: Codable {
    public var phoneNumber: String?
    public var firstName: String?
    public var lastName: String?
    public var nickname: String?
    public var email: String?

    public init() {}
}
