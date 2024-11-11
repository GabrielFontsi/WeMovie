//
//  HomeViewController.swift
//  WeMovie
//
//  Created by Gabriel Fontenele da Silva on 07/11/24.
//

import UIKit

class HomeViewController: UIViewController {
    private let homeScreen = HomeScreen()
    private let viewModel: HomeViewModel

    var movies = [Movie]()

    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        viewModel.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = homeScreen
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        homeScreen.configTableViewDelegate(delegate: self, dataSource: self)
        viewModel.fetchMovies()
        setupReloadButton()
    }

    func setupReloadButton() {
        homeScreen.didTapReloadButton = { [weak self] in
            self?.viewModel.fetchMovies()
        }
    }
    
    func setupNavigationBar() {
        title = "We Movies"
        if let customFont = UIFont(name: "OpenSans-Bold", size: 20) {
                
                navigationController?.navigationBar.titleTextAttributes = [
                    NSAttributedString.Key.foregroundColor: UIColor.white,
                    NSAttributedString.Key.font: customFont
                ]
            } else {
                print("Fonte personalizada não encontrada!")
                navigationController?.navigationBar.titleTextAttributes = [
                    NSAttributedString.Key.foregroundColor: UIColor.white,
                    NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20)
                ]
            }
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: MovieTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        let movie = movies[indexPath.row]
        cell.movie = movie
        cell.amountInCart = viewModel.getCartAmount(for: movie)
        cell.delegate = self
        
        cell.selectionStyle = .none
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 382
    }
}

extension HomeViewController: MovieTableViewCellDelegate {
    func didTapAddToCartButton(movie: Movie) {
        viewModel.addMovieToCart(movie)
    }
}

extension HomeViewController: HomeViewModelDelegate {
    func didFetchMovies(_ movies: [Movie]) {
        self.movies = movies
        homeScreen.tableView.reloadData()
    }

    func failedFetchingMovies() {
        homeScreen.displayFailureScreen()
    }

    func displayLoading() {
        homeScreen.lock()
    }

    func hideLoading() {
        homeScreen.unlock()
    }

    func handleCartUpdate() {
        homeScreen.tableView.reloadData()
    }
}
