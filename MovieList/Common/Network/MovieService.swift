import Foundation
import Moya
import RxSwift

protocol MovieServiceType {
    func getMovieList(with string: String?, page: Int) -> Observable<[MovieModel]>
    
    func getGenresList() -> Observable<[GenreModel]>
    
    func getMovieCredits(by id: String) -> Observable<MovieCreditsModel>
}

final class MovieService: MovieServiceType {
    private let provider: MoyaProvider<MovieAPIService>
    
    private static var sharedService: MovieService = { return MovieService() }()

    static func shared() -> MovieService {
        return sharedService
    }
    
    init() {
        provider = MoyaProvider<MovieAPIService>()
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
