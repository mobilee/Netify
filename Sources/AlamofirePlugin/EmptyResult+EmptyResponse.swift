//
//  EmptyResult+EmptyResponse.swift
//  Netify
//
//  Created by Łukasz Szarkowicz on 10.09.2021.
//  Copyright © 2021 Mobilee. All rights reserved.
//

import Alamofire
import Foundation

extension EmptyResult: EmptyResponse {
    public static func emptyValue() -> EmptyResult {
        EmptyResult()
    }
}
