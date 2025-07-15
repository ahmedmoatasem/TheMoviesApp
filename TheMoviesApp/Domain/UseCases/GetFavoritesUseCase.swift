//
//  GetFavoritesUseCase.swift
//  TheMoviesApp
//
//  Created by Ahmed Moatasem on 15/07/2025.
//

import Foundation

class GetFavoritesUseCase {
    private let favoriteRepository: FavoriteRepositoryProtocol
    
    init(favoriteRepository: FavoriteRepositoryProtocol) {
        self.favoriteRepository = favoriteRepository
    }
    
    func execute() async -> [Int] {
        await favoriteRepository.getFavorites()
    }
}
