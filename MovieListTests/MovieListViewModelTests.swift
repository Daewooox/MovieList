import XCTest
import RxSwift
import RxCocoa
import Action
@testable import MovieList

class MovieListViewModelTests: XCTestCase {
    private var sut: MovieListViewModel!
    private var service: MockMovieService!
    
    override func setUpWithError() throws {
        service = MockMovieService()
        sut = MovieListViewModel(router: AppCoordinator().unownedRouter, movieService: service)
    }

    func testMovieModel() {
        XCTAssertEqual(sut.genres.value, MockServiceFactory().makeGenresListModel().genres)
        sut.loadNextPageTrigger.onNext()
        XCTAssertEqual(sut.movies.value, MockServiceFactory().makeMoviePageModel().movies.map { MovieViewModel(movie: $0, genres: MockServiceFactory().makeGenresListModel().genres) })
    }
    
    func testMovieListViewModelEmpty() {
        service.getMovieListMock = Observable.just(MoviePageModel(page: 1, movies: [], totalPages: 0, totalResults: 0).movies)
        XCTAssertEqual(sut.movies.value.count, 0)
    }
    
}
