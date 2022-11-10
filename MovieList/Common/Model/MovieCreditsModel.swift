import Foundation

struct MovieCreditsModel: Codable {
    let id: Int
    let cast: [CastModel]
}

struct CastModel: Codable {
    let adult: Bool?
    let gender: Int?
    let id: Int?
    let name: String
    let originalName: String?
    let popularity: Double?
    let profilePath: String?
    let castId: Int?
    let character: String?
    let creditId: String?
    let order: Int?
}

extension MovieCreditsModel {
    var castDescription: String {
        cast.map { $0.name }.joined(separator: ", ")
    }
}
