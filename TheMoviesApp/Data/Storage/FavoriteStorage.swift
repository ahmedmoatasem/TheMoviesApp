//
//  FavoriteStorage.swift
//  TheMoviesApp
//
//  Created by Ahmed Moatasem on 15/07/2025.
//

import Foundation

actor FavoriteStorage {
    private var favorites: Set<Int>
    private let userDefaults: UserDefaults
    private let key = "favorite_movies"
    
    init(userDefaults: UserDefaults = .standard) {
        let array = userDefaults.array(forKey: key) as? [Int] ?? []
        self.favorites = Set(array)
        self.userDefaults = userDefaults
    }
    
    func toggleFavorite(movieId: Int) -> Bool {
        if favorites.contains(movieId) {
            favorites.remove(movieId)
        } else {
            favorites.insert(movieId)
        }
        userDefaults.set(Array(favorites), forKey: key)
        return favorites.contains(movieId)
    }
    
    func getFavorites() -> [Int] {
        Array(favorites)
    }
}
