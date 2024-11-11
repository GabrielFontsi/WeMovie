//
//  CartManager.swift
//  WeMovie
//
//  Created by Gabriel Fontenele da Silva on 08/11/24.
//

import Foundation

extension NSNotification.Name {
    static let cartUpdate = Notification.Name("cartUpdate")
}

protocol CartManagerProtocol {
    var cartItems: [CartItem] { get }
    func addMovie(_ movie: Movie)
    func removeMovie(_ movie: Movie)
    func decreaseMovie(_ movie: Movie)
    func getExistingCartItem(by movie: Movie) -> CartItem?
    func removeAll()
}

class CartManager: CartManagerProtocol {
    var cartItems = [CartItem]()
    private let notificationCenter: NotificationCenter
    init(notificationCenter: NotificationCenter = .default) {
        self.notificationCenter = notificationCenter
    }

    func addMovie(_ movie: Movie) {
        if let existingItem = getExistingCartItem(by: movie) {
            existingItem.amount += 1
        } else {
            cartItems.append(CartItem(movie: movie, amount: 1, date: Date().description))
        }
        notificationCenter.post(name: .cartUpdate, object: nil)
    }

    func removeMovie(_ movie: Movie) {
        cartItems.removeAll(where: { $0.movie.id == movie.id })
        notificationCenter.post(name: .cartUpdate, object: nil)
    }

    func decreaseMovie(_ movie: Movie) {
        if let existingItem = getExistingCartItem(by: movie) {
            if existingItem.amount == 1 {
                removeMovie(movie)
            } else {
                existingItem.amount -= 1
            }
            notificationCenter.post(name: .cartUpdate, object: nil)
        }
    }

    func getExistingCartItem(by movie: Movie) -> CartItem? {
        cartItems.first(where: { $0.movie.id == movie.id })
    }

    func removeAll() {
        cartItems = []
        notificationCenter.post(name: .cartUpdate, object: nil)
    }
}
