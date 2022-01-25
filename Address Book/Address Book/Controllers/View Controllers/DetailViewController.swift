//
//  DetailViewController.swift
//  Address Book
//
//  Created by Arian Mohajer on 1/24/22.
//

import UIKit

class DetailViewController: UIViewController {

    // MARK: - Properties
    var person: Person?
    var group: Group?
    
    // MARK: - IBOutlets
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        updateUI()
    }
    
    func updateUI() {
        if let person = person {
            nameTextField.text = person.name
            addressTextField.text = person.address
        }
    }
    
    // MARK: - IBActions
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let name = nameTextField.text, !name.isEmpty,
              let address = addressTextField.text, !address.isEmpty,
              let group = group else { return }
        
        if let person = person {
            //Person exists, update
            PersonController.updatePerson(person: person, name: name, address: address)
            self.navigationController?.popViewController(animated: true)
        }
        else {
            //Person doesn't exist, create
            PersonController.createPerson(name: name, address: address, group: group)
            self.navigationController?.popViewController(animated: true)
        }
    }
    
}
