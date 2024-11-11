//
//  CartTotalTableViewCell.swift
//  WeMovie
//
//  Created by Gabriel Fontenele da Silva on 07/11/24.
//

import UIKit

protocol CartTotalTableViewCellDelegate {
    func finishOrder()
}

class CartTotalTableViewCell: UITableViewCell {
    var delegate: CartTotalTableViewCellDelegate?
    
    @IBOutlet weak var finishOrderButton: UIButton!
    
    @IBOutlet weak var moneyLabel: UILabel!
    @IBAction func finishOrder(_ sender: Any) {
        delegate?.finishOrder()
    }
}
