//
//  NetworkService.swift
//  MovieApp

import Foundation

class NetworkService {
    
    enum HTTPMethods: String {
        case post = "POST"
        case get = "GET"
    }
    
    static var shared = NetworkService()
    
    private let apiKey = "?api_key=30718b6be8ce0328e46f4fe9ae3cacae"
    private let baseURL = "https://api.themoviedb.org/3/"
    private let headers = [ "x-rapidapi-key": "5393136b45msh81bbd3fec033bf6p1438b9jsn3e0d6e5d0042",
                            "x-rapidapi-host": "imdb8.p.rapidapi.com"]
    
    
    func request(path: String,
                 query: String = "",
                 method: HTTPMethods,
                 params: Dictionary<String, Any>? = nil,
                 succsess: @escaping (Any?) -> (),
                 failure: @escaping (Error) -> ()) {
                
        guard let url = URL(string: baseURL + path + apiKey + query) else { return }
        var request = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = headers
        
        if let params = params {
            do {
                let httpData = try JSONSerialization.data(withJSONObject: params, options: .fragmentsAllowed)
                request.httpBody = httpData
            } catch {
                return
            }
        }
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            if let error = error {
                failure(error)
                return
            }
            
            if let JSONData = data,
               let JSON = try? JSONSerialization.jsonObject(with: JSONData, options: .allowFragments) {
                succsess(JSON)
                return
            }
            
            succsess(nil)
            
        }.resume()
    }
}

class BaseError: Error, LocalizedError {
    
    var title: String?
    var errorDescription: String?
        
    init(title: String, description: String) {
        self.errorDescription = NSLocalizedString(description, comment: title)
    }
        
}
 
