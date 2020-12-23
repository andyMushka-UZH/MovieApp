//
//  MovieCoreData+CoreDataProperties.swift
//  MovieApp


import Foundation
import CoreData


extension MovieCoreData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MovieCoreData> {
        return NSFetchRequest<MovieCoreData>(entityName: "MovieCoreData")
    }

    @NSManaged public var id: Int64
    @NSManaged public var title: String?
    @NSManaged public var overview: String?
    @NSManaged public var releaseDate: String?
    @NSManaged public var posterPath: String?
    @NSManaged public var voteAverage: Float
    @NSManaged public var imageData: Data?

}

extension MovieCoreData : Identifiable {

}
