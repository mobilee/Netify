//
//  Endpoint.swift
//  Netify
//
//  Created by Łukasz Szarkowicz on 10.09.2021.
//  Copyright © 2021 Mobilee. All rights reserved.
//

import Foundation

public protocol Endpoint: CustomDebugStringConvertible {
    
    associatedtype Model: Decodable
    typealias Completion = NetworkCompletion<Model>

    var path: String { get }
    var method: HTTPMethod { get }
    var task: HTTPTask { get }
    var headers: HTTPHeaders? { get }
    var keyPath: String? { get } // search key for response object
    var parametersEncoding: ParameterEncoding { get }
    var api: API { get }
    
    var baseURL: URL { get } // base url of endpoint
    var url: URL { get } // entire url for endpoint
    var requestURL: URL { get } // full url including query parameters
    
    func buildURLRequest() throws -> URLRequest
}

public extension Endpoint {
    
    var method: HTTPMethod {
        return .get
    }
    
    var task: HTTPTask {
        .request
    }
    
    var baseURL: URL {
        return api.url
    }
    
    var url: URL {
        return baseURL.appendingPathComponent(path)
    }
    
    var requestURL: URL {
        return request.url!
    }
    
    var parametersEncoding: ParameterEncoding {
        return .default
    }
    
    func buildURLRequest() throws -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        
        if let headers = api.apiHeaders {
            // add global headers
            request.setHeaders(headers: headers)
        }
        
        if let headers = headers {
            // add local headers
            request.setHeaders(headers: headers)
        }
        
        do {
            try request.encode(with: parametersEncoding)
        } catch {
            throw error
        }
        
        return request
    }
    
    var request: URLRequest {
        do {
            return try buildURLRequest()
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    var debugDescription: String {
        let req = request
        let url = req.url!.absoluteString
        let headers = req.allHTTPHeaderFields
        let body = req.httpBody?.debugDescription
        let params = parametersEncoding.debugDescription

        let debugString = """
        ============= 🔎 Request Info =============
        
        \(method.debugDescription): \(url)
        
        Headers:            \(headers?.debugDescription ?? "--No headers--")
        Body:               \(body ?? "--No data--")
        Parameters:         \(params)

        ===========================================
        """
        
        return debugString
    }
}
