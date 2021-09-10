//
//  Data+nestedJson.swift
//  Netify
//
//  Created by Łukasz Szarkowicz on 10.09.2021.
//  Copyright © 2021 Mobilee. All rights reserved.
//

import Foundation

extension Data {
    
    /**
     Returns JSON data encapsulated at keyPath in given data.
     
     - parameter keyPath: name at which nested json exists
     
     - returns: Data of nested json.
     */
    func nestedJson(with keyPath: String) throws -> Data {
        do {
            let json = try JSONSerialization.jsonObject(with: self, options: .allowFragments) as AnyObject
            if let nestedJson = json.value(forKeyPath: keyPath) {
                let data = try JSONSerialization.data(withJSONObject: nestedJson)
                return data
            } else {
                throw JSONSerializationError.invalidKeyPath
            }
        } catch {
            throw JSONSerializationError.serializationError
        }
    }
}

/// `JSONSerializationError` is the error type returned during JSONSerialization.
///
/// - invalidKeyPath:       Returned when a nested dictionary object doesn't exist at special keyPath.
/// - emptyKeyPath:         Returned when a keyPath is empty.
/// - serializationError:   Returned when process of serialization is corrupted.
public enum JSONSerializationError: Error {
    case invalidKeyPath
    case emptyKeyPath
    case serializationError
}

extension JSONSerializationError: LocalizedError {

    public var errorDescription: String? {
        switch self {
        case .invalidKeyPath:
            return "Nested object doesn't exist at this keyPath."
        case .emptyKeyPath:
            return "KeyPath can not be empty."
        case .serializationError:
            return "Error during serialization"
        }
    }
}
