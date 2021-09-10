//
//  KeyPathPreprocessor.swift
//  Netify
//
//  Created by Łukasz Szarkowicz on 10.09.2021.
//  Copyright © 2021 Mobilee. All rights reserved.
//

import Alamofire
import Foundation

/// `DataPreprocessor` that returns `Data` at given keyPath
public struct KeyPathPresprocessor: DataPreprocessor {
    
    var keyPath: String
    
    public init(keyPath: String) {
        self.keyPath = keyPath
    }
    
    public func preprocess(_ data: Data) throws -> Data {
        guard keyPath.isEmpty == false else {
            throw JSONSerializationError.emptyKeyPath
        }
        
        do {
            return try data.nestedJson(with: keyPath)
        } catch {
            throw error
        }
    }
}
