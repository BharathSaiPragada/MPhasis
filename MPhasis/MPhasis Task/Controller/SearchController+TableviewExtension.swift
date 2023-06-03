//
//  SearchController+TableviewExtension.swift
//  MPhasis Task
//
//  Created by Bharath Sai Pragada on 03/06/23.
//

import Foundation
import UIKit

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func setupTableView() {
        searchObject.resultTVOutlet.delegate = self
        searchObject.resultTVOutlet.dataSource = self
        searchObject.resultTVOutlet.backgroundColor = .clear
        
        self.registerCells()
    }
    
    func reloadTableView() {
        DispatchQueue.main.async {
            self.searchObject.resultTVOutlet.reloadData()
        }
    }
    
    func registerCells() {
        self.searchObject.resultTVOutlet.register(CustomTableViewCell.register(), forCellReuseIdentifier: CustomTableViewCell.identifier)
    }
    
    func animateWeatherPopupView(isDismiss: Bool) {
        if isDismiss {
            searchObject.weatherBottomLayout.constant = -2000
            if searchObject.switchObject.isOn {
                updateZipCodeViewUI()
            } else {
                updateCountryViewUI()
            }
        } else {
            searchObject.weatherBottomLayout.constant = 0
        }
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRows(in: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.identifier, for: indexPath) as? CustomTableViewCell else {
            return UITableViewCell()
        }
        cell.selectionStyle = .none
//        cell.contentView.backgroundColor = .clear
        cell.setupCell(viewModel: countriesData[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let country = countriesData[indexPath.row]
        print("name :", country.name)
        print("country lati :", country.lat)
        print("country lon :", country.lon)
        if weatherViewModel.validate(latitude: country.lat.description, longitude: country.lon.description) {
            weatherViewModel.getWeatherData(lati: country.lat.description, longi: country.lon.description)
        } else {
            //Please enter atleast both Latitude & Longitude
        }
    }
}


                                                                                           
