//
//  HomeViewModel.swift
//  WeMovie
//
//  Created by Gabriel Fontenele da Silva on 08/11/24.
//

import Foundation

protocol HomeViewModelDelegate {
    func didFetchMovies(_ movies: [Movie])
    func failedFetchingMovies()
    func displayLoading()
    func hideLoading()
    func handleCartUpdate()
}

protocol HomeViewModelProtocol {
    var delegate: HomeViewModelDelegate? { get set }
    func fetchMovies()
    func addMovieToCart(_ movie: Movie)
}

class HomeViewModel: HomeViewModelProtocol {
    var delegate: HomeViewModelDelegate?
    private let movieService: MovieService
    private let cartManager: CartManagerProtocol
    private let notificationCenter: NotificationCenter

    init(
        movieService: MovieService,
        cartManager: CartManagerProtocol,
        notificationCenter: NotificationCenter = .default
    ) {
        self.movieService = movieService
        self.cartManager = cartManager
        self.notificationCenter = notificationCenter

        notificationCenter.addObserver(self, selector: #selector(handleCartUpdate), name: .cartUpdate, object: nil)
    }

    func addMovieToCart(_ movie: Movie) {
        cartManager.addMovie(movie)
    }

    func fetchMovies() {
        delegate?.displayLoading()
        movieService.fetchMovies { [weak self] result in
            DispatchQueue.main.async {
                self?.delegate?.hideLoading()
                switch result {
                case .success(let movies):
                    self?.delegate?.didFetchMovies(movies)
                case .failure:
                    self?.delegate?.failedFetchingMovies()
                }
            }
        }
    }

    func getCartAmount(for movie: Movie) -> Int {
        cartManager.getExistingCartItem(by: movie)?.amount ?? 0
    }

    @objc func handleCartUpdate() {
        delegate?.handleCartUpdate()
    }
}
