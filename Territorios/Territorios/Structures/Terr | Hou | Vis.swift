//
//  Structures.swift
//  Territorios
//
//  Created by Jose Blanco on 12/30/22.
//

import Foundation

struct Territory: Codable, Identifiable, Hashable {
    
    var id: String
    var congregation: Int64
    var number: Int
    var address: String
    var image: String?
    var created_at: String?
    var updated_at: String?
    
    func getId() -> String {
        return "\(congregation)-\(number)"
    }
    
    func equals(other: Territory) -> Bool {
        return ((id == other.id) && (congregation == other.congregation) && (number == other.number) && (address == other.address) && (image == other.image))
    }
}

struct House: Codable, Identifiable, Hashable{
    var id: String
    var territory: String
    var number: String
    var phone: String?
    var language: String?
    var created_at: String?
    var updated_at: String?
    
    func getId() -> String {
        return "\(territory)-\(number)"
    }
    
    func equals(other: House) -> Bool {
        return ((id == other.id) && (territory == other.territory) && (number == other.number) && (phone == other.phone) && (language == other.language))
    }
}

struct Visit: Codable, Identifiable, Hashable {
    
    var id: String
    var house: String
    var date: Int64
    var notes: String
    var by_phone: Bool
    var created_at: String?
    var updated_at: String?
    
    
    func getId() -> String {
        return "\(house)-\(date)"
    }
    
    func equals(other: Visit) -> Bool {
        return ((id == other.id) && (house == other.house) && (date == other.date) && (notes == other.notes) && (by_phone == other.by_phone))
    }
}


