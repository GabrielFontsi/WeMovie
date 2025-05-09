//
//  MenuTableViewCell.swift
//  WeMovie
//
//  Created by Gabriel Fontenele da Silva on 09/11/24.
//

import UIKit

class MenuTableViewCell: UITableViewCell {

    static let identifier: String = String(describing: MenuTableViewCell.self)
    
    lazy var menuCellScreen = {
        let view = MenuCellScreen()
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupLayout()
        self.setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout(){
        self.contentView.addSubview(self.menuCellScreen)
    }
    
    public func configurationCell(menu: Menu) {
        self.menuCellScreen.iconImageView.image = UIImage(systemName: menu.icon)
        self.menuCellScreen.nameIconLabel.text = menu.title
    }
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            self.menuCellScreen.topAnchor.constraint(equalTo: self.topAnchor),
            self.menuCellScreen.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.menuCellScreen.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.menuCellScreen.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
    }

    
}
