//
//  ParameterEncoder.swift
//  Netify
//
//  Created by Lukasz Szarkowicz on 10/09/2021.
//  Copyright © 2021 Mobilee. All rights reserved.
//

import Foundation

public protocol ParameterEncoder {
    var parameters: RequestParameters { get }
    var headers: HTTPHeaders { get }
    func encode(urlRequest: inout URLRequest) throws
}

// MARK: - Empty Parameter Encoder
public struct EmptyParameterEncoder: ParameterEncoder {
    public var parameters: RequestParameters = [:]
    public var headers: HTTPHeaders = ["Content-Type": "application/json"]
    
    public func encode(urlRequest: inout URLRequest) throws {
        urlRequest.setHeaders(headers: headers)
    }
}

// MARK: - JSON Parameter Encoder
public struct JSONParameterEncoder: ParameterEncoder {
    public var parameters: RequestParameters
    public var headers: HTTPHeaders = ["Content-Type": "application/json"]
    
    init(jsonParameters: RequestParameters) {
        self.parameters = jsonParameters
    }
    
    public func encode(urlRequest: inout URLRequest) throws {
        do {
            let jsonAsData = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
            urlRequest.httpBody = jsonAsData
            urlRequest.setHeaders(headers: headers)
        } catch {
            throw APIError.EncodingError.encodingFailed
        }
    }
}

// MARK: - URL Parameter Encoder
public struct URLParameterEncoder: ParameterEncoder {
    public var parameters: RequestParameters
    public var headers: HTTPHeaders = ["Content-Type": "application/x-www-form-urlencoded; charset=utf-8"]
    
    init(urlParameters: RequestParameters) {
        self.parameters = urlParameters
    }
    
    public func encode(urlRequest: inout URLRequest) throws {
        guard let url = urlRequest.url else { throw APIError.EncodingError.missingURL }

        if var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false), !parameters.isEmpty {
            urlComponents.queryItems = [URLQueryItem]()

            for (key, value) in parameters {
                let value = "\(value)".addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
                let queryItem = URLQueryItem(name: key,
                                             value: value)
                urlComponents.queryItems?.append(queryItem)
            }
            urlRequest.url = urlComponents.url
        }
        
        urlRequest.setHeaders(headers: headers)
    }
}
