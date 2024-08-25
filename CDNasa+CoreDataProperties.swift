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

}

extension CDNasa : Identifiable {

}
