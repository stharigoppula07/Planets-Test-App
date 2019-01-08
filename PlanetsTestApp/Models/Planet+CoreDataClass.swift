//
//  Planet+CoreDataClass.swift
//  PlanetsTestApp
//
//  Created by Sudhakar Tharigoppula on 08/01/19.
//  Copyright © 2019 Sudhakar Tharigoppula. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Planet)
public class Planet: NSManagedObject {
  
  
  class func createPlanetEntityFrom(dictionary: [String: Any]) -> Planet? {
    
    let context = DatabaseManager.sharedInstance.persistentContainer.viewContext
    if let planetEntity = NSEntityDescription.insertNewObject(forEntityName: "Planet", into: context) as? Planet {
      
      planetEntity.name = dictionary["name"] as? String
      planetEntity.rotation_period = dictionary["rotation_period"] as? String
      planetEntity.orbital_period = dictionary["orbital_period"] as? String
      planetEntity.diameter = dictionary["diameter"] as? String
      planetEntity.climate = dictionary["climate"] as? String
      planetEntity.gravity = dictionary["gravity"] as? String
      planetEntity.terrain = dictionary["terrain"] as? String
      planetEntity.surface_water = dictionary["surface_water"] as? String
      planetEntity.population = dictionary["population"] as? String
      planetEntity.residents = dictionary["residents"] as? String
      planetEntity.films = dictionary["films"] as? String
      planetEntity.created = dictionary["created"] as? String
      planetEntity.edited = dictionary["edited"] as? String
      planetEntity.url = dictionary["url"] as? String
      return planetEntity
    }
    return nil
  }

}
