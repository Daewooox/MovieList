import UIKit
import XCoordinator
import Resolver

enum AppRoute: Route {
    case movieList
    case movieDetail(model: MovieViewModel)
}

class AppCoordinator: NavigationCoordinator<AppRoute> {
    @LazyInjected private var movieService: MovieService
    
    init() {
        super.init(initialRoute: .movieList)
        rootViewController.overrideUserInterfaceStyle = .dark
        rootViewController.navigationBar.tintColor = .orange
        let appearance = UINavigationBarAppearance()
        appearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        rootViewController.navigationBar.standardAppearance = appearance
        rootViewController.navigationBar.scrollEdgeAppearance = appearance
    }
    
    override func prepareTransition(for route: AppRoute) -> NavigationTransition {
        switch route {
        case .movieList:
            let viewController = R.storyboard.home.movieListViewController()!
            let viewModel = MovieListViewModel(router: unownedRouter, movieService: movieService)
            viewController.bind(to: viewModel)
            return .push(viewController)
        case .movieDetail(let model):
            let viewController = R.storyboard.home.movieDetailsViewController()!
            let viewModel = MovieDetailsViewModel(router: unownedRouter, model: model, movieService: movieService)
            viewController.bind(to: viewModel)
            return .push(viewController)
        }
    }

}
