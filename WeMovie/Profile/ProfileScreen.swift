//
//  ProfileScreen.swift
//  WeMovie
//
//  Created by Gabriel Fontenele da Silva on 09/11/24.
//

import UIKit

class ProfileScreen: UIView {
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(type:OrderTableViewCell.self)
        tableView.separatorStyle = .none
        tableView.backgroundColor = .yellow
        return tableView
    }()
    
    public func configTableViewDelegate(delegate: UITableViewDelegate, dataSource: UITableViewDataSource){
        self.tableView.delegate = delegate
        self.tableView.dataSource = dataSource
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupBackgroundColor()
        setupLayout()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupBackgroundColor(){
        self.backgroundColor = .primaryBackground
    }
    
    private func setupLayout(){
        self.addSubview(self.tableView)
    }
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            self.tableView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            self.tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
}
