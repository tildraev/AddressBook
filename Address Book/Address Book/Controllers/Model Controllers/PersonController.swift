//
//  PersonController.swift
//  Address Book
//
//  Created by Arian Mohajer on 1/24/22.
//

import Foundation

class PersonController {
    // MARK: - CRUD Functions
    static func createPerson(name: String = "New Contact", address: String = "", group: Group) {
        let person = Person(name: name, address: address)
        group.people.append(person)
    }
    
    static func updatePerson(person: Person, name: String, address: String) {
        person.name = name
        person.address = address
    }
    
    static func deletePerson(person: Person, group: Group) {
        guard let index = group.people.firstIndex(of: person) else { return }
        group.people.remove(at: index)
    }
}
