import Foundation
import Moya
import RxSwift

final class NetworkManager {
    private var provider: MoyaProvider<APIService>
    
    private static var sharedNetworkManager: NetworkManager = { return NetworkManager() }()

    static func shared() -> NetworkManager {
        return sharedNetworkManager
    }
    
    init() {
        provider = MoyaProvider<APIService>()
    }
    
    func getMovieList(with string: String?, page: Int) -> Observable<[MovieModel]> {
        return provider.rx
            .request(string != nil ? .getMovieSearchList(page: page, searchString: string!) : .getMovieList(page: page))
            .filterSuccessfulStatusCodes()
            .map(MoviePageModel.self)
            .flatMap { .just($0.movies) }
            .asObservable()
    }
    
    func getGenresList() -> Observable<[GenreModel]> {
        return provider.rx.request(.getGenres)
            .filterSuccessfulStatusCodes()
            .map(GenresListModel.self)
            .flatMap { .just($0.genres)}
            .asObservable()
    }
    
    func getMovieCredits(by id: String) -> Observable<MovieCreditsModel> {
        return provider.rx.request(.getMovieCredits(id: id))
            .filterSuccessfulStatusCodes()
            .map(MovieCreditsModel.self)
            .asObservable()
    }
    
}
