//
//  FavoriteRepositoryProtocol.swift
//  TheMoviesApp
//
//  Created by Ahmed Moatasem on 15/07/2025.
//

import Foundation

protocol FavoriteRepositoryProtocol {
    func toggleFavorite(movieId: Int) async -> Bool
    func getFavorites() async -> [Int]
}
