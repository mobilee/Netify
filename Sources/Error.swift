//
//  Error.swift
//  Netify
//
//  Created by Łukasz Szarkowicz on 10.09.2021.
//  Copyright © 2021 Mobilee. All rights reserved.
//

import Foundation

public struct APIError: Swift.Error {
    let name: String
    let code: Int?
}

public extension APIError {
    
    static let unknown: APIError = .init(name: "UNKNOWN", code: nil)
}

public extension APIError {
    enum EncodingError: String, Error {
        case parametersNil = "Parameters were nil."
        case encodingFailed = "Parameter encoding failed."
        case missingURL = "URL is nil."
    }
}
