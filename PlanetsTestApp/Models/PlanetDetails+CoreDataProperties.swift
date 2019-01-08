//
//  PlanetDetails+CoreDataProperties.swift
//  PlanetsTestApp
//
//  Created by Sudhakar Tharigoppula on 08/01/19.
//  Copyright © 2019 Sudhakar Tharigoppula. All rights reserved.
//
//

import Foundation
import CoreData


extension PlanetDetails {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PlanetDetails> {
        return NSFetchRequest<PlanetDetails>(entityName: "PlanetDetails")
    }

    @NSManaged public var count: Int64
    @NSManaged public var next: String?
    @NSManaged public var previous: String?
    @NSManaged public var results: [Planet]?

}
