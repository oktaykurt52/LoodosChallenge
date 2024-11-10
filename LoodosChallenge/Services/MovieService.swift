//
//  MovieService.swift
//  LoodosChallenge
//
//  Created by Oktay's Macbook on 8.11.2024.
//

import Foundation
import Alamofire

enum MovieServiceError: Error {
    case movieTitleNotFound
    case failedToFetchMovies(message: String)
    case failedToFetchMovieDetail(message: String)
}

class MovieService {
    
    internal enum Enpoints: String {
        case movies = "http://www.omdbapi.com/?s=#MovieName&apikey=37a87aab" // Movie, serie and episode array from service
        case movieDetail = "http://www.omdbapi.com/?t=#MovieName&apikey=37a87aab" // Detailed informations for object
        
        func generateEndpoint(with name: String) -> String {
            return self.rawValue.replacingOccurrences(of: "#MovieName", with: name)
        }
    }
    
    func fetchMovies(with movieName: String) async throws -> Search {
        let endPoint = Enpoints.movies.generateEndpoint(with: movieName)
        let searchResponse = await AF.request(endPoint).serializingDecodable(Search.self).response
        // Handle AF error
        guard let search = searchResponse.value, searchResponse.error == nil else {
            throw MovieServiceError.failedToFetchMovies(message: "Failed to fetch movies for name: \(movieName) with error: \(searchResponse.error?.localizedDescription ?? "")")
        }
        return search
    }
    
    func fetchMovieDetail(with movie: Movie) async throws -> MovieDetail {
        guard let movieTitle = movie.title else {
            throw MovieServiceError.movieTitleNotFound
        }
        let endPoint = Enpoints.movieDetail.generateEndpoint(with: movieTitle)
        let movieResponse = await AF.request(endPoint).serializingDecodable(MovieDetail.self).response
        // Handle AF error
        guard let movie = movieResponse.value, movieResponse.error == nil else {
            throw MovieServiceError.failedToFetchMovieDetail(message: "Failed to fetch movie details for movie: \(movieTitle) with error: \(movieResponse.error?.localizedDescription ?? "")")
        }
        return movie
    }
}
