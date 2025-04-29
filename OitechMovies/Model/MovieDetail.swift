import Foundation

struct MovieDetail: Decodable {
    let title: String
    let description: String
    let tagline: String?
    let year: String
    let imdb_rating: String?
    let genres: [String]?
    let directors: [String]?
    let stars: [String]?
}
