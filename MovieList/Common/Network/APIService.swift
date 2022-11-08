import Foundation
import Moya
import RxSwift

enum MovieAPIService {
    case getMovieList(page: Int)
    case getMovieCredits(id: String)
    case getGenres
    case getMovieSearchList(page: Int, searchString: String)
}

extension MovieAPIService: TargetType {
    var baseURL: URL {
        return APIUrl.baseUrl.apiUrl
    }
    var path: String {
        switch self {
        case .getMovieList:
            return "/movie/popular"
        case .getMovieCredits(let id):
            return "/movie/\(id)/credits"
        case .getGenres:
            return "/genre/movie/list"
        case .getMovieSearchList:
            return "/search/movie"
        }
    }
    var method: Moya.Method {
        return .get
    }
    var task: Task {
        var parameters = APIConstants.defaultParameters
        switch self {
        case .getMovieList(let page):
            parameters["page"] = "\(page)"
            return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
        case .getMovieSearchList(let page, let searchString):
            parameters["page"] = "\(page)"
            parameters["query"] = searchString
            return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
        case .getGenres, .getMovieCredits:
            return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
        }
    }
    var headers: [String : String]? {
        return ["Content-Type": "application/json", "Accept": "text/plain"]
    }
}
