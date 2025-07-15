//
//  FetchMoviesUseCase.swift
//  TheMoviesApp
//
//  Created by Ahmed Moatasem on 15/07/2025.
//

import Foundation

class FetchMoviesUseCase {
    private let movieRepository: MovieRepositoryProtocol
    
    init(movieRepository: MovieRepositoryProtocol) {
        self.movieRepository = movieRepository
    }
    
    func execute() async throws -> [Movie] {
        try await movieRepository.fetchPopularMovies()
    }
}
