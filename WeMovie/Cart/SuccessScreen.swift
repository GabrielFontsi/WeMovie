//
//  successfullyScreen.swift
//  WeMovie
//
//  Created by Gabriel Fontenele da Silva on 09/11/24.
//

import UIKit

class SuccessScreen: UIView {
    var didTapHomeButton: (() -> Void)?
    private lazy var backgroundColorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 4
        return view
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "OpenSans-Light", size: 12)
        
    
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        let hourString = formatter.string(from: date)
        
        label.text = "Compra realizada em \(Date().description.formatDate() ?? "Data da compra ") às \(hourString) "
        label.tintColor = .darkGray
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var sucessLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "OpenSans-Bold", size: 20)
        label.text = AppMessages.purchaseSuccess
        label.tintColor = .darkGray
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
        
    }()
    
    private lazy var imageRefreshImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "sucess")
        return image
    }()
    
    private lazy var refreshButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .primaryButton
        button.setTitle("Voltar à Home", for: .normal)
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
        self.addSubview(self.backgroundColorView)
        self.backgroundColorView.addSubview(self.dateLabel)
        self.backgroundColorView.addSubview(self.sucessLabel)
        self.backgroundColorView.addSubview(self.imageRefreshImageView)
        self.backgroundColorView.addSubview(self.refreshButton)
    }
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            self.backgroundColorView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 24),
            self.backgroundColorView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24),
            self.backgroundColorView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -24),
            self.backgroundColorView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -24),
            
            self.dateLabel.topAnchor.constraint(equalTo: self.backgroundColorView.topAnchor, constant: 24),
            self.dateLabel.leadingAnchor.constraint(equalTo: self.backgroundColorView.leadingAnchor, constant: 24),
            self.dateLabel.trailingAnchor.constraint(equalTo: self.backgroundColorView.trailingAnchor, constant: -24),
            
            self.sucessLabel.topAnchor.constraint(equalTo: self.dateLabel.bottomAnchor, constant: 4),
            self.sucessLabel.leadingAnchor.constraint(equalTo: self.backgroundColorView.leadingAnchor, constant: 24),
            self.sucessLabel.trailingAnchor.constraint(equalTo: self.backgroundColorView.trailingAnchor, constant: -24),
            
            self.imageRefreshImageView.topAnchor.constraint(equalTo: self.sucessLabel.bottomAnchor, constant: 24),
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
