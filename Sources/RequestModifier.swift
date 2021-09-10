//
//  RequestModifier.swift
//  Netify
//
//  Created by Łukasz Szarkowicz on 10.09.2021.
//  Copyright © 2021 Mobilee. All rights reserved.
//

import Foundation

extension URLRequest {
    mutating func addHeaders(headers: HTTPHeaders) {
        for header in headers {
            addValue(header.value, forHTTPHeaderField: header.key)
        }
    }
    
    mutating func setHeaders(headers: HTTPHeaders) {
        for header in headers {
            setValue(header.value, forHTTPHeaderField: header.key)
        }
    }
}

public protocol RequestModifier {
    func modify(for request: inout URLRequest)
}

public protocol BearerAuthorization: RequestModifier {
    var token: String { get }
}

extension BearerAuthorization {
    public func modify(for request: inout URLRequest) {
        request.setHeaders(headers: ["Authorization": "Bearer \(token)"])
    }
}
