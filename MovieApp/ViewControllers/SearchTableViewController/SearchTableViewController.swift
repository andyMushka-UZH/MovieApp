//
//  SearchTableViewController.swift
//  MovieApp

import UIKit

class SearchTableViewController: UITableViewController {
    
    var searchText = String()
    var dataSource = [Movie]() {
        didSet {
            
            if dataSource.isEmpty && searchText.isEmpty {
                tableView.backgroundView = nil
                return
            }
            
            tableView.backgroundView = dataSource.isEmpty ? EmptyBackgroundView() : nil
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let seachController = UISearchController()
        seachController.searchBar.placeholder = "Search movie"
        seachController.searchBar.delegate = self
        self.navigationItem.searchController = seachController
        self.navigationItem.hidesSearchBarWhenScrolling = false
        
    }
    
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchTableViewCell", for: indexPath) as! SearchTableViewCell
        cell.movie = dataSource[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailsViewController.instantinate()
        vc.movie = dataSource[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }

}


extension SearchTableViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.searchText = searchText
        Movie.search(searchText: searchText) { (movies) in
            DispatchQueue.main.async {
                self.dataSource = movies
                self.tableView.reloadData()
            }
        } failure: { (error) in
            
        }

    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.text = self.searchText
    }

    
}
