//
//  ToggleFavoriteUseCase.swift
//  TheMoviesApp
//
//  Created by Ahmed Moatasem on 15/07/2025.
//

import Foundation

class ToggleFavoriteUseCase {
    private let favoriteRepository: FavoriteRepositoryProtocol
    
    init(favoriteRepository: FavoriteRepositoryProtocol) {
        self.favoriteRepository = favoriteRepository
    }
    
    func execute(movieId: Int) async -> Bool {
        await favoriteRepository.toggleFavorite(movieId: movieId)
    }
}
