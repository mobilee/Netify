//
//  URLRequest+encode.swift
//  Netify
//
//  Created by Lukasz Szarkowicz on 10/09/2021.
//  Copyright © 2021 Mobilee. All rights reserved.
//

import Foundation

extension URLRequest {
    mutating func encode(with encoding: ParameterEncoding) throws {
        do {
            try encoding.encode(urlRequest: &self)
        } catch {
            throw error
        }
    }
}
