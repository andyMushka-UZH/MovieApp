//
//  DetailsViewController.swift
//  MovieApp


import UIKit
import CoreData

class DetailsViewController: UIViewController {
    
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet private weak var posterImageView: UIImageView!
    @IBOutlet private weak var ratingView: RaingView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var yearLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIBarButtonItem!
    
    var movie: Movie!
    var isFavorite = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let data = movie?.imageData {
            posterImageView.image = UIImage(data: data)
        } else {
            posterImageView.load(string: movie?.posterPath)
        }
        
        titleLabel.text = movie.title
        yearLabel.text = movie.releaseDate
        descriptionLabel.text = movie.overview
        
        
        isFavorite = Movie.fetchFromCoreData()?.contains { $0.id == movie.id } ?? false
        favoriteButton.image = UIImage(systemName: isFavorite ? "heart.fill" : "heart")
    }
    

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        ratingView.setRating(value: Int((movie.voteAverage ?? 0.0) * 10), with: true)
    }
    
    override func viewWillLayoutSubviews(){
        super.viewWillLayoutSubviews()
        var height = CGFloat()
        _ = scrollView.subviews.compactMap { view in
            height += view.frame.height
        }
        scrollView.contentSize.height = height
        scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 80, right: 0)
    }
    
    //MARK: - Actions
    
    @IBAction func favoriteAction(_ sender: UIBarButtonItem) {
        if isFavorite {
            removeFromFavorite()
        } else {
            saveToFavorite()
        }
        isFavorite.toggle()
        sender.image = UIImage(systemName: isFavorite ? "heart.fill" : "heart")
    }
    
    private func saveToFavorite() {
        guard let imageData = posterImageView.image?.jpegData(compressionQuality: 1.0) else { return }
        movie.saveToCoreData(imgData: imageData)
    }
    
    private func removeFromFavorite() {
        movie.removeFromCoreData()
    }
    
    
    //MARK: - instantinate
    
    class func instantinate() -> DetailsViewController {
        let identifier = String(describing: Self.self)
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let viewController = storyboard.instantiateViewController(identifier: identifier)
        return viewController as! DetailsViewController
    }
    
}
