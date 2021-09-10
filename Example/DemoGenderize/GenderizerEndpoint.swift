//
//  GenderizerEndpoint.swift
//  Example
//
//  Created by Lukasz Szarkowicz on 10/09/2021.
//  Copyright © 2021 Mobilee. All rights reserved.
//

import Foundation
import Netify

class GenderizerEndpoint: Endpoint {
    var path: String = ""
    var headers: HTTPHeaders? = nil
    var keyPath: String? = nil
    var api: API = GenderizerAPI()
    var parametersEncoding: ParameterEncoding
    typealias Model = GenderResponseDTO
    
    init(name: String) {
        parametersEncoding = .urlEncoding(urlParameters: ["name": name])
    }
}
