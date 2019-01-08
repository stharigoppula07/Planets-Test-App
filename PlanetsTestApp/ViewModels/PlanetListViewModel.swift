//
//  PlanetListViewModel.swift
//  PlanetsTestApp
//
//  Created by Sudhakar Tharigoppula on 07/01/19.
//  Copyright © 2019 Sudhakar Tharigoppula. All rights reserved.
//

import Foundation
import CoreData

class PlanetListViewModel {
  
    /**
     Planet GET API request
   
     - Parameter page: page number to be passed
     */
    func fetchPlanetsList(page:Int, completionHandler:@escaping ((PlanetDetails)->())) {

      let requestURL = "https://swapi.co/api/planets/?page=\(page)"
        RequestHandler.sharedInstance.requestDataFromUrl(urlName: requestURL,
                                                         httpMethodType: "GET",
                                                         body: [:]) { (responseData, err) in
            if let responseDict = responseData {
                    //Parsing Json and saving into the database
                    let context = DatabaseManager.sharedInstance.persistentContainer.viewContext
                    if let planetDetails = NSEntityDescription.insertNewObject(forEntityName: "PlanetDetails", into: context) as? PlanetDetails {
                        planetDetails.count = responseDict["count"] as? Int64 ?? 0
                        planetDetails.next = responseDict["next"] as? String ?? ""
                        planetDetails.previous = responseDict["previous"] as? String ?? ""
                        let planetList = responseDict["results"] as? [[String:Any]] ?? []
                        planetDetails.results = self.saveInCoreDataWith(array: planetList)
                        do {
                          try context.save()
                        } catch _ { print("Error saving data") }
                        completionHandler(planetDetails)
                    }

            }
        }
    }
  
    /**
     Save Planets Data in database
   
     Parse the array of planets to createPlanetEntityFrom method, which will create Planet Manged Object and save in the database
     */
    private func saveInCoreDataWith(array: [[String: Any]])->[Planet] {
        let planetList = array.map{Planet.createPlanetEntityFrom(dictionary: $0)}
        do {
            try DatabaseManager.sharedInstance.persistentContainer.viewContext.save()
        } catch let error {
            print(error)
        }
        return planetList as! [Planet]
    }
  
  
    /**
      Fecth the Planets data from the databse
   
      ## Important Notes ##
      1. Initialize Fetch Request
      2. Create Entity Description
      3. Configure Fetch Request
      4. Fetch the records using fetch request
    */
    func fetchPlanetsList(completionHandler:@escaping (([Planet])->())) {
      
      // Initialize Fetch Request
      let fetchRequest = NSFetchRequest<NSFetchRequestResult>()
      let context =  DatabaseManager.sharedInstance.persistentContainer.viewContext
      
      // Create Entity Description
      let entityDescription = NSEntityDescription.entity(forEntityName: "Planet", in: context)
      
      // Configure Fetch Request
      fetchRequest.entity = entityDescription
      
      do {
        if let result = try context.fetch(fetchRequest) as? [Planet] {
          completionHandler(result)
        }
      } catch let error as NSError {
        print("Could not fetch. \(error), \(error.userInfo)")
      }
    }
    
}
