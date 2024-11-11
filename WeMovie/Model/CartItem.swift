//
//  CartItem.swift
//  WeMovie
//
//  Created by Gabriel Fontenele da Silva on 09/11/24.
//

import Foundation

class CartItem {
    let movie: Movie
    var amount: Int
    let date: String

    init(movie: Movie, amount: Int, date: String) {
        self.movie = movie
        self.amount = amount
        self.date = date
    }
}
