//
//  Planet+CoreDataProperties.swift
//  PlanetsTestApp
//
//  Created by Sudhakar Tharigoppula on 08/01/19.
//  Copyright © 2019 Sudhakar Tharigoppula. All rights reserved.
//
//

import Foundation
import CoreData


extension Planet {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Planet> {
        return NSFetchRequest<Planet>(entityName: "Planet")
    }

    @NSManaged public var name: String?
    @NSManaged public var rotation_period: String?
    @NSManaged public var orbital_period: String?
    @NSManaged public var diameter: String?
    @NSManaged public var climate: String?
    @NSManaged public var gravity: String?
    @NSManaged public var terrain: String?
    @NSManaged public var surface_water: String?
    @NSManaged public var population: String?
    @NSManaged public var residents: String?
    @NSManaged public var films: String?
    @NSManaged public var created: String?
    @NSManaged public var edited: String?
    @NSManaged public var url: String?

}
