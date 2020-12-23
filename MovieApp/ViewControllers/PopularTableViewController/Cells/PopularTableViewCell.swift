//
//  PopularTableViewCell.swift
//  MovieApp


import UIKit

class PopularTableViewCell: UITableViewCell {

    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var yearLabel: UILabel!
    @IBOutlet private weak var posterImageView: UIImageView!
    @IBOutlet private weak var ratingView: RaingView!
    
    var movie: Movie? {
        didSet {
            titleLabel.text = movie?.title
            yearLabel.text = movie?.releaseDate
            ratingView.setRating(value: Int((movie?.voteAverage ?? 0.0)) * 10, with: false)
            if let data = movie?.imageData {
                posterImageView.image = UIImage(data: data)
            } else {
                posterImageView.load(string: movie?.posterPath)
            }
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
        yearLabel.text = nil
        posterImageView.image = nil
        ratingView.setRating(value: 0, with: false)
        ratingView.layoutSubviews()
    }


}
