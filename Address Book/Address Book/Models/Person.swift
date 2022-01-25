//
//  Person.swift
//  Address Book
//
//  Created by Arian Mohajer on 1/24/22.
//

import Foundation

class Person: Codable {
    let id: UUID
    var name: String
    var address: String
    static var isFavorite: Bool = false
    
    init(id: UUID = UUID(), name: String, address: String) {
        self.id = id
        self.name = name
        self.address = address
    }
}

extension Person: Equatable {
    static func == (lhs: Person, rhs: Person) -> Bool {
        lhs.name == rhs.name &&
        lhs.address == rhs.address &&
        lhs.id == rhs.id
    }
}
