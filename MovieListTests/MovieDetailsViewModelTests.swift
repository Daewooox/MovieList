import XCTest
import RxSwift

@testable import MovieList

class MovieDetailsViewModelTests: XCTestCase {

    private var sut: MovieDetailsViewModel!
   
    private var service: MockMovieService!

    override func setUpWithError() throws {
        service = MockMovieService()
        sut = MovieDetailsViewModel(router: AppCoordinator().unownedRouter, model: MockServiceFactory().makeMoviePageModel().movies.map { MovieViewModel(movie: $0, genres: MockServiceFactory().makeGenresListModel().genres) }.first!, movieService: service)
    }

    func testCreditsModel() {
        XCTAssertEqual(sut.movie.value.cast, MockServiceFactory().makeMovieCreditsList().castDescription)
    }
    
}
