//
//  NetworkClient.swift
//  Example
//
//  Created by Lukasz Szarkowicz on 10/09/2021.
//  Copyright © 2021 Mobilee. All rights reserved.
//

import Foundation
import Netify

class NetworkClient {
    static private var client: AlamofireClient = AlamofireClient()
    
    static func checkName(name: String, completion: @escaping GenderizerEndpoint.Completion) {
        let endpoint = GenderizerEndpoint(name: name)
        client.executeRequest(route: endpoint, completion: completion)
    }
}
