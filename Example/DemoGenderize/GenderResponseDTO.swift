//
//  GenderResponseDTO.swift
//  Example
//
//  Created by Lukasz Szarkowicz on 10/09/2021.
//  Copyright © 2021 Mobilee. All rights reserved.
//

import Foundation

struct GenderResponseDTO: Decodable {
    
    var name: String
    var gender: String
    var probability: Float
    var count: Int

}
