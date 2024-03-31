//
//  NewsEntity+CoreDataProperties.swift
//  News App
//
//  Created by Jigar Shethia on 30/03/24.
//
//

import Foundation
import CoreData


extension NewsEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<NewsEntity> {
        return NSFetchRequest<NewsEntity>(entityName: "NewsEntity")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var title: String?
    @NSManaged public var newsDescription: String?
    @NSManaged public var date: Date?
    @NSManaged public var imageUrl: URL?

}

extension NewsEntity : Identifiable {

}
