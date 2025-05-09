//
//  CartScreen.swift
//  WeMovie
//
//  Created by Gabriel Fontenele da Silva on 08/11/24.
//

import UIKit

class CartScreen: UIView {
    var didTapHomeButton: (() -> Void)?
    
    lazy var emptyCartScreen: EmptyCartScreen = {
        let view = EmptyCartScreen()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var successScreen: SuccessScreen = {
        let view = SuccessScreen()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var cartLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Carrinho de compra"
        label.textColor = .white
        label.font = UIFont(name: "OpenSans-Bold" , size:20 )
        return label
    }()

    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(type: SelectedMovieTableViewCell.self)
        tableView.register(type: CartTotalTableViewCell.self)
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        return tableView
    }()
    
    public func configTableViewDelegate(delegate: UITableViewDelegate, dataSource: UITableViewDataSource){
        self.tableView.delegate = delegate
        self.tableView.dataSource = dataSource
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupBackgroundColor()
        self.setupLayout()
        self.setupConstraints()
        emptyCartScreen.didTapHomeButton = { [weak self] in
            self?.didTapHomeButton?()
        }
        successScreen.didTapHomeButton = { [weak self] in
            self?.didTapHomeButton?()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupBackgroundColor(){
        self.backgroundColor = .secundaryBackground
    }
    
    private func setupLayout(){
        self.addSubview(self.cartLabel)
        self.addSubview(self.tableView)
    }
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            self.cartLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 24),
            self.cartLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24),
            
            self.tableView.topAnchor.constraint(equalTo: self.cartLabel.bottomAnchor, constant: 24),
            self.tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            self.tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            self.tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }

    func displayEmptyCartScreen() {
        addSubview(emptyCartScreen)
        NSLayoutConstraint.activate([
            self.emptyCartScreen.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            self.emptyCartScreen.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.emptyCartScreen.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.emptyCartScreen.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }

    func displaySuccessScreen() {
        addSubview(successScreen)
        NSLayoutConstraint.activate([
            self.successScreen.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            self.successScreen.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.successScreen.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.successScreen.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }

    func hideEmptyCartScreen() {
        emptyCartScreen.removeFromSuperview()
    }

    func hideSuccessScreen() {
        successScreen.removeFromSuperview()
    }
}
