//
//  SelectedMovieTableViewCell.swift
//  WeMovie
//
//  Created by Gabriel Fontenele da Silva on 08/11/24.
//

import UIKit
import Kingfisher

protocol SelectedMovieTableViewCellDelegate {
    func removeItem(_ cartItem: CartItem)
    func increaseItem(_ cartItem: CartItem)
    func decreaseItem(_ cartItem: CartItem)
}

class SelectedMovieTableViewCell: UITableViewCell {
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var titleMovieLabel: UILabel!
    @IBOutlet weak var dateMovieLabel: UILabel!
    @IBOutlet weak var quantityMovieLabel: UITextField!
    @IBOutlet weak var subTotalLabel: UILabel!

    var delegate: SelectedMovieTableViewCellDelegate?

    var item: CartItem? {
        didSet {
            guard let item else { return }
            titleMovieLabel.text = item.movie.title
            if let date = item.date.formatDate() {
                dateMovieLabel.text = "Adicionado em \(date)"
            }
           
            
            quantityMovieLabel.text = "\(item.amount)"
            subTotalLabel.text = "R$ \(item.movie.price * Double(item.amount))".formatToTwoDecimalPlaces().replaceDotWithComma()
            if let imageURL = URL(string: item.movie.image) {
                movieImageView.kf.setImage(with: imageURL)
            }
        }
    }

    @IBAction func removeItem(_ sender: Any) {
        guard let item else { return }
        delegate?.removeItem(item)
    }

    @IBAction func increaseItem(_ sender: Any) {
        guard let item else { return }
        delegate?.increaseItem(item)
    }

    @IBAction func decreaseItem(_ sender: Any) {
        guard let item else { return }
        delegate?.decreaseItem(item)
    }
}
