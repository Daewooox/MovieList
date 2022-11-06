import UIKit
import XCoordinator

enum AppRoute: Route {
    case movieList
    case movieDetail(model: MovieViewModel)
}

class AppCoordinator: NavigationCoordinator<AppRoute> {
    
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
            let viewModel = MovieListViewModel(router: unownedRouter)
            viewController.bind(to: viewModel)
            return .push(viewController)
        case .movieDetail(let model):
            let viewController = R.storyboard.home.movieDetailsViewController()!
            let viewModel = MovieDetailsViewModel(router: unownedRouter, model: model)
            viewController.bind(to: viewModel)
            return .push(viewController)
        }
    }

}
