@testable import MovieList
import RxSwift

class MockMovieService: MovieServiceType {
    var getMovieListMock: Observable<[MovieModel]> = Observable.just(MockServiceFactory().makeMoviePageModel().movies)
    func getMovieList(with string: String?, page: Int) -> Observable<[MovieModel]> {
        getMovieListMock
    }
    
    var getGenresListMock: Observable<[GenreModel]> = Observable.just(MockServiceFactory().makeGenresListModel().genres)
    func getGenresList() -> Observable<[GenreModel]> {
        getGenresListMock
    }
    
    var getMovieCreditsMock: Observable<MovieCreditsModel> = Observable.just(MockServiceFactory().makeMovieCreditsList())
    func getMovieCredits(by id: String) -> Observable<MovieCreditsModel> {
        getMovieCreditsMock
    }
    
}
