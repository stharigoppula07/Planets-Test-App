//
//  LoadingCell.swift
//  PlanetsTestApp
//
//  Created by Sudhakar Tharigoppula on 07/01/19.
//  Copyright © 2019 Sudhakar Tharigoppula. All rights reserved.
//

import UIKit

class LoadingCell: UITableViewCell {

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
}
