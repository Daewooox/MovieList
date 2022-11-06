import RxSwift
import RxCocoa

protocol MovieDetailsViewModelInput { }

protocol MovieDetailsViewModelOutput {
    var movie: BehaviorRelay<MovieViewModel> { get }
}

protocol MovieDetailsViewModelProtocol {
    var input: MovieDetailsViewModelInput { get }
    var output: MovieDetailsViewModelOutput { get }
}

extension MovieDetailsViewModelProtocol where Self: MovieDetailsViewModelInput & MovieDetailsViewModelOutput {
    var input: MovieDetailsViewModelInput { return self }
    var output: MovieDetailsViewModelOutput { return self }
}
