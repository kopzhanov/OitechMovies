import Foundation

struct MoviesResponse: Decodable {
    let movie_results: [Movie]
}

struct Movie: Decodable {
    let title: String
    let year: String
    let imdbID: String

    enum CodingKeys: String, CodingKey {
        case title
        case year
        case imdbID = "imdb_id"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.title = try container.decode(String.self, forKey: .title)

        
        if let intYear = try? container.decode(Int.self, forKey: .year) {
            self.year = String(intYear)
        } else {
            self.year = try container.decode(String.self, forKey: .year)
        }

        self.imdbID = try container.decode(String.self, forKey: .imdbID)
    }
}
