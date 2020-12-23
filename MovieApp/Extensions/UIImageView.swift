//
//  UIImageView.swift
//  MovieApp

import UIKit

extension UIImageView {
    
    enum Path {
        static let base = "https://image.tmdb.org/t/p/original/"
    }
        
    func load(string: String?) {
        if let string = string,
           let url = URL(string: Path.base + string) {
            DispatchQueue.global().async { [weak self] in
                if let data = try? Data(contentsOf: url) {
                    if let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            self?.image = image
                        }
                    }
                }
            }
        }
    }
}
