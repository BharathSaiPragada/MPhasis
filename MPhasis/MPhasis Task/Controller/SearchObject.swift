//
//  SearchObject.swift
//  MPhasis Task
//
//  Created by Bharath Sai Pragada on 03/06/23.
//

import Foundation
import UIKit

class SearchObject: NSObject {
    // Header View Outlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var searchBTNOutlet: UIButton! {
        didSet {
            searchBTNOutlet.layer.cornerRadius = 25
            searchBTNOutlet.layer.borderColor = UIColor.white.cgColor
            searchBTNOutlet.layer.borderWidth = 1
        }
    }
    @IBOutlet weak var switchObject: UISwitch!
    @IBOutlet weak var cityNameView: UIView!
    @IBOutlet weak var zipCodeView: UIView!{
        didSet {
            zipCodeView.isHidden = true
        }
    }
    @IBOutlet weak var countryNameTF: UITextField!
    @IBOutlet weak var stateNameTF: UITextField!
    @IBOutlet weak var latitudeTF: UITextField!
    @IBOutlet weak var longitudeTF: UITextField!
    
    // TableView and Activity Components Outlets
    @IBOutlet weak var resultTVOutlet: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var weatherBottomLayout: NSLayoutConstraint! {
        didSet {
            weatherBottomLayout.constant = -2000
        }
    }
    
    // Weather View Components Outlets:
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var countryName: UILabel!
    @IBOutlet weak var latitudeLBL: UILabel!
    @IBOutlet weak var longitudeLBL: UILabel!
    @IBOutlet weak var weatherStatusLBL: UILabel!
    @IBOutlet weak var windSpeedLBL: UILabel!
    @IBOutlet weak var tempMiniLBL: UILabel!
    @IBOutlet weak var tempMaxLBL: UILabel!
    @IBOutlet weak var sunRiseLBL: UILabel!
    @IBOutlet weak var sunSetLBL: UILabel!
}
