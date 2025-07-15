//
//  TMDBAPI.swift
//  TheMoviesApp
//
//  Created by Ahmed Moatasem on 15/07/2025.
//

import Foundation


enum TMDBAPI {
    static let baseURL = "https://api.themoviedb.org/3/"
    static let imageBaseURL = "https://image.tmdb.org/t/p/w500"
    static let apiKey = "aa9dd135e310134daccbb02f06ad6168"
    
    enum Endpoint {
        static let popularMovies = "movie/popular"
    }
    
    enum ErrorMessage {
        static let networkError = "Network request failed"
        static let decodingError = "Failed to decode response"
    }
}
