//
//  ParameterEncoding.swift
//  Netify
//
//  Created by Łukasz Szarkowicz on 10.09.2021.
//  Copyright © 2021 Mobilee. All rights reserved.
//

import Foundation

public enum ParameterEncoding {

    case `default`
    case urlEncoding(urlParameters: RequestParameters)
    case jsonEncoding(bodyParameters: RequestParameters)
    case urlAndJsonEncoding(urlParameters: RequestParameters, bodyParameters: RequestParameters)
    case specialUrlEncoding(urlParameters: RequestParameters)

    public func encode(urlRequest: inout URLRequest) throws {
        do {
            switch self {
            case .default:
                try EmptyParameterEncoder().encode(urlRequest: &urlRequest)
            case .urlEncoding(let params):
                try URLParameterEncoder(urlParameters: params).encode(urlRequest: &urlRequest)

            case .jsonEncoding(let params):
                try JSONParameterEncoder(jsonParameters: params).encode(urlRequest: &urlRequest)

            case .urlAndJsonEncoding(let urlParams, let jsonParams):
                try URLParameterEncoder(urlParameters: urlParams).encode(urlRequest: &urlRequest)
                try JSONParameterEncoder(jsonParameters: jsonParams).encode(urlRequest: &urlRequest)

            case .specialUrlEncoding(let params):
                try URLParameterEncoder(urlParameters: params).encode(urlRequest: &urlRequest)
                try EmptyParameterEncoder().encode(urlRequest: &urlRequest)
            }
        } catch {
            throw error
        }
    }
}

extension ParameterEncoding: CustomDebugStringConvertible {
    public var debugDescription: String {
        switch self {
        case .urlEncoding(let params):
            return "URL parameters: \(params.debugDescription)"
        case .jsonEncoding(let params):
            return "JSON body parameters: \(params.debugDescription)"
        case .urlAndJsonEncoding(let urlParams, let bodyParams):
            return "URL parameters: \(urlParams.debugDescription)\nJSON body parameters: \(bodyParams.debugDescription)"
        case .specialUrlEncoding(let params):
            return "URL parameters: \(params.debugDescription)"
        case .default:
            return "No parameters"
        }
    }
}
