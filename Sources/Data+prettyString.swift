//
//  Data+prettyString.swift
//  Netify
//
//  Created by Łukasz Szarkowicz on 10.09.2021.
//  Copyright © 2021 Mobilee. All rights reserved.
//

import Foundation

extension Data {
    
    var prettyString: NSString? {
        // Must use NSString instead of String for better text formating -- to ommit backslashes.
        return NSString(data: self, encoding: String.Encoding.utf8.rawValue)
    }
}
