//
//  MovieService.swift
//  LoodosChallenge
//
//  Created by Oktay's Macbook on 8.11.2024.
//

import Foundation
import Alamofire

enum MovieServiceError: Error {
    case failedToFetchMovies(message: String)
}

class MovieService {
    
    internal enum Enpoint: String {
        case movies = "http://www.omdbapi.com/?s=#MovieName&apikey=37a87aab" // Possible movie array from service
        case movieDetail = "http://www.omdbapi.com/?t=#MovieName&apikey=37a87aab" // Detailed informations for movie
        
        func generateEndpoint(with name: String) -> String {
            return self.rawValue.replacingOccurrences(of: "#MovieName", with: name)
        }
    }
    
    func fetchMovies(with movieName: String) async throws -> Search {
        let endPoint = Enpoint.movies.generateEndpoint(with: movieName)
        let searchResponse = await AF.request(endPoint).serializingDecodable(Search.self).response
        // Handle AF error
        guard let search = searchResponse.value, searchResponse.error == nil else {
            throw MovieServiceError.failedToFetchMovies(message: "Failed to fetch movies for name: \(movieName) with error: \(searchResponse.error?.localizedDescription ?? "")")
        }
        return search
    }
}
