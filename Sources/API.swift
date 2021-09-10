//
//  API.swift
//  Netify
//
//  Created by Lukasz Szarkowicz on 10.09.2021.
//  Copyright © 2021 Mobilee. All rights reserved.
//

import Foundation

/**
 Interface for API object. It describe server main information to connect.

 - Author: Mobilee - Łukasz Szarkowicz
 */
public protocol API {

    /**
     Base URL of server. It's used to connect with API.
     */
    var baseURL: String { get }
    /**
     Common headers for entire API
     */
    var apiHeaders: HTTPHeaders? { get }
    /**
     Common modifiers for entire API. You can use modifire for changing Requests globally. F.ex. use it for authentication with Bearer Token.
     */
    var modifiers: [RequestModifier]? { get }

    /**
     Common error handler. If this handler handle error, returns *true*. Then failure block of particular endpoint won't be executed.
     
     Use it for global error handling, like logout when unauthorize.
     
     - parameter error: Information about error causing execution of this handler
     
     - returns: true if default error handler handled error.
     */
    static var defaultErrorHandler: ((_ error: Error) -> Bool)? { get }
}

public extension API {
    
    var url: URL {
        guard let computed = URL(string: baseURL) else { fatalError("Conversion of baseURL \(baseURL) to URL failed.") }
        return computed
    }
    
    static var defaultErrorHandler: ((_ error: Error) -> Bool)? {
        return nil
    }
}
