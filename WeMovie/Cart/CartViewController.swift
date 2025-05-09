//
//  CartViewController.swift
//  WeMovie
//
//  Created by Gabriel Fontenele da Silva on 07/11/24.
//

import UIKit

class CartViewController: UIViewController {
    private let cartScreen = CartScreen()
    private let viewModel: CartViewModel
    var items: [CartItem] = []

    init(viewModel: CartViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        self.view = cartScreen
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        self.cartScreen.configTableViewDelegate(delegate: self, dataSource: self)
        cartScreen.didTapHomeButton = { [weak self] in
            self?.tabBarController?.selectedIndex = 1
            self?.tabBarController?.view.setNeedsLayout()
            self?.tabBarController?.view.layoutIfNeeded()
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setItems()
    }
    
    func setItems() {
        items = viewModel.getItems()
        if items.count == 0 {
            cartScreen.displayEmptyCartScreen()
        } else {
            cartScreen.hideSuccessScreen()
            cartScreen.hideEmptyCartScreen()
            cartScreen.tableView.reloadData()
        }
    }
    
    func setupNavigationBar() {
        navigationItem.title = AppMessages.titleNavigation
      
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .primaryBackground
        
        if let customFont = UIFont(name: "OpenSans-Bold", size: 20) {
            appearance.titleTextAttributes = [
                .foregroundColor: UIColor.white,
                .font: customFont
            ]
        } else {
            appearance.titleTextAttributes = [
                .foregroundColor: UIColor.white,
                .font: UIFont.systemFont(ofSize: 20)
            ]
        }

        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
    }
}

extension CartViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return items.count > 0 ? 2 : 0
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return items.count
        } else {
            return 1
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell: SelectedMovieTableViewCell = tableView.dequeueReusableCell(for: indexPath)
            cell.item = items[indexPath.row]
            cell.selectionStyle = .none
            cell.delegate = self
            return cell
        } else {
            let cell: CartTotalTableViewCell = tableView.dequeueReusableCell(for: indexPath)
            cell.moneyLabel.text = viewModel.cartTotal().replaceDotWithComma()
            cell.selectionStyle = .none
            cell.delegate = self
            return cell
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 140
        } else {
            return 100
        }
    }
}

extension CartViewController: SelectedMovieTableViewCellDelegate {
    func removeItem(_ cartItem: CartItem) {
        viewModel.removeMovie(cartItem.movie)
        setItems()
    }
    
    func increaseItem(_ cartItem: CartItem) {
        viewModel.addMovie(cartItem.movie)
        setItems()
    }
    
    func decreaseItem(_ cartItem: CartItem) {
        viewModel.decreaseMovie(cartItem.movie)
        setItems()
    }
}

extension CartViewController: CartTotalTableViewCellDelegate {
    func finishOrder() {
        viewModel.finishOrder()
        cartScreen.displaySuccessScreen()
    }
}
