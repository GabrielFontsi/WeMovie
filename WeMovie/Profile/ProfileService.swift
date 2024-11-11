//
//  ProfileService.swift
//  WeMovie
//
//  Created by Gabriel Fontenele da Silva on 09/11/24.
//

import Foundation

protocol ProfileServiceProtocol {
    var orders: [Order] { get }
    func finishOrder(cartItems: [CartItem])
}

class ProfileService: ProfileServiceProtocol {
    var orders = [Order]()

    func finishOrder(cartItems: [CartItem]) {
        var cartTotal: Double = 0
        cartItems.forEach { item in
            cartTotal += item.movie.price * Double(item.amount)
        }
        let order = Order(
            items: cartItems,
            date: Date().description,
            price: "R$ \(cartTotal)"
        )
        orders.append(order)
    }
}
