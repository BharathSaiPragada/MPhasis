//
//  CustomTableViewCell.swift
//  MPhasis Task
//
//  Created by Bharath Sai Pragada on 03/06/23.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    @IBOutlet weak var countryNameLBL: UILabel!
    @IBOutlet weak var countryLatiLBL: UILabel!
    @IBOutlet weak var countryLongLBL: UILabel!
    
    static var identifier: String {
        get {
            "CustomTableViewCell"
        }
    }
    
    static func register() -> UINib {
        UINib(nibName: "CustomTableViewCell", bundle: nil)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupCell(viewModel: CustomTableCellViewModel) {
        self.countryNameLBL.text = viewModel.name
        self.countryLatiLBL.text = "Latitude: "+viewModel.lat.description
        self.countryLongLBL.text = "Longitude: "+viewModel.lon.description
    }
}
