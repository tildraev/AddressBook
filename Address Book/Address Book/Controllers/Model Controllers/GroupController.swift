//
//  GroupController.swift
//  Address Book
//
//  Created by Arian Mohajer on 1/24/22.
//

import Foundation

class GroupController {
    // MARK: - Properties
    static var sharedInstance = GroupController()
    var groups: [Group] = []
    
    // MARK: - Initializers
    init() {
        loadContactsFromDisk()
    }
    
    // MARK: - CRUD Functions
    func createGroup(name: String = "Untitled Group", people: [Person] = []) {
        let group = Group(name: name, people: people)
        groups.append(group)
        saveContactsToDisk()
    }
    
    func updateGroup(group: Group, name: String, people: [Person]) {
        group.name = name
        group.people = people
        saveContactsToDisk()
    }
    
    func deleteGroup(group: Group) {
        guard let index = groups.firstIndex(of: group) else { return }
        groups.remove(at: index)
        saveContactsToDisk()
    }
    
    func saveContactsToDisk() {
        //URL
        guard let url = fileURL else { return }
        do {
            //Encode
            let data = try JSONEncoder().encode(groups)
            //Save the data to the address
            try data.write(to: url)
        } catch {
            print(error)
        }
        //Save data
    }
    
    func loadContactsFromDisk() {
        //URL
        guard let url = fileURL else { return }
        do {
            //Retrieve data
            let data = try Data(contentsOf: url)
            //Translate (or decode) the data
            let groups = try JSONDecoder().decode([Group].self, from: data)
            self.groups = groups

        } catch {
            print(error)
        }
    }
    
    private var fileURL: URL? {
        //Computed property
        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        let url = documentsDirectory.appendingPathComponent("addressbook.json")
        return url
    }
}
