import Foundation

struct TrendingMoviesResponse: Decodable {
    let movie_results: [Movie]
}

struct Movie: Decodable {
    let title: String
    let year: String
    let imdb_id: String
}
