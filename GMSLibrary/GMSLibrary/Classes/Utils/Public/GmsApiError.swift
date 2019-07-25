//
//  GmsApiError.swift
//  GMSLibrary
//
//  Created by Cindy Wong on 2019-07-08.
//

import Alamofire
import Foundation

public enum GmsApiError: Error, CustomStringConvertible {
    case missingGmsSettings
    case missingServiceName
    case missingAuthenticationParameters
    case invalidAuthenticationParameters
    case missingCallbackId
    case missingGmsSettingsValue(key: String)
    case invalidParameter(key: String, value: String?)
    case invalidDateFormat(key: String, value: String)
    case gmsExceptionThrown(exception: GmsCallbackException)
    case invalidResponse(data: Data?)
    case invalidHttpStatusCode(statusCode: Int?, error: Error?)
    case notFound
    case chatErrorStatus(response: ChatV2Response)
    case chatEnded
    case encodingError(error: Error)
    case chatFileIdNotFound(response: ChatV2Response)
    case downloadError(response: DefaultDownloadResponse?)
    case unsupportedOperation(request: ApiRequest, operation: String)
    case cometClientError(error: Error)
    case cometConnectFailed
    case chatSessionNotStarted
    case cometFileError(error: Error?)

    public var description: String {
        switch self {
        case .missingGmsSettings:
            return "Missing GMS Settings"
        case .missingServiceName:
            return "Missing Service Name"
        case .missingAuthenticationParameters:
            return "Missing Authentication Parameters"
        case .invalidAuthenticationParameters:
            return "Invalid Authentication Parameters"
        case .missingCallbackId:
            return "Missing Callback ID"
        case let .missingGmsSettingsValue(key):
            return "GMS Settings field \(key) is not set"
        case let .invalidParameter(key, value):
            return "Invalid parameter key=\(key), value=\(value ?? "nil")"
        case let .invalidDateFormat(key, value):
            return "Invalid date format for key=\(key), value=\(value)"
        case let .gmsExceptionThrown(exception):
            return "GMS exception thrown: \(exception)"
        case let .invalidResponse(data):
            return "Invalid response from GMS: \(String(describing: data))"
        case let .invalidHttpStatusCode(statusCode, error):
            let code: String
            if let statusCode = statusCode {
                code = "\(statusCode)"
            } else {
                code = "[unknown]"
            }
            let errorMsg: String
            if let error = error {
                errorMsg = String(describing: error)
            } else {
                errorMsg = "[unknown]"
            }
            return "Invalid HTTP Status Code \(code), Error \(errorMsg)"
        case .notFound:
            return "The requested item cannot be found"
        case let .chatErrorStatus(response):
            return "Chat error (response=\(response))"
        case .chatEnded:
            return "Chat ended"
        case let .encodingError(error):
            let errorMsg = String(describing: error)
            return "Error encoding multi-part form data request: \(errorMsg)"
        case let .chatFileIdNotFound(response):
            return "File ID not returned in chat response: \(response)"
        case let .downloadError(response):
            return "Download error: \(String(describing: response ?? nil))"
        case let .unsupportedOperation(request, operation):
            return "Unsupported operation \(operation) for \(request)"
        case let .cometClientError(error):
            let errorMsg = String(describing: error)
            return "Comet client error \(errorMsg)"
        case .cometConnectFailed:
            return "Comet client failed to connect"
        case .chatSessionNotStarted:
            return "Comet chat session not yet started"
        case let .cometFileError(error):
            let errorMsg: String
            if let error = error {
                errorMsg = String(describing: error)
            } else {
                errorMsg = "[unknown]"
            }
            return "Comet chat file operation error \(errorMsg)"
        }
    }

    var invalidOrMissingKey: String? {
        switch self {
        case let .missingGmsSettingsValue(key):
            return key
        case .invalidDateFormat(let key, _):
            return key
        case .invalidParameter(let key, _):
            return key
        default:
            return nil
        }
    }

    var invalidResponse: Data? {
        switch self {
        case let .invalidResponse(data):
            return data
        default: return nil
        }
    }

    var httpStatusCode: Int? {
        switch self {
        case .invalidHttpStatusCode(let statusCode, _):
            return statusCode
        default:
            return nil
        }
    }

    var errorReturned: Error? {
        switch self {
        case let .invalidHttpStatusCode(_, error):
            return error
        default:
            return nil
        }
    }

    var gmsExceptionReturned: GmsCallbackException? {
        switch self {
        case let .gmsExceptionThrown(exception):
            return exception
        default:
            return nil
        }
    }
}
