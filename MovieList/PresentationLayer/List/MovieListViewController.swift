import Foundation
import UIKit
import RxSwift

final class MovieListViewController: UIViewController, BindableType {
    
    private enum Constants {
        static let navTitle = "🍿 Movies"
        static let searchPlaceholderTitle = "Search"
        
        static let rowHeight: CGFloat = 120
        static let tableViewCornerRadius: CGFloat = 10
        static let searchBarTimeUpdate = 500
    }
    
    private let disposeBag = DisposeBag()
    var viewModel: MovieListViewModel!
    
    @IBOutlet private var tableView: UITableView!
    @IBOutlet private var searchBar: UISearchBar!
    @IBOutlet private var noResultsLabel: UILabel!
    
    func bindViewModel() {
        viewModel.output.movies
            .do(onNext: { [unowned self] in
                self.noResultsLabel.isHidden = (!$0.isEmpty && !self.viewModel.output.searchString.value.isEmpty)
                || self.viewModel.output.searchString.value.isEmpty
            }).bind(to: tableView.rx.items(cellIdentifier: R.reuseIdentifier.movieListTableViewCell.identifier,
                                           cellType: MovieListTableViewCell.self)) { (_, item, cell) in
                cell.configure(with: item)
            }.disposed(by: disposeBag)
        tableView.rx.reachedBottom()
            .bind(to: viewModel.input.loadNextPageTrigger)
            .disposed(by: disposeBag)
        tableView.rx.didScroll
            .subscribe(with: self, onNext: { object, _ in
                object.view.endEditing(true)
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
        navigationItem.backBarButtonItem = UIBarButtonItem(title: Constants.navTitle, style: .plain, target: nil, action: nil)
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
        tableView.layoutMargins = UIEdgeInsets(top: .zero, left: 8, bottom: .zero, right: 8)
    }
    
}
