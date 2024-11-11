//
//  Movie.swift
//  WeMovie
//
//  Created by Gabriel Fontenele da Silva on 08/11/24.
//

import Foundation

struct Movie: Decodable {
    let id: Int
    let title: String
    let price: Double
    let image: String
}

struct MovieResponse: Decodable {
    let products: [Movie]
}
