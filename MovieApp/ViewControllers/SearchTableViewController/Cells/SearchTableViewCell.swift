//
//  SearchTableViewCell.swift
//  MovieApp

import UIKit

class SearchTableViewCell: UITableViewCell {
    
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieYearsLabel: UILabel!
    
    
    var movie: Movie? {
        didSet {
            movieTitleLabel.text = movie?.title
            movieYearsLabel.text = movie?.releaseDate
        }
    }

    
    override func prepareForReuse() {
        super.prepareForReuse()
        movieTitleLabel.text = nil
        movieYearsLabel.text = nil
    }
    
    
}
