//
//  MovieMapper.swift
//  TheMoviesApp
//
//  Created by Ahmed Moatasem on 15/07/2025.
//

import Foundation

struct MovieMapper {
    static func map(_ dto: MovieDTO) -> Movie {
        Movie(
            id: dto.id,
            title: dto.title,
            overview: dto.overview,
            posterPath: dto.posterPath,
            releaseDate: dto.releaseDate,
            voteAverage: dto.voteAverage
        )
    }
    
    static func map(_ dtos: [MovieDTO]) -> [Movie] {
        dtos.map { map($0) }
    }
}
