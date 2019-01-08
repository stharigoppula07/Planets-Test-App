//
//  PlanetListViewController.swift
//  PlanetsTestApp
//
//  Created by Sudhakar Tharigoppula on 07/01/19.
//  Copyright © 2019 Sudhakar Tharigoppula. All rights reserved.
//

import UIKit

class PlanetListViewController: UITableViewController {

    private var planetList: [Planet] = []
    private var currentPage = 1
    private var totalPages = 8

    private var shouldShowLoadingCell = false
    let planetListViewModel = PlanetListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        tableView.rowHeight = UITableView.automaticDimension
      if RequestHandler.sharedInstance.isReachable() {
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(refreshPlanets), for: .valueChanged)
        refreshControl?.beginRefreshing()
        loadPlanets()
      } else {
        planetListViewModel.fetchPlanetsList { (planetsList) in
          DispatchQueue.main.async {
            self.planetList = planetsList
            self.tableView.reloadData()
          }
        }
      }
    }
  
  
  /**
     Loads the Planets data from the API and reloads the tableview.
   
   - Parameter refresh: refresh the planets data when scroll reaches to end

   */
  
    private func loadPlanets(refresh: Bool = false) {
        planetListViewModel.fetchPlanetsList(page: currentPage) { (planetDetails) in
            DispatchQueue.main.async {
                if refresh {
                    self.planetList = planetDetails.results ??  []
                } else {
                    for planet in planetDetails.results ?? [] {
                        if !self.planetList.contains(where: { (item) -> Bool in
                            return planet.name == item.name
                        }) {
                            self.planetList.append(planet)
                        }
                    }
                    let pageChar:Character = (planetDetails.next ?? "").last ?? "1"
                    if let nextPage = Int(String(pageChar)) {
                        self.shouldShowLoadingCell = (nextPage-1) < self.totalPages
                    }
                }
                self.refreshControl?.endRefreshing()
                self.tableView.reloadData()
            }
        }
    }
  
  
  /**
     Fetch the next page planets data
   
     Loads the next page planets and acts like pagination
   */
    private func fetchNextPage() {
        currentPage += 1
        loadPlanets()
    }
  
  
  /**
   Refresh the first page contents, when reaches to top
  */
    @objc
    private func refreshPlanets() {
        currentPage = 1
        loadPlanets(refresh: true)
    }
    
    
    // MARK: - UITableViewDataSource
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = planetList.count
        return shouldShowLoadingCell ? count + 1 : count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if isLoadingIndexPath(indexPath) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "LoadingCell", for: indexPath) as! LoadingCell
            if currentPage < totalPages {
                cell.activityIndicator.startAnimating()
            }
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PlanetCell", for: indexPath) as! PlanetCell
            if indexPath.row < planetList.count {
                let planet = planetList[indexPath.row]
                cell.planetName.text = planet.name ?? ""
                cell.planetTerrain.text = planet.terrain ?? ""
            }
            return cell
        }
    }
    
    
    // MARK: UITableViewDelegate
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard isLoadingIndexPath(indexPath) else { return }
        if RequestHandler.sharedInstance.isReachable() {
          fetchNextPage()
        }
    }
    
    private func isLoadingIndexPath(_ indexPath: IndexPath) -> Bool {
        guard shouldShowLoadingCell else { return false }
        return indexPath.row == self.planetList.count
    }
}
