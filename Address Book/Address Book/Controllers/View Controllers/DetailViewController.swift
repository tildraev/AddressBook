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
    @IBOutlet weak var isFavoriteButton: UIButton!
    
    var isFavorite = false
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        updateUI()
    }
    
    func updateUI() {
        if let person = person {
            nameTextField.text = person.name
            addressTextField.text = person.address
            updateFavoriteButton()
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
            PersonController.createPerson(name: name, address: address, group: group, isFavorite: self.isFavorite)
            self.navigationController?.popViewController(animated: true)
        }
    }

    @IBAction func isFavoriteButtonTapped(_ sender: Any) {
        if let person = person {
            PersonController.toggleFavorite(person: person)
            updateFavoriteButton()
        } else {
            isFavorite.toggle()
            updateFavoriteButton()
        }
    }
    
    
    func updateFavoriteButton() {
        //guard let person = person else { return }
        if let person = person {
            let favoriteImageName = person.isFavorite ? "star.fill" : "star"
            let favoriteImage = UIImage(systemName: favoriteImageName)
            isFavoriteButton.setImage(favoriteImage, for: .normal)
        } else {
            let favoriteImageName = isFavorite ? "star.fill" : "star"
            let favoriteImage = UIImage(systemName: favoriteImageName)
            isFavoriteButton.setImage(favoriteImage, for: .normal)
        }
    }
}
