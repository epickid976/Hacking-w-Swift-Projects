//
//  Structures(T's, H's, V's).swift
//  Territorios
//
//  Created by Jose Blanco on 12/30/22.
//

import Foundation

struct Territories: Codable {
    var results: [Territory]
}

struct Houses: Codable {
    var results: [House]
}

struct Visits: Codable {
    var results: [Visit]
}
