import UIKit
import RxSwift
import SDWebImage

final class MovieDetailsViewController: UIViewController, BindableType {
    
    private enum Constants {
        static let rightBarButtonTitle = " 🏆"
    }
    
    @IBOutlet private var scrollView: UIScrollView!
    @IBOutlet private var posterImageView: UIImageView!
    @IBOutlet private var overviewLabel: UILabel!
    @IBOutlet private var overviewDescriptionLabel: UILabel!
    @IBOutlet private var castLabel: UILabel!
    @IBOutlet private var castDescriptionLabel: UILabel!
    
    var viewModel: MovieDetailsViewModel!
    private let disposeBag = DisposeBag()
    private let placeholderImage = UIImage(named: "imagePlaceholder")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func bindViewModel() {
        viewModel.output.movie
            .subscribe(with: self, onNext: { object, model in
                object.title = model.title
                let rateLabel = UILabel()
                rateLabel.text = "\(model.rate)" + Constants.rightBarButtonTitle
                rateLabel.font = .systemFont(ofSize: 18, weight: .semibold)
                rateLabel.textColor = .lightGray
                let voteAverageBarItem = UIBarButtonItem(customView: rateLabel)
                object.navigationItem.rightBarButtonItem = voteAverageBarItem
                
                if let urlString = model.posterImagePath {
                    object.posterImageView.sd_setImage(
                        with: URL(string: urlString),
                        placeholderImage: object.placeholderImage
                    )
                } else {
                    object.posterImageView.image = object.placeholderImage
                }
                object.overviewDescriptionLabel.text = model.overview
                object.castDescriptionLabel.text = model.cast
            }).disposed(by: disposeBag)
    }
    
}

private extension MovieDetailsViewController {
    
    func setupUI() {
        view.backgroundColor = .black
        overviewLabel.font = .boldSystemFont(ofSize: 32)
        overviewLabel.textColor = .white
        
        overviewDescriptionLabel.font = .systemFont(ofSize: 15)
        overviewDescriptionLabel.textColor = .lightGray
        overviewDescriptionLabel.numberOfLines = 0
        
        castLabel.font = .boldSystemFont(ofSize: 32)
        castLabel.textColor = .white
        
        castDescriptionLabel.font = .systemFont(ofSize: 15)
        castDescriptionLabel.textColor = .lightGray
        castDescriptionLabel.numberOfLines = 0
    }
    
}
