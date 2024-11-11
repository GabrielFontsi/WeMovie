//
//  PerfilScreen.swift
//  WeMovie
//
//  Created by Gabriel Fontenele da Silva on 09/11/24.
//

import UIKit

class MenuScreen: UIView {
    
    lazy var imagePerfilUIimageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.backgroundColor = .white
        image.contentMode = .scaleAspectFit
        image.layer.cornerRadius = 60
        image.layer.masksToBounds = true
        return image
    }()
    
    lazy var emailLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.textColor = .white
        label.text = "Wemovie@movie.com"
        return label
    }()
    
    lazy var quantidadeFilmesFavoritadosLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = .white
        label.text = "Filmes disponíveis 6"
        return label
    }()

    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
        tableView.register(MenuTableViewCell.self, forCellReuseIdentifier: MenuTableViewCell.identifier)
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
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupBackgroundColor(){
        self.backgroundColor = UIColor(named: "primaryBackgroundColor")
    }
    
    private func setupLayout(){
        self.addSubview(self.imagePerfilUIimageView)
        self.addSubview(self.emailLabel)
        self.addSubview(self.quantidadeFilmesFavoritadosLabel)
        self.addSubview(self.tableView)
    }
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            
            self.imagePerfilUIimageView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 18),
            self.imagePerfilUIimageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.imagePerfilUIimageView.widthAnchor.constraint(equalToConstant: 120),
            self.imagePerfilUIimageView.heightAnchor.constraint(equalToConstant: 120),
            
            self.emailLabel.topAnchor.constraint(equalTo: self.imagePerfilUIimageView.bottomAnchor, constant: 12),
            self.emailLabel.centerXAnchor.constraint(equalTo: self.imagePerfilUIimageView.centerXAnchor),
            
            self.quantidadeFilmesFavoritadosLabel.topAnchor.constraint(equalTo: self.emailLabel.bottomAnchor, constant: 2),
            self.quantidadeFilmesFavoritadosLabel.centerXAnchor.constraint(equalTo: self.imagePerfilUIimageView.centerXAnchor),
            
            self.tableView.topAnchor.constraint(equalTo: self.quantidadeFilmesFavoritadosLabel.bottomAnchor, constant: 18),
            self.tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }

}
