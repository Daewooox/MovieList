import UIKit
import RxSwift
import SDWebImage

class MovieDetailsViewController: UIViewController, BindableType {
    
    private enum Constants {
        static let rightBarButtonTitle = " 🏆"
    }
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var overviewDescriptionLabel: UILabel!
    @IBOutlet weak var castLabel: UILabel!
    @IBOutlet weak var castDescriptionLabel: UILabel!
    
    var viewModel: MovieDetailsViewModel!
    private let disposeBag = DisposeBag()
    private let placeholderImage = UIImage(systemName: "xmark")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func bindViewModel() {
        viewModel.output.movie
            .subscribe(onNext: { [unowned self] in
                self.title = $0.title
                let rateLabel = UILabel()
                rateLabel.text = "\($0.rate)" + Constants.rightBarButtonTitle
                rateLabel.font = .systemFont(ofSize: 18, weight: .semibold)
                rateLabel.textColor = .lightGray
                let voteAverageBarItem = UIBarButtonItem(customView: rateLabel)
                navigationItem.rightBarButtonItem = voteAverageBarItem
                
                if let urlString = $0.posterImagePath {
                    posterImageView.sd_setImage(
                        with: URL(string: urlString),
                        placeholderImage: placeholderImage
                    )
                } else {
                    posterImageView.image = placeholderImage
                }
                self.overviewDescriptionLabel.text = $0.overview
                self.castDescriptionLabel.text = $0.cast
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
