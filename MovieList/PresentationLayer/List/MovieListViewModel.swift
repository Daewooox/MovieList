import Action
import RxSwift
import RxCocoa
import XCoordinator
import Resolver

final class MovieListViewModel: MovieListViewModelProtocol, MovieListViewModelInput, MovieListViewModelOutput {
       
    private(set) lazy var loadNextPageTrigger = loadNextPageAction.inputs
    private(set) lazy var detailsTrigger = detailsAction.inputs
    
    private lazy var loadNextPageAction = CocoaAction(enabledIf: genresUpdated.asObservable()) { [unowned self] in
        if (self.movies.value.count <= maxMoviesCount && searchString.value.isEmpty) || !searchString.value.isEmpty {
            self.pageCounter += 1
            self.fetchMovies(for: searchString.value)
        }
        return .empty()
    }
    
    private lazy var detailsAction = Action<MovieViewModel, Void> { [unowned self] model in
        self.router.rx.trigger(.movieDetail(model: model))
    }
    
    private(set) lazy var movies = BehaviorRelay<[MovieViewModel]>(value: [])
    private(set) lazy var genres = BehaviorRelay<[GenreModel]>(value: [])
    private(set) lazy var searchString = BehaviorRelay<String>(value: "")
    
    private let genresUpdated = BehaviorRelay<Bool>(value: false)
    private var pageCounter = 0
    private let maxMoviesCount = 100
    
    private let router: UnownedRouter<AppRoute>
    private let disposeBag = DisposeBag()
    private let movieService: MovieServiceType
    
    init(router: UnownedRouter<AppRoute>, movieService: MovieServiceType) {
        self.router = router
        self.movieService = movieService
        searchString.asObservable()
            .skip(1)
            .subscribe(with: self, onNext: { object, model in
                object.resetData()
                object.fetchMovies(for: model)
            }).disposed(by: disposeBag)
        fetchGenres()
    }
}

private extension MovieListViewModel {
    
    func resetData() {
        pageCounter = 1
        movies.accept([])
    }
    
    func fetchMovies(for string: String) {
        movieService.getMovieList(with: string.isEmpty ? nil : string, page: pageCounter)
            .subscribe(with: self, onNext: { object, model in
                object.movies.accept(object.movies.value + model.map { MovieViewModel(movie: $0, genres: object.genres.value) })
            }).disposed(by: disposeBag)
    }
    
    func fetchGenres() {
        movieService.getGenresList()
            .subscribe(with: self, onNext: { object, model in
                object.genres.accept(model)
                object.genresUpdated.accept(true)
            }).disposed(by: disposeBag)
    }
}
