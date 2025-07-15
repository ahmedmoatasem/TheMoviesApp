//
//  MoviesGridViewModel.swift
//  TheMoviesApp
//
//  Created by Ahmed Moatasem on 15/07/2025.
//

import Foundation

class MoviesGridViewModel {
    private let fetchMoviesUseCase: FetchMoviesUseCase
    private let toggleFavoriteUseCase: ToggleFavoriteUseCase
    private let getFavoritesUseCase: GetFavoritesUseCase
    
    @MainActor private(set) var movies: [Movie] = []
    @MainActor private(set) var favoriteIds: Set<Int> = []
    @MainActor private(set) var isLoading = false
    @MainActor private(set) var error: Error?
    
    init(
        fetchMoviesUseCase: FetchMoviesUseCase,
        toggleFavoriteUseCase: ToggleFavoriteUseCase,
        getFavoritesUseCase: GetFavoritesUseCase
    ) {
        self.fetchMoviesUseCase = fetchMoviesUseCase
        self.toggleFavoriteUseCase = toggleFavoriteUseCase
        self.getFavoritesUseCase = getFavoritesUseCase
    }
    
    @MainActor
    func loadMovies() async {
        isLoading = true
        error = nil
        
        do {
            async let moviesTask = fetchMoviesUseCase.execute()
            async let favoritesTask = getFavoritesUseCase.execute()
            
            let (fetchedMovies, favorites) = await (try moviesTask, favoritesTask)
            
            self.movies = fetchedMovies
            self.favoriteIds = Set(favorites)
        } catch {
            self.error = error
            print("Error fetching movies: \(error.localizedDescription)")
        }
        
        isLoading = false
    }
    
    @MainActor
    func toggleFavorite(movieId: Int) async -> Bool {
        let isFavorite = await toggleFavoriteUseCase.execute(movieId: movieId)
        
        if isFavorite {
            favoriteIds.insert(movieId)
        } else {
            favoriteIds.remove(movieId)
        }
        
        return isFavorite
    }
}
