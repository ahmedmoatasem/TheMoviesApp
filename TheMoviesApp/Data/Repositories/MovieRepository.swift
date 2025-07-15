//
//  MovieRepository.swift
//  TheMoviesApp
//
//  Created by Ahmed Moatasem on 15/07/2025.
//

import Foundation

class MovieRepository: MovieRepositoryProtocol {
    private let networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    func fetchPopularMovies() async throws -> [Movie] {
        do {
            let response: MovieResponseDTO = try await networkService.request(
                TMDBAPI.Endpoint.popularMovies,
                parameters: ["language": "en-US", "page": 1]
            )
            return MovieMapper.map(response.results)
        } catch {
            throw error 
        }
    }
}
