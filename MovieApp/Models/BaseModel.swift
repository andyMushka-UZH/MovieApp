//
//  BaseModel.swift
//  MovieApp


import Foundation

protocol BaseModel: Codable {}

extension BaseModel {
 
    func toJSON() -> [String: Any]? {
        do {
            let jsonData = try JSONEncoder().encode(self)
            let json = try JSONSerialization.jsonObject(with: jsonData, options: .allowFragments)
            return json as? [String: Any]
        } catch {
            return nil
        }
    }
        
    internal init?(JSON: [String: Any]) {
        
        do {
            
            let jsonData = try JSONSerialization.data(withJSONObject: JSON, options: .fragmentsAllowed)
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let model = try decoder.decode(Self.self, from: jsonData)
            self = model
        } catch {
            return nil
        }
        
    }
    
}
