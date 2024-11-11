//
//  CartViewModel.swift
//  WeMovie
//
//  Created by Gabriel Fontenele da Silva on 09/11/24.
//

import Foundation

protocol CartViewModelProtocol {
    func addMovie(_ movie: Movie)
    func removeMovie(_ movie: Movie)
    func decreaseMovie(_ movie: Movie)
    func getItems() -> [CartItem]
    func finishOrder()
    func cartTotal() -> String
}

class CartViewModel: CartViewModelProtocol {
    private let cartManager: CartManagerProtocol
    private let profileService: ProfileServiceProtocol

    init(
        cartManager: CartManagerProtocol,
        profileService: ProfileServiceProtocol
    ) {
        self.cartManager = cartManager
        self.profileService = profileService
    }

    func addMovie(_ movie: Movie) {
        cartManager.addMovie(movie)
    }

    func removeMovie(_ movie: Movie) {
        cartManager.removeMovie(movie)
    }

    func decreaseMovie(_ movie: Movie) {
        cartManager.decreaseMovie(movie)
    }

    func getItems() -> [CartItem] {
        cartManager.cartItems
    }

    func finishOrder() {
        let items = cartManager.cartItems
        profileService.finishOrder(cartItems: items)
        cartManager.removeAll()
    }

    func cartTotal() -> String {
        var cartTotal: Double = 0
        cartManager.cartItems.forEach { item in
            cartTotal += item.movie.price * Double(item.amount)
        }
        return "R$ \(cartTotal)"
    }
}
