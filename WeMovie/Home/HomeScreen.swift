//
//  HomeScreen.swift
//  WeMovie
//
//  Created by Gabriel Fontenele da Silva on 07/11/24.
//

import UIKit

class HomeScreen: UIView {
    var didTapReloadButton: (() -> Void)?

    private lazy var failureScreen: ReloadPageScreen = {
        let view = ReloadPageScreen()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var bestSellersLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Mais vendidos"
        label.textColor = .white
        label.font = UIFont(name: "OpenSans-Bold" , size:20 )
       
        return label
    }()
    
    lazy var bestSellersMsgLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Maiores sucessos do WeMovies"
        label.font = UIFont(name: "OpenSans-Regular" , size:12 )
        label.textColor = .white
        return label
    }()

    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(type:MovieTableViewCell.self)
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
        failureScreen.didTapReloadButton = { [weak self] in
            self?.failureScreen.removeFromSuperview()
            self?.didTapReloadButton?()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupBackgroundColor(){
        self.backgroundColor = UIColor(named: "primaryBackgroundColor")
    }
    
    private func setupLayout(){
        self.addSubview(self.bestSellersLabel)
        self.addSubview(self.bestSellersMsgLabel)
        self.addSubview(self.tableView)
    }
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            self.bestSellersLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 24),
            self.bestSellersLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 12),
            self.bestSellersMsgLabel.topAnchor.constraint(equalTo: self.bestSellersLabel.bottomAnchor),
            self.bestSellersMsgLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 12),
            
            self.tableView.topAnchor.constraint(equalTo: self.bestSellersLabel.bottomAnchor, constant: 24),
            self.tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }

    func displayFailureScreen() {
        addSubview(failureScreen)
        NSLayoutConstraint.activate([
            self.failureScreen.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            self.failureScreen.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.failureScreen.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.failureScreen.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}
