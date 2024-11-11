//
//  OrderTableViewCell.swift
//  WeMovie
//
//  Created by Gabriel Fontenele da Silva on 09/11/24.
//

import UIKit

class OrderTableViewCell: UITableViewCell {
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var testeLabel: UILabel!
    
    var order: Order? {
        didSet {
            guard let order else {return}
            dateLabel.text = order.price
            testeLabel.text = order.date.formatDate()
            priceLabel.text = "\(order.items.count)"
        }
    }
    
}
