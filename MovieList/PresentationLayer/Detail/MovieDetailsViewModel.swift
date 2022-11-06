import Action
import RxSwift
import RxCocoa
import XCoordinator
import Resolver

class MovieDetailsViewModel: MovieDetailsViewModelProtocol, MovieDetailsViewModelInput, MovieDetailsViewModelOutput {

    private let router: UnownedRouter<AppRoute>
    private let disposeBag = DisposeBag()
    
    private(set) var movie: BehaviorRelay<MovieViewModel>
    @LazyInjected private var networkManager: NetworkManager

    init(router: UnownedRouter<AppRoute>, model: MovieViewModel) {
        self.router = router
        movie = BehaviorRelay<MovieViewModel>(value: model)
        fetchCast()
    }
}

private extension MovieDetailsViewModel {
    func fetchCast() {
        networkManager.getMovieCredits(by: "\(movie.value.id)")
            .subscribe(onNext: { [unowned self] in
                var movie = self.movie.value
                movie.cast = $0.castDescription
                self.movie.accept(movie)
            }).disposed(by: disposeBag)
    }
}
