//
//  MovieRepositoryProtocol.swift
//  TheMoviesApp
//
//  Created by Ahmed Moatasem on 15/07/2025.
//

import Foundation

protocol MovieRepositoryProtocol {
    func fetchPopularMovies() async throws -> [Movie]
}
