//
//  DependencyContainer.swift
//  TheMoviesApp
//
//  Created by Ahmed Moatasem on 15/07/2025.
//

import Foundation


protocol DependencyFactory {
    func makeMoviesGridViewController() -> MoviesGridViewController
    func makeMovieDetailsViewController(movie: Movie) -> MovieDetailsViewController
}

final class AppDependencyFactory: DependencyFactory {
    private let networkService: NetworkServiceProtocol
    private let favoriteStorage: FavoriteStorage
    private let movieRepository: MovieRepositoryProtocol
    private let favoriteRepository: FavoriteRepositoryProtocol
    private let fetchMoviesUseCase: FetchMoviesUseCase
    private let toggleFavoriteUseCase: ToggleFavoriteUseCase
    private let getFavoritesUseCase: GetFavoritesUseCase
    
    init() {
        // Initialize services
        networkService = NetworkService(baseURL: TMDBAPI.baseURL, apiKey: TMDBAPI.apiKey)
        favoriteStorage = FavoriteStorage()
        
        // Initialize repositories
        movieRepository = MovieRepository(networkService: networkService)
        favoriteRepository = FavoriteRepository(storage: favoriteStorage)
        
        // Initialize use cases
        fetchMoviesUseCase = FetchMoviesUseCase(movieRepository: movieRepository)
        toggleFavoriteUseCase = ToggleFavoriteUseCase(favoriteRepository: favoriteRepository)
        getFavoritesUseCase = GetFavoritesUseCase(favoriteRepository: favoriteRepository)
    }
    
    func makeMoviesGridViewController() -> MoviesGridViewController {
        let viewModel = MoviesGridViewModel(
            fetchMoviesUseCase: fetchMoviesUseCase,
            toggleFavoriteUseCase: toggleFavoriteUseCase,
            getFavoritesUseCase: getFavoritesUseCase
        )
        return MoviesGridViewController(viewModel: viewModel)
    }
    
    func makeMovieDetailsViewController(movie: Movie) -> MovieDetailsViewController {
        let viewModel = MovieDetailsViewModel(movie: movie)
        return MovieDetailsViewController(viewModel: viewModel)
    }
}
