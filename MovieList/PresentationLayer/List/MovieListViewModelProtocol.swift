import RxSwift
import RxCocoa

protocol MovieListViewModelInput {
    var loadNextPageTrigger: AnyObserver<Void> { get }
    var detailsTrigger: AnyObserver<MovieViewModel> { get }
}

protocol MovieListViewModelOutput {
    var movies: BehaviorRelay<[MovieViewModel]> { get }
    var searchString: BehaviorRelay<String> { get }
}

protocol MovieListViewModelProtocol {
    var input: MovieListViewModelInput { get }
    var output: MovieListViewModelOutput { get }
}

extension MovieListViewModelProtocol where Self: MovieListViewModelInput & MovieListViewModelOutput {
    var input: MovieListViewModelInput { return self }
    var output: MovieListViewModelOutput { return self }
}
