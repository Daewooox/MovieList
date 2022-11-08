import UIKit
import SDWebImage

final class MovieListTableViewCell: UITableViewCell {

    @IBOutlet private var posterImageView: UIImageView!
    @IBOutlet private var rightImageView: UIImageView!
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var genreLabel: UILabel!
    @IBOutlet private var rateProgressView: UIProgressView!
    @IBOutlet private var rateLabel: UILabel!
    
    private let placeholderImage = UIImage(named: "imagePlaceholder")
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        posterImageView.image = nil
    }
    
    func configure(with model: MovieViewModel) {
        titleLabel.text = model.title
        genreLabel.text = model.genres
        rateLabel.text = String(model.rate)
        
        if let urlString = model.posterImagePath {
            posterImageView.sd_setImage(
                with: URL(string: urlString),
                placeholderImage: placeholderImage
            )
        } else {
            posterImageView.image = placeholderImage
        }
        rateProgressView.progress = Float(model.rate / 10.0)
    }
}

private extension MovieListTableViewCell {
    
    func setupUI() {
        selectionStyle = .none
        posterImageView.contentMode = .scaleAspectFill
        posterImageView.clipsToBounds = true
        posterImageView.tintColor = .gray
        rightImageView.image = UIImage(systemName: "chevron.right")
        rightImageView.tintColor = .gray
        rightImageView.contentMode = .scaleAspectFill
        titleLabel.font = .boldSystemFont(ofSize: 20)
        titleLabel.textColor = .white
        genreLabel.font = .systemFont(ofSize: 11)
        genreLabel.textColor = .gray
        rateLabel.textColor = .gray
        rateLabel.font = .systemFont(ofSize: 18)
    }
    
}
