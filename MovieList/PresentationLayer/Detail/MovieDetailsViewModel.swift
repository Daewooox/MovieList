import Action
import RxSwift
import RxCocoa
import XCoordinator

final class MovieDetailsViewModel: MovieDetailsViewModelProtocol, MovieDetailsViewModelInput, MovieDetailsViewModelOutput {

    private let router: UnownedRouter<AppRoute>
    private let disposeBag = DisposeBag()
    
    private(set) var movie: BehaviorRelay<MovieViewModel>
    private let movieService: MovieServiceType
    
    init(router: UnownedRouter<AppRoute>, model: MovieViewModel, movieService: MovieServiceType) {
        self.router = router
        self.movieService = movieService
        movie = BehaviorRelay<MovieViewModel>(value: model)
        fetchCast()
    }
}

private extension MovieDetailsViewModel {
    func fetchCast() {
        movieService.getMovieCredits(by: "\(movie.value.id)")
            .subscribe(with: self, onNext: { object, model in
                var movie = object.movie.value
                movie.cast = model.castDescription
                object.movie.accept(movie)
            }).disposed(by: disposeBag)
    }
}
