//
//  FavoriteTableViewController.swift
//  MovieApp


import UIKit

class FavoriteTableViewController: UITableViewController {
    
    var placeholder = EmptyBackgroundView()
    
    var dataSource = [Movie]() {
        didSet {
            tableView.backgroundView = dataSource.isEmpty ? placeholder : nil
            tableView.separatorStyle = dataSource.isEmpty ? .none : .singleLine
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        placeholder.config(img: #imageLiteral(resourceName: "ic_broke_heart"), description: "You have not added any films to your favorites")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        dataSource = Movie.fetchFromCoreData() ?? []
        tableView.reloadData()
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
 
}
