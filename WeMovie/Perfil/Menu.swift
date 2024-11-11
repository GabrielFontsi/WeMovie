//
//  Menu.swift
//  WeMovie
//
//  Created by Gabriel Fontenele da Silva on 09/11/24.
//

import Foundation
import UIKit

struct Menu {
    let id: Int
    let title: String
    let icon: String
}

let listMenu: [Menu] = [
Menu(id: 1, title: "Conta", icon: "perfil"),
Menu(id: 2, title: "WeMovie", icon: "coracao"),
Menu(id: 3, title: "Sair", icon: "sair"),
]
