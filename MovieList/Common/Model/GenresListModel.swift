import Foundation

struct GenresListModel: Codable {
    let genres: [GenreModel]
}

struct GenreModel: Codable, Equatable {
    let id: Int
    let name: String
}
