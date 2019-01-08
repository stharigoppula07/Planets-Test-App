//
//  PlanetCell.swift
//  PlanetsTestApp
//
//  Created by Sudhakar Tharigoppula on 07/01/19.
//  Copyright © 2019 Sudhakar Tharigoppula. All rights reserved.
//

import UIKit

class PlanetCell: UITableViewCell {
    @IBOutlet weak var planetName: UILabel!
    @IBOutlet weak var planetTerrain: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
