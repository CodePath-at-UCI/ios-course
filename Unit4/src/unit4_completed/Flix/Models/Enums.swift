//
//  Enums.swift
//  Flix
//
//  Created by Chase Carnaroli on 2/4/20.
//

import Foundation

enum Cell: String {
    case MovieCell, MovieGridCell
}

enum MovieBaseURL: String {
    case NowPlaying = "https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed"
    case SuperHeroes = "https://api.themoviedb.org/3/movie/297762/similar?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed"
    case Poster = "https://image.tmdb.org/t/p/w185"
    case Backdrop = "https://image.tmdb.org/t/p/w780"
}
