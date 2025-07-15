//
//  MovieResponseDTO.swift
//  TheMoviesApp
//
//  Created by Ahmed Moatasem on 15/07/2025.
//

import Foundation

struct MovieResponseDTO: Decodable {
    let results: [MovieDTO]
}
