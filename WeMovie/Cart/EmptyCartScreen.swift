//
//  EmptyCartScreen.swift
//  WeMovie
//
//  Created by Gabriel Fontenele da Silva on 09/11/24.
//

import UIKit

class EmptyCartScreen: UIView {
    var didTapHomeButton: (() -> Void)?
    
    private lazy var cartLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Carrinho de compras"
        label.font = UIFont(name: "OpenSans-Bold", size: 20)
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 0
        
        return label
    }()

    private lazy var backgroundColorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 4
        return view
    }()
    
    private lazy var emptyLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = AppMessages.emptyCart
        label.font = UIFont(name: "OpenSans-Bold", size: 20)
        label.tintColor = UIColor(named: "textColor")
        label.textAlignment = .center
        label.numberOfLines = 0
        
        return label
    }()
    
    private lazy var imageRefreshImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "home")
        return image
    }()
    
    private lazy var refreshButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .primaryButton
        button.setTitle(AppMessages.backHome, for: .normal)
        button.titleLabel?.font = UIFont(name: "OpenSans-Bold", size: 12)
        button.layer.cornerRadius = 4
        button.addTarget(self, action: #selector(handleHomeButton), for: .touchUpInside)
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupBackgroundColor()
        self.setupLayout()
        self.setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupBackgroundColor(){
        self.backgroundColor = .secundaryBackground
    }
    
    private func setupLayout(){
        self.addSubview(self.cartLabel)
        self.addSubview(self.backgroundColorView)
        self.backgroundColorView.addSubview(self.emptyLabel)
        self.backgroundColorView.addSubview(self.imageRefreshImageView)
        self.backgroundColorView.addSubview(self.refreshButton)
    }
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            self.cartLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 24),
            self.cartLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24),
            
            self.backgroundColorView.topAnchor.constraint(equalTo: self.cartLabel.bottomAnchor, constant: 24),
            self.backgroundColorView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24),
            self.backgroundColorView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -24),
            self.backgroundColorView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -24),
            
            self.emptyLabel.topAnchor.constraint(equalTo: self.backgroundColorView.topAnchor, constant: 24),
            self.emptyLabel.leadingAnchor.constraint(equalTo: self.backgroundColorView.leadingAnchor, constant: 24),
            self.emptyLabel.trailingAnchor.constraint(equalTo: self.backgroundColorView.trailingAnchor, constant: -24),
            
            self.imageRefreshImageView.topAnchor.constraint(equalTo: self.emptyLabel.bottomAnchor, constant: 24),
            self.imageRefreshImageView.heightAnchor.constraint(equalToConstant: 343),
            self.imageRefreshImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
        
            self.refreshButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.refreshButton.bottomAnchor.constraint(equalTo: self.backgroundColorView.bottomAnchor, constant: -24),
            self.refreshButton.heightAnchor.constraint(equalToConstant: 40),
            self.refreshButton.widthAnchor.constraint(equalToConstant: 173)

        ])
    }

    @objc private func handleHomeButton() {
        didTapHomeButton?()
    }
}
