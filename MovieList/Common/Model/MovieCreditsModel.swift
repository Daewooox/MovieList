import Foundation

struct MovieCreditsModel: Codable {
    let id: Int
    let cast: [CastModel]
}

struct CastModel: Codable {
    let adult: Bool?
    let gender: Int?
    let id: Int?
    let knownForDepartment: DepartmentModel?
    let name: String
    let originalName: String?
    let popularity: Double?
    let profilePath: String?
    let castId: Int?
    let character: String?
    let creditId: String?
    let order: Int?

    enum CodingKeys: String, CodingKey {
        case adult, gender, id, name, popularity, character, order
        case knownForDepartment = "known_for_department"
        case originalName = "original_name"
        case profilePath = "profile_path"
        case castId = "cast_id"
        case creditId = "credit_id"
    }
}

enum DepartmentModel: String, Codable {
    case acting = "Acting"
    case art = "Art"
    case camera = "Camera"
    case costumeMakeUp = "Costume & Make-Up"
    case crew = "Crew"
    case directing = "Directing"
    case editing = "Editing"
    case lighting = "Lighting"
    case production = "Production"
    case sound = "Sound"
    case visualEffects = "Visual Effects"
    case writing = "Writing"
}

extension MovieCreditsModel {
    var castDescription: String {
        cast.map { $0.name }.joined(separator: ", ")
    }
}
