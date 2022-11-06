import Foundation
import UIKit
import RxSwift

class MovieListViewController: UIViewController, BindableType {
    
    private enum Constants {
        static let navTitle = "🍿 Movies"
        static let searchPlaceholderTitle = "Search"
        
        static let rowHeight: CGFloat = 120
        static let tableViewCornerRadius: CGFloat = 10
        static let searchBarTimeUpdate = 500
    }
    
    private let disposeBag = DisposeBag()
    var viewModel: MovieListViewModel!
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    func bindViewModel() {
        viewModel.output.movies
            .bind(to: tableView.rx.items(cellIdentifier: R.reuseIdentifier.movieListTableViewCell.identifier,
                                         cellType: MovieListTableViewCell.self)) { (_, item, cell) in
                cell.configure(with: item)
            }.disposed(by: disposeBag)
        tableView.rx.reachedBottom()
            .bind(to: viewModel.input.loadNextPageTrigger)
            .disposed(by: disposeBag)
        tableView.rx.didScroll
            .subscribe(onNext: { [unowned self] in
                self.view.endEditing(true)
            }).disposed(by: disposeBag)
        tableView.rx.modelSelected(MovieViewModel.self)
            .bind(to: viewModel.input.detailsTrigger)
            .disposed(by: disposeBag)
        searchBar.rx.text
            .orEmpty
            .distinctUntilChanged()
            .debounce(RxTimeInterval.milliseconds(Constants.searchBarTimeUpdate), scheduler: MainScheduler.instance)
            .bind(to: viewModel.output.searchString)
            .disposed(by: disposeBag)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

private extension MovieListViewController {
    
    func setupUI() {
        title = Constants.navTitle
        setupSearchBar()
        setupTableView()
    }
    
    func setupSearchBar() {
        searchBar.tintColor = .lightGray
        searchBar.barTintColor = .black
        searchBar.searchBarStyle = .default
        searchBar.searchTextField.textColor = .lightGray
        searchBar.placeholder = Constants.searchPlaceholderTitle
    }
    
    func setupTableView() {
        tableView.registerCell(type: MovieListTableViewCell.self)
        tableView.tableHeaderView = UIView()
        tableView.separatorColor = .gray
        tableView.backgroundColor = .black
        tableView.clipsToBounds = true
        tableView.layer.cornerRadius = Constants.tableViewCornerRadius
        tableView.rowHeight = Constants.rowHeight
    }
    
}
