//
//  MovieListTableViewCell.swift
//  MovieList
//
//  Created by Alexander on 2.11.22.
//

import UIKit
import SDWebImage

class MovieListTableViewCell: UITableViewCell {

    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var rightImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var rateProgressView: UIProgressView!
    @IBOutlet weak var rateLabel: UILabel!
    
    private let placeholderImage = UIImage(systemName: "xmark")
    
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
