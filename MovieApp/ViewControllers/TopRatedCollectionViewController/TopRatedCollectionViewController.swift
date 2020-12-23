//
//  TopRatedCollectionViewController.swift
//  MovieApp


import UIKit


class TopRatedCollectionViewController: UICollectionViewController {
    
    var dataSource = [Movie]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        Movie.fetchTopRated { (movies) in
            DispatchQueue.main.sync {
                self.dataSource = movies
                self.collectionView.reloadData()
            }
        } failure: { (error) in
            print(error.localizedDescription)
        }

    }


    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TopRatedCollectionViewCell", for: indexPath) as! TopRatedCollectionViewCell
        cell.movie = dataSource[indexPath.row]
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = DetailsViewController.instantinate()
        vc.movie = dataSource[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }

}


