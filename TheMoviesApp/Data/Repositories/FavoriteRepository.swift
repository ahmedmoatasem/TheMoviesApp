//
//  FavoriteRepository.swift
//  TheMoviesApp
//
//  Created by Ahmed Moatasem on 15/07/2025.
//

import Foundation

class FavoriteRepository: FavoriteRepositoryProtocol {
    private let storage: FavoriteStorage
    
    init(storage: FavoriteStorage) {
        self.storage = storage
    }
    
    func toggleFavorite(movieId: Int) async -> Bool {
        await storage.toggleFavorite(movieId: movieId)
    }
    
    func getFavorites() async -> [Int] {
        await storage.getFavorites()
    }
}
