//
//  GenderizerAPI.swift
//  Example
//
//  Created by Lukasz Szarkowicz on 10/09/2021.
//  Copyright © 2021 Mobilee. All rights reserved.
//

import Foundation
import Netify

class GenderizerAPI: API {
    var baseURL: String = "https://api.genderize.io"
    var apiHeaders: HTTPHeaders? = nil
    var modifiers: [RequestModifier]? = nil
}
