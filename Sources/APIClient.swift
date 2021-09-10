//
//  APIClient.swift
//  Netify
//
//  Created by Łukasz Szarkowicz on 10.09.2021.
//  Copyright © 2021 Mobilee. All rights reserved.
//

import Foundation

/// APIClient should be a class.
public protocol APIClient: AnyObject {
    var decoder: JSONDecoder { get }
    var queue: DispatchQueue { get }
    static var queueName: String { get }
    
}
