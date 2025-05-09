//
//  MovieTableViewCell.swift
//  WeMovie
//
//  Created by Gabriel Fontenele da Silva on 07/11/24.
//

import UIKit
import Kingfisher

protocol MovieTableViewCellDelegate: AnyObject {
    func didTapAddToCartButton(movie: Movie)
}

class MovieTableViewCell: UITableViewCell {
    
    weak var delegate: MovieTableViewCellDelegate?
    
    @IBOutlet weak var backgroundColorContentView: UIView!
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var titleMovieLabel: UILabel!
    @IBOutlet weak var priceMovieLabel: UILabel!
    @IBOutlet weak var addToCartButton: UIButton!

    var movie: Movie? {
        didSet {
            guard let movie else { return }
            titleMovieLabel.text = movie.title
            priceMovieLabel.text = "R$ \(movie.price)".replaceDotWithComma()
            if let imageURL = URL(string: movie.image) {
                movieImageView.kf.setImage(with: imageURL)
            }
        }
    }

    var amountInCart: Int = 0 {
        didSet {
            addToCartButton.setTitle(" \(amountInCart) ADICIONAR AO CARRINHO", for: .normal)
            if amountInCart > 0 {
                addToCartButton.backgroundColor = .sucundaryButton
            } else {
                addToCartButton.backgroundColor = .primaryButton
            }
        }
    }

    @IBAction func addToCartButtonTapped(_ sender: UIButton) {
        if let movie {
            delegate?.didTapAddToCartButton(movie: movie)
        }
    }
}
