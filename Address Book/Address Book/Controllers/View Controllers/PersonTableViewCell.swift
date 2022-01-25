//
//  PersonTableViewCell.swift
//  Address Book
//
//  Created by Arian Mohajer on 1/25/22.
//

import UIKit

protocol PersonTableViewCellDelegate: AnyObject {
    func toggleFavoriteButtonWasTapped(cell: PersonTableViewCell)
}

class PersonTableViewCell: UITableViewCell {
    
    weak var delegate: PersonTableViewCellDelegate?
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var isFavoriteButton: UIButton!
    
    var person: Person? {
        didSet {
            updateView()
        }
    }
    
    func updateView() {
        guard let person = person else { return }
        nameLabel.text = person.name
        let favoriteImageString = person.isFavorite ? "star.fill" : "star"
        let favoriteImage = UIImage(systemName: favoriteImageString)
        isFavoriteButton.setImage(favoriteImage, for: .normal)
    }
    
    @IBAction func isFavoriteButtonTapped(_ sender: Any) {
        delegate?.toggleFavoriteButtonWasTapped(cell: self)
    }
}
