//
//  CDNasa+CoreDataProperties.swift
//  Walmart_Assessment
//
//  Created by Raghuram on 25/08/24.
//
//

import Foundation
import CoreData


extension CDNasa {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDNasa> {
        return NSFetchRequest<CDNasa>(entityName: "CDNasa")
    }

    @NSManaged public var date: String?
    @NSManaged public var explanation: String?
    @NSManaged public var hdurl: String?
    @NSManaged public var media_type: String?
    @NSManaged public var service_version: String?
    @NSManaged public var title: String?
    @NSManaged public var url: String?
    @NSManaged public var image: Data?
    @NSManaged public var id: UUID?

    func convertToNasaData() -> NasaData {
        return NasaData(date: self.date, explanation: self.explanation, hdurl: self.hdurl, media_type: self.media_type, service_version: self.service_version, title: self.title, url: self.url, id: self.id!, image: self.image)
    }

}

extension CDNasa : Identifiable {

}
