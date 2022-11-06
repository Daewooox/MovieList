import Foundation

struct APIConstants {
    static let apiKey = "815b63b537c380370911f6cb083031b0"
    static let defaultParameters: [String: Any] = ["api_key": APIConstants.apiKey, "language": "en-US"]
}

enum APIUrl {
    case baseUrl
    case imageUrl

    var apiUrl: URL {
        switch self {
        case .baseUrl:
            return URL(string: "https://api.themoviedb.org/3")!
        case .imageUrl:
            return URL(string: "https://image.tmdb.org/t/p/w500")!
        }
    }
}
