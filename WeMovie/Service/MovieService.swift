//
//  MovieService.swift
//  WeMovie
//
//  Created by Gabriel Fontenele da Silva on 08/11/24.
//

import Foundation

protocol MovieService {
    func fetchMovies(completion: @escaping (Result<[Movie], Error>) -> Void)
}

class MovieServiceImpl: MovieService {
    private let urlSession: URLSession
    init(urlSession: URLSession = .shared) {
        self.urlSession = urlSession
    }

    enum MovieServiceError: Error {
        case invalidURL
        case failResponse
    }
    func fetchMovies(completion: @escaping (Result<[Movie], Error>) -> Void) {
        guard let url = URL(string: "https://wefit-movies.vercel.app/api/movies") else {
            completion(.failure(MovieServiceError.invalidURL))
            return
        }
        let task = urlSession.dataTask(with: url) { data, response, error in
          if let error = error {
              completion(.failure(error))
          } else if let data = data, let response = response as? HTTPURLResponse {
            if response.statusCode == 200 {
                do {
                    let response = try JSONDecoder().decode(MovieResponse.self, from: data)
                    completion(.success(response.products))
                } catch {
                    completion(.failure(error))
                }
            } else {
                completion(.failure(MovieServiceError.failResponse))
            }
          }
        }
        task.resume()
    }
}
