//
//  Types.swift
//  Netify
//
//  Created by Lukasz Szarkowicz on 10/09/2021.
//  Copyright © 2021 Mobilee. All rights reserved.
//

import Foundation

public struct EmptyResult: Codable {}
public typealias HTTPHeaders = [String: String]
public typealias RequestParameters = [String: Any]

public typealias NetworkCompletion<T> = (_ result: Result<T, Error>) -> Void
public typealias EmptyCompletion = NetworkCompletion<EmptyResult>
