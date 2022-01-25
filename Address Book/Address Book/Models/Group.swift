//
//  Group.swift
//  Address Book
//
//  Created by Arian Mohajer on 1/24/22.
//

import Foundation

class Group: Codable{
    let id: UUID
    var name: String
    var people: [Person]
    
    init(id: UUID = UUID(), name: String, people: [Person] = []) {
        self.id = id
        self.name = name
        self.people = people
    }
}

extension Group: Equatable {
    static func == (lhs: Group, rhs: Group) -> Bool {
        lhs.people == rhs.people &&
        lhs.id == rhs.id &&
        lhs.name == rhs.name
    }
}
