//
//  Login & Congregation.swift
//  Territorios
//
//  Created by Jose Blanco on 12/30/22.
//

import Foundation

struct Login: Codable {
    let id: String
    let password: String
}

struct Congregation: Codable {
    let id: Int
    let name: String
}
