//
//  PopularTableViewController.swift
//  MovieApp


import UIKit

class PopularTableViewController: UITableViewController {
    
    var page = 1
    var needPagination = false
    var dataSource = [Movie]()
    var pagination: Pagination? {
        didSet {
            needPagination = pagination!.page < pagination!.totalPages
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchMovies()
    }
    
    func fetchMovies() {
        Movie.fetchPopular(page: page) { (movies, pagino) in
            DispatchQueue.main.sync {
                self.dataSource += movies
                self.pagination = pagino
                self.tableView.reloadData()
            }
        } failure: { (error) in
            print(error.localizedDescription)
        }

    }
    

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PopularTableViewCell", for: indexPath) as! PopularTableViewCell
        cell.movie = dataSource[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailsViewController.instantinate()
        vc.movie = dataSource[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let pagino = pagination else { return }
        if (pagino.page < pagino.totalPages) && scrollView.contentOffset.y >= (scrollView.contentSize.height - 500) && needPagination {
            needPagination = false
            page += 1
            fetchMovies()
        }
        
    }
    
}
