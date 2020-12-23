//
//  Movie.swift
//  MovieApp


import UIKit
import CoreData

class Movie: BaseModel {
    
    var id: Int?
    var title: String?
    var overview: String?
    var releaseDate: String?
    var posterPath: String?
    var voteAverage: Float?
    var imageData: Data?
    
    init(movie: MovieCoreData) {
        
        id = Int(movie.id)
        title = movie.title
        releaseDate = movie.releaseDate
        voteAverage = movie.voteAverage
        overview = movie.overview
        imageData = movie.imageData
    }
}

// MARK: - API

extension Movie {
    
    enum Path {
        static let topRated = "movie/top_rated"
        static let popular = "movie/popular"
        static let details = "movie/%@"
        static let search = "search/movie"
    }
    
    class func fetchPopular(page: Int, success: @escaping ([Movie], Pagination) -> (), failure: @escaping (Error) -> ()) {
        NetworkService.shared.request(path: Path.popular, query: "&page=\(page)", method: .get, succsess: { (response) in
            if let response = response as? [String: Any],
               let pagino = Pagination(JSON: response),
               let results = response["results"] as? [[String: Any]] {
                
                let movies = results.compactMap { Movie(JSON: $0) }
                success(movies, pagino)
            }
        }, failure: failure)
    }
    
    class func fetchTopRated(success: @escaping ([Movie]) -> (), failure: @escaping (Error) -> ()) {
        NetworkService.shared.request(path: Path.topRated, method: .get, succsess: { (response) in
            if let response = response as? [String: Any],
               let results = response["results"] as? [[String: Any]] {
                let movies = results.compactMap { Movie(JSON: $0) }
                success(movies)
            }
        }, failure: failure)
    }
    
    class func search(searchText: String, success: @escaping ([Movie]) -> (), failure: @escaping (Error) -> ()) {
        let query = "&query=\(searchText)"
        NetworkService.shared.request(path: Path.search, query: query, method: .get, succsess: { (response) in
            if let response = response as? [String: Any],
               let results = response["results"] as? [[String: Any]] {
                let movies = results.compactMap { Movie(JSON: $0) }
                success(movies)
            } else {
                success([])
            }
        }, failure: failure)
        
    }
    
}

// MARK: - CoreData
 
extension Movie {

    class func fetchFromCoreData() -> [Movie]? {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<MovieCoreData> = MovieCoreData.fetchRequest()
        
        do {
            let favorites = try context.fetch(fetchRequest)
            let movies = favorites.compactMap { Movie(movie: $0) }
            return movies
        } catch _ as NSError {
            return nil
        }
    }
    
    func saveToCoreData(imgData: Data) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        guard let entity = NSEntityDescription.entity(forEntityName: "MovieCoreData", in: context) else { return }
        let movieObject = MovieCoreData(entity: entity, insertInto: context)
    
        movieObject.id = Int64(id!)
        movieObject.title = title
        movieObject.releaseDate = releaseDate
        movieObject.voteAverage = voteAverage!
        movieObject.overview = overview
        movieObject.imageData = imgData
        
        do {
            try context.save()
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    func removeFromCoreData() {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<MovieCoreData> = MovieCoreData.fetchRequest()
        if let movies = try? context.fetch(fetchRequest) {
            let movie = movies.first { $0.id == Int64(id!) }
            if let movie = movie {
                context.delete(movie)
            }
        }
        
        do {
            try context.save()
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        
    }
    
}

